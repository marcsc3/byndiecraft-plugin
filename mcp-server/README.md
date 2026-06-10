# Byndiecraft MCP Server

MCP (Model Context Protocol) server for AI-powered Jira ticket implementation via Minecraft.

## How It Works

1. **Minecraft player throws a book** with a Jira ticket key into the AI Hopper
2. **Plugin calls this server** with ticket details
3. **Server uses AWS Bedrock** (Claude Sonnet 4.5) to analyze and implement the ticket
4. **Creates a GitHub PR** automatically
5. **Returns PR link** to the player in Minecraft

## Setup

### 1. Install Dependencies

```bash
cd mcp-server
npm install
```

### 2. Configure Environment

```bash
cp .env.example .env
```

Edit `.env` with your settings:

```env
# Comment out AWS_PROFILE if running on EC2 with an IAM role
#AWS_PROFILE=development
AWS_REGION=eu-central-1
CLAUDE_SONNET_4_5_MODEL_ID=arn:aws:bedrock:eu-central-1:745091492598:application-inference-profile/ltk3rb6ikzf9
GITHUB_DEFAULT_OWNER=bynder
GITHUB_DEFAULT_REPO=asset-enrichment-agent-svc
PORT=3000
```

### 3. Authenticate with GitHub

```bash
gh auth login
gh auth setup-git
```

Follow the prompts to authenticate. This only needs to be done once.
`gh auth setup-git` configures git to use `gh` as the credential helper for HTTPS clones.

### 4. Verify AWS Credentials

If running on EC2 with an IAM role, credentials are automatic. Otherwise:

```bash
aws configure --profile development
```

On EC2, verify the instance role:
```bash
curl -s -H "X-aws-ec2-metadata-token: $(curl -s -X PUT 'http://169.254.169.254/latest/api/token' -H 'X-aws-ec2-metadata-token-ttl-seconds: 21600')" http://169.254.169.254/latest/meta-data/iam/security-credentials/
```

## Running the Server

### Development Mode (with auto-reload)

```bash
npm run dev
```

### Production Mode

```bash
npm start
```

The server will start on `http://localhost:3000`

## Testing

### Health Check

```bash
curl http://localhost:3000/health
```

Expected response:
```json
{
  "status": "ok",
  "timestamp": "2026-06-10T10:00:00.000Z"
}
```

### Test Ticket Implementation

```bash
curl -X POST http://localhost:3000/implement-ticket \
  -H "Content-Type: application/json" \
  -d '{
    "ticketKey": "TAP-123",
    "ticketSummary": "Add user authentication",
    "ticketDescription": "Implement JWT-based authentication",
    "jiraUrl": "https://bynder.atlassian.net/browse/TAP-123",
    "playerName": "Steve"
  }'
```

Expected response:
```json
{
  "success": true,
  "prUrl": "https://github.com/bynder/byndiecraft-plugin/pull/1",
  "summary": "Implement JWT authentication system",
  "duration": "15.42"
}
```

## Architecture

```
Minecraft Plugin (Java)
        ↓
    [HTTP POST]
        ↓
MCP Server (Node.js)
        ↓
   ┌────┴────┐
   ↓         ↓
Bedrock    GitHub
(Claude)   (gh CLI)
```

## API Endpoints

### `GET /health`
Health check endpoint.

**Response:**
```json
{
  "status": "ok",
  "timestamp": "2026-06-10T10:00:00.000Z"
}
```

### `POST /implement-ticket`
Main endpoint for ticket implementation.

**Request Body:**
```json
{
  "ticketKey": "TAP-123",
  "ticketSummary": "Ticket summary",
  "ticketDescription": "Optional description",
  "jiraUrl": "https://jira.example.com/browse/TAP-123",
  "playerName": "MinecraftPlayer"
}
```

**Response (Success):**
```json
{
  "success": true,
  "prUrl": "https://github.com/owner/repo/pull/123",
  "summary": "Implementation summary",
  "duration": "15.42"
}
```

**Response (Error):**
```json
{
  "success": false,
  "error": "Error message"
}
```

## Repository Routing

The server uses **Claude (via AWS Bedrock)** to intelligently determine which repository a ticket belongs to:

1. Fetches the list of repositories from the GitHub org (`gh repo list`)
2. Sends the ticket title, description, and repo list to Claude
3. Claude identifies the correct repository from context
4. Falls back to `GITHUB_DEFAULT_REPO` (asset-enrichment-agent-svc) if detection fails

The repo name is typically present in the Jira ticket description. Claude reads this and matches it to the correct org repository.

## Troubleshooting

### "gh: command not found"
Install GitHub CLI: https://cli.github.com/

### "AWS credentials not found"
Make sure your AWS profile is configured:
```bash
aws configure --profile development
```

### "Failed to clone repository"
Make sure you have access to the repository and GitHub authentication is set up:
```bash
gh auth status
```

### Port 3000 already in use
Change the port in `.env`:
```env
PORT=3001
```

## Hackathon Notes

This is a demo implementation for the hackathon. For production use, you'd want to add:

- ✅ Request queuing (prevent concurrent implementations)
- ✅ Rate limiting
- ✅ Better error handling and retries
- ✅ Logging to file
- ✅ Metrics and monitoring
- ✅ Use Claude's tool use feature for actual code editing
- ✅ Test coverage
- ✅ Docker containerization

## License

MIT
