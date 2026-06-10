# AGENTS.md - Multi-Agent Configuration

## Agent Roles

### Development Agent (Claude Code - Opus)

**Role:** Primary development agent responsible for architecture, implementation, debugging, and deployment.

**Capabilities:**
- Full codebase read/write access
- Git operations (commit, push, branch)
- SSH access to production EC2 server
- Maven builds and plugin deployment
- MCP server management

**Guidelines:**
- Always broadcast messages to all players, never just the triggering player
- Use custom executors for async operations to avoid classloader issues
- Write file-based commit messages to avoid shell escaping problems
- Add timestamps to branch names for uniqueness
- Test builds compile before pushing

### Implementation Agent (Claude Sonnet 4.5 - Bedrock)

**Role:** Runtime AI agent that implements Jira tickets autonomously when triggered by the AI Hopper in Minecraft.

**Capabilities:**
- Repository detection from ticket descriptions
- Code generation based on ticket requirements
- File creation and modification within cloned repos

**Guidelines:**
- Output format must be FILE/CONTENT/END_FILE blocks (not markdown)
- Commit messages must not contain backticks or code fences
- Always determine the correct repo from ticket description before defaulting
- Keep implementations minimal and focused on ticket scope
- Max 16000 tokens per implementation response

### Repository Detection Agent (Claude Sonnet 4.5 - Bedrock)

**Role:** Lightweight agent that determines which GitHub repository a ticket belongs to.

**Capabilities:**
- Reads org repo list via `gh repo list`
- Analyzes ticket title and description
- Returns a single repo name

**Guidelines:**
- Response must be ONLY the repo name, no explanation
- Fall back to `asset-enrichment-agent-svc` if uncertain
- Max 100 tokens response

## Agent Communication Flow

```
Player throws book into AI Hopper
        │
        ▼
Development Agent (Plugin - Java)
  ├── Extracts ticket key + book content
  ├── Fetches full ticket from Jira API
  └── Sends to MCP server
        │
        ▼
MCP Server (Node.js - Orchestrator)
  ├── Calls Repository Detection Agent
  │         └── Returns: repo name
  ├── Clones repository
  ├── Calls Implementation Agent
  │         └── Returns: FILE blocks + commit message
  ├── Writes files, commits, pushes
  └── Creates PR via gh CLI
        │
        ▼
Result returned to Plugin → Broadcast to all players
```

## Token Budget

| Agent | Model | Max Tokens | Typical Usage |
|-------|-------|-----------|---------------|
| Repo Detection | Sonnet 4.5 | 100 | ~50 tokens |
| Implementation | Sonnet 4.5 | 16,000 | ~5,000-12,000 tokens |
| Development | Opus | Session-based | Variable |

## Error Handling

- If Repo Detection fails → fall back to default repo
- If Implementation fails → return error to player, book returned with error in lore
- If git push fails → add timestamp to branch name and retry
- If MCP server unreachable → 120s timeout, then error message to all players
