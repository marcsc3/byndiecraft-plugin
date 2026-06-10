const express = require('express');
const bodyParser = require('body-parser');
const { BedrockRuntimeClient, InvokeModelCommand } = require('@aws-sdk/client-bedrock-runtime');
const { execSync } = require('child_process');
const fs = require('fs');
const path = require('path');

// Load environment variables
require('dotenv').config();

const app = express();
app.use(bodyParser.json());

// AWS Bedrock Client
const bedrockClient = new BedrockRuntimeClient({
    region: process.env.AWS_REGION || 'eu-central-1',
    // Uses AWS_PROFILE from environment
});

const PORT = process.env.PORT || 3000;
const MODEL_ID = process.env.CLAUDE_SONNET_4_5_MODEL_ID;
const GITHUB_DEFAULT_OWNER = process.env.GITHUB_DEFAULT_OWNER || 'bynder';
const GITHUB_DEFAULT_REPO = process.env.GITHUB_DEFAULT_REPO || 'byndiecraft-plugin';

// Health check endpoint
app.get('/health', (req, res) => {
    res.json({ status: 'ok', timestamp: new Date().toISOString() });
});

// Main endpoint for ticket implementation
app.post('/implement-ticket', async (req, res) => {
    const startTime = Date.now();
    console.log('='.repeat(80));
    console.log('[MCP] New ticket implementation request received');
    console.log('[MCP] Time:', new Date().toISOString());

    const { ticketKey, ticketSummary, ticketDescription, jiraUrl, playerName } = req.body;

    if (!ticketKey || !ticketSummary) {
        console.error('[MCP] Missing required fields: ticketKey or ticketSummary');
        return res.status(400).json({
            success: false,
            error: 'Missing required fields: ticketKey and ticketSummary'
        });
    }

    console.log(`[MCP] Ticket: ${ticketKey}`);
    console.log(`[MCP] Summary: ${ticketSummary}`);
    console.log(`[MCP] Player: ${playerName}`);
    console.log(`[MCP] Jira URL: ${jiraUrl}`);

    try {
        // Step 1: Determine repository (uses Claude via Bedrock)
        const repoInfo = await determineRepository(ticketSummary, ticketDescription);
        console.log(`[MCP] Target repository: ${repoInfo.owner}/${repoInfo.repo}`);

        // Step 2: Clone repository
        console.log('[MCP] Cloning repository...');
        const workDir = await cloneRepository(ticketKey, repoInfo);
        console.log(`[MCP] Work directory: ${workDir}`);

        // Step 3: Call Claude via Bedrock to implement
        console.log('[MCP] Calling Claude via AWS Bedrock...');
        const implementation = await implementWithClaude({
            ticketKey,
            ticketSummary,
            ticketDescription,
            workDir,
            repoInfo
        });
        console.log('[MCP] Claude implementation complete');
        console.log(`[MCP] Summary: ${implementation.summary}`);

        // Step 4: Create branch and commit
        console.log('[MCP] Creating branch and committing changes...');
        createBranchAndCommit(workDir, ticketKey, implementation.commitMessage);

        // Step 5: Push and create PR
        console.log('[MCP] Pushing to GitHub and creating PR...');
        const prUrl = await createPullRequest(workDir, ticketKey, ticketSummary, jiraUrl, playerName);
        console.log(`[MCP] ✓ PR created: ${prUrl}`);

        // Cleanup
        console.log('[MCP] Cleaning up work directory...');
        cleanupWorkDir(workDir);

        const duration = ((Date.now() - startTime) / 1000).toFixed(2);
        console.log(`[MCP] ✓ Success! Total time: ${duration}s`);
        console.log('='.repeat(80));

        res.json({
            success: true,
            prUrl: prUrl,
            summary: implementation.summary,
            duration: duration
        });

    } catch (error) {
        console.error('[MCP] ✗ Error:', error.message);
        console.error('[MCP] Stack:', error.stack);
        console.log('='.repeat(80));

        res.status(500).json({
            success: false,
            error: error.message
        });
    }
});

// Determine which repository to use based on ticket content (uses Bedrock/Claude)
async function determineRepository(summary, description) {
    const text = `${summary}\n${description || ''}`;

    // First, get a list of repos from the org to give Claude context
    let repoList = '';
    try {
        repoList = execSync(`gh repo list ${GITHUB_DEFAULT_OWNER} --limit 50 --json name -q '.[].name'`, {
            encoding: 'utf-8',
            timeout: 10000
        }).trim();
    } catch (e) {
        console.log('[MCP] Could not fetch repo list from GitHub, using Claude without repo list');
    }

    const prompt = `Given this Jira ticket, determine which GitHub repository it belongs to.

Ticket title: ${summary}
Ticket description: ${description || 'No description'}

${repoList ? `Available repositories in the org:\n${repoList}\n` : ''}

Respond with ONLY the repository name, nothing else. No explanation, no quotes, just the repo name.
If you cannot determine the repository, respond with: ${GITHUB_DEFAULT_REPO}`;

    try {
        const payload = {
            anthropic_version: 'bedrock-2023-05-31',
            max_tokens: 100,
            messages: [{ role: 'user', content: prompt }]
        };

        const command = new InvokeModelCommand({
            modelId: MODEL_ID,
            contentType: 'application/json',
            accept: 'application/json',
            body: JSON.stringify(payload)
        });

        const response = await bedrockClient.send(command);
        const responseBody = JSON.parse(Buffer.from(response.body).toString());
        const repo = responseBody.content[0].text.trim();

        console.log(`[MCP] Claude determined repo: ${repo}`);
        return { owner: GITHUB_DEFAULT_OWNER, repo };
    } catch (e) {
        console.error(`[MCP] Bedrock repo detection failed: ${e.message}, using default`);
        return { owner: GITHUB_DEFAULT_OWNER, repo: GITHUB_DEFAULT_REPO };
    }
}

// Clone repository to temporary directory
async function cloneRepository(ticketKey, repoInfo) {
    const workDir = path.join('/tmp', `byndiecraft-${ticketKey}-${Date.now()}`);
    const repoUrl = `https://github.com/${repoInfo.owner}/${repoInfo.repo}.git`;

    console.log(`[MCP] Cloning ${repoUrl}...`);

    try {
        execSync(`git clone ${repoUrl} ${workDir}`, {
            stdio: 'pipe',
            encoding: 'utf-8'
        });
    } catch (error) {
        throw new Error(`Failed to clone repository: ${error.message}`);
    }

    return workDir;
}

// Call AWS Bedrock to implement the ticket
async function implementWithClaude({ ticketKey, ticketSummary, ticketDescription, workDir, repoInfo }) {
    const prompt = buildImplementationPrompt(ticketKey, ticketSummary, ticketDescription, workDir, repoInfo);

    const payload = {
        anthropic_version: 'bedrock-2023-05-31',
        max_tokens: 4000,
        messages: [{
            role: 'user',
            content: prompt
        }]
    };

    console.log('[MCP] Sending request to Bedrock...');

    const command = new InvokeModelCommand({
        modelId: MODEL_ID,
        contentType: 'application/json',
        accept: 'application/json',
        body: JSON.stringify(payload)
    });

    try {
        const response = await bedrockClient.send(command);
        const responseBody = JSON.parse(Buffer.from(response.body).toString());
        const content = responseBody.content[0].text;

        console.log('[MCP] Bedrock response received');
        console.log('[MCP] Response length:', content.length, 'characters');

        // Parse Claude's response
        const summary = extractField(content, 'SUMMARY') || ticketSummary;
        const commitMessage = extractField(content, 'COMMIT_MESSAGE') || `Implement ${ticketKey}: ${ticketSummary}`;

        // For now, we're using Claude's text response
        // In a full implementation, you'd use Claude's tool use feature to actually edit files
        // For the hackathon, we'll create a simple marker file
        const implementationFile = path.join(workDir, 'IMPLEMENTATION.md');
        fs.writeFileSync(implementationFile, `# ${ticketKey}: ${ticketSummary}\n\n${content}\n\nImplemented by Claude via Byndiecraft MCP Server\n`);

        return {
            summary,
            commitMessage,
            content
        };

    } catch (error) {
        console.error('[MCP] Bedrock error:', error);
        throw new Error(`Claude implementation failed: ${error.message}`);
    }
}

// Build the prompt for Claude
function buildImplementationPrompt(ticketKey, ticketSummary, ticketDescription, workDir, repoInfo) {
    return `You are implementing a Jira ticket for a Minecraft hackathon project called Byndiecraft.

Ticket: ${ticketKey}
Summary: ${ticketSummary}
Description: ${ticketDescription || 'No additional description provided'}

Repository: ${repoInfo.owner}/${repoInfo.repo}
Working Directory: ${workDir}

This is a DEMO for a hackathon. Your task is to:
1. Analyze what this ticket is asking for
2. Provide a clear implementation plan
3. Explain what files you would modify and how

Since this is a demo, you don't need to write actual working code - just provide a clear, detailed implementation plan.

Respond in this format:

SUMMARY: <One-line summary of what you would implement>

IMPLEMENTATION_PLAN:
<Detailed explanation of what you would do, which files you'd modify, and how>

COMMIT_MESSAGE: <A good git commit message for these changes>

Be specific and detailed, but remember this is a hackathon demo - focus on clarity over perfection.`;
}

// Extract a field from Claude's response
function extractField(content, fieldName) {
    const regex = new RegExp(`${fieldName}:\\s*(.+?)(?=\\n\\n|\\n[A-Z_]+:|$)`, 's');
    const match = content.match(regex);
    return match ? match[1].trim() : null;
}

// Create branch and commit changes
function createBranchAndCommit(workDir, ticketKey, commitMessage) {
    const branchName = `${ticketKey.toLowerCase()}-ai-implementation`;

    console.log(`[MCP] Creating branch: ${branchName}`);
    execSync(`git checkout -b ${branchName}`, { cwd: workDir, stdio: 'pipe' });

    console.log('[MCP] Staging changes...');
    execSync('git add .', { cwd: workDir, stdio: 'pipe' });

    console.log('[MCP] Creating commit...');
    const fullCommitMessage = `${commitMessage}\n\nImplemented by Claude AI via Byndiecraft\n\nCo-Authored-By: Claude Sonnet 4.5 <noreply@anthropic.com>`;

    // Write commit message to a temp file to avoid shell escaping issues
    const commitMsgFile = path.join(workDir, '.commit-msg');
    fs.writeFileSync(commitMsgFile, fullCommitMessage);
    execSync(`git commit -F .commit-msg`, {
        cwd: workDir,
        stdio: 'pipe'
    });
    fs.unlinkSync(commitMsgFile);

    console.log('[MCP] ✓ Commit created');
}

// Push branch and create PR using gh CLI
async function createPullRequest(workDir, ticketKey, ticketSummary, jiraUrl, playerName) {
    const branchName = `${ticketKey.toLowerCase()}-ai-implementation`;

    console.log(`[MCP] Pushing branch ${branchName}...`);
    try {
        execSync(`git push -u origin ${branchName}`, {
            cwd: workDir,
            stdio: 'pipe'
        });
    } catch (error) {
        throw new Error(`Failed to push branch: ${error.message}`);
    }

    console.log('[MCP] Creating PR with gh CLI...');
    const prTitle = `${ticketKey}: ${ticketSummary}`;
    const prBody = `## 🎮 Implemented by Byndiecraft AI System

**Jira Ticket:** ${jiraUrl}
**Requested by:** ${playerName} (in Minecraft)

This PR was automatically generated by throwing a book into the AI Hopper in Minecraft! 🤖

### Changes
- Implementation for ${ticketKey}

### How it works
1. Player grabbed the Jira ticket book from the board
2. Threw it into the AI Hopper
3. Claude Sonnet 4.5 (via AWS Bedrock) analyzed and implemented the ticket
4. This PR was created automatically

---
🚀 Powered by [Byndiecraft](https://github.com/${GITHUB_DEFAULT_OWNER}/${GITHUB_DEFAULT_REPO}) - Making standups fun with Minecraft + AI
`;

    try {
        const result = execSync(
            `gh pr create --title "${prTitle.replace(/"/g, '\\"')}" --body "${prBody.replace(/"/g, '\\"')}"`,
            { cwd: workDir, encoding: 'utf-8' }
        );

        // Extract PR URL from gh output
        const prUrlMatch = result.match(/https:\/\/github\.com\/[^\s]+/);
        if (prUrlMatch) {
            return prUrlMatch[0];
        }

        // Fallback: try to get PR URL with gh pr view
        const prUrl = execSync('gh pr view --json url -q .url', {
            cwd: workDir,
            encoding: 'utf-8'
        }).trim();

        return prUrl;

    } catch (error) {
        throw new Error(`Failed to create PR: ${error.message}`);
    }
}

// Cleanup work directory
function cleanupWorkDir(workDir) {
    try {
        execSync(`rm -rf ${workDir}`, { stdio: 'pipe' });
        console.log('[MCP] ✓ Work directory cleaned up');
    } catch (error) {
        console.warn('[MCP] Warning: Failed to cleanup work directory:', error.message);
    }
}

// Start server
app.listen(PORT, () => {
    console.log('='.repeat(80));
    console.log('🎮 Byndiecraft MCP Server');
    console.log('='.repeat(80));
    console.log(`Server running on http://localhost:${PORT}`);
    console.log(`AWS Region: ${process.env.AWS_REGION}`);
    console.log(`AWS Profile: ${process.env.AWS_PROFILE}`);
    console.log(`Model: ${MODEL_ID}`);
    console.log(`Default Repo: ${GITHUB_DEFAULT_OWNER}/${GITHUB_DEFAULT_REPO}`);
    console.log('='.repeat(80));
    console.log('Ready to implement tickets! 🚀');
    console.log('');
});
