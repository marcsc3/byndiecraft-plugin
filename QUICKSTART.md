# Byndiecraft - Quick Start Guide

**AI-Powered Minecraft Jira Integration for Hackathon**

## What is Byndiecraft?

Byndiecraft makes stand-ups fun by bringing Jira into Minecraft! 

### Phase 1 (Complete) ✅
Visual Jira board where written books in item frames represent tickets. Moving books between frames updates Jira status in real-time.

### Phase 2 (Complete) ✅
AI-powered ticket implementation: throw a book into a magic hopper, and Claude (via AWS Bedrock) implements the ticket and creates a GitHub PR automatically!

---

## Quick Setup (5 minutes)

### 1. Start MCP Server

```bash
cd mcp-server
npm install
gh auth login  # one-time setup
npm start
```

Server should show: `Ready to implement tickets! 🚀`

### 2. Deploy Minecraft Plugin

```bash
mvn clean package
cp target/byndiecraft-plugin-1.0.0-SNAPSHOT.jar /path/to/minecraft/plugins/
# Restart Minecraft server
```

### 3. Configure AI Hopper (In Minecraft)

```
/jiraboard setaihopper
```

(While looking at a hopper)

---

## Demo Flow

1. **Grab ticket book** from Jira board (item frames)
2. **Throw book** into AI hopper
3. **Watch the magic**:
   - Portal particles 🌀
   - "Claude is implementing..."
   - MCP server processes ticket
   - Claude analyzes and codes
   - GitHub PR created
4. **Book returns** with PR link
5. **Click link** - browser opens to PR
6. **Move book** to "Done" column
7. **Jira updates** ✅

---

## Architecture

```
Minecraft Book → AI Hopper → MCP Server → AWS Bedrock (Claude) → GitHub PR
                                    ↓
                                 Jira API
```

---

## Features

### Phase 1
- ✅ Real-time Jira board in Minecraft
- ✅ Visual ticket management with books
- ✅ Status updates via item frame movement
- ✅ Regex ticket key extraction (TAP-123, PROJ-456)

### Phase 2
- ✅ AI-powered ticket implementation
- ✅ AWS Bedrock (Claude Sonnet 4.5) integration
- ✅ Automatic GitHub PR creation
- ✅ Visual effects (particles, sounds)
- ✅ Book returns with PR link in lore
- ✅ Clickable PR links in chat

---

## Tech Stack

- **Minecraft**: Paper 1.21, Java 21
- **Jira**: REST API v3
- **AI**: AWS Bedrock (Claude Sonnet 4.5)
- **GitHub**: gh CLI
- **Backend**: Node.js + Express
- **Build**: Maven with Shade plugin

---

## Commands

### Minecraft Commands

```
/jiraboard info          - Show board configuration
/jiraboard debug         - Debug information
/jiraboard spawn         - Create Jira board from tickets
/jiraboard setaihopper   - Configure AI hopper (look at hopper)
/jiraboard aiinfo        - Show AI system status
```

---

## Configuration

### MCP Server (.env)
```env
AWS_PROFILE=development
AWS_REGION=eu-central-1
CLAUDE_SONNET_4_5_MODEL_ID=arn:aws:bedrock:...:application-inference-profile/...
GITHUB_DEFAULT_OWNER=bynder
GITHUB_DEFAULT_REPO=byndiecraft-plugin
PORT=3000
```

### Minecraft Plugin (config.yml)
```yaml
jira:
  url: "https://bynder.atlassian.net"
  email: "your-email@bynder.com"
  api_token: "${JIRA_API_TOKEN}"
  project_key: "SHARE"

ai:
  enabled: true
  mcp_endpoint: "http://localhost:3000/implement-ticket"
```

---

## Testing

### Test MCP Server
```bash
curl http://localhost:3000/health
./mcp-server/test-ticket.sh
```

### Test in Minecraft
1. Create written book with title "TEST-123"
2. Throw into AI hopper
3. Watch for PR link in chat

---

## Troubleshooting

**Server not starting?**
- Check `npm install` completed
- Verify AWS credentials: `aws configure list --profile development`
- Check GitHub auth: `gh auth status`

**Hopper not working?**
- Run `/jiraboard aiinfo` to check configuration
- Make sure `ai.enabled: true` in config.yml
- Restart Minecraft server

**No PR created?**
- Check MCP server logs for errors
- Verify GitHub authentication
- Test with `./mcp-server/test-ticket.sh`

---

## Files

```
byndiecraft-plugin/
├── src/main/java/            # Minecraft plugin (Java)
│   ├── ai/                   # AI system (hopper, task manager)
│   ├── board/                # Jira board (Phase 1)
│   ├── commands/             # /jiraboard commands
│   ├── jira/                 # Jira API client
│   └── listeners/            # Event handlers
├── mcp-server/               # Node.js MCP server (Phase 2)
│   ├── server.js             # Main server
│   ├── package.json          # Dependencies
│   └── README.md             # MCP server docs
├── PHASE2_SETUP.md           # Detailed setup guide
└── QUICKSTART.md             # This file
```

---

## Next Steps

✅ **For Development**
- See `PHASE2_SETUP.md` for detailed setup
- Check `mcp-server/README.md` for MCP server docs
- Review code in `src/main/java/com/bynder/byndiecraft/`

✅ **For Demo**
- Practice the demo flow
- Create test tickets in Jira
- Build an "AI Lab" around the hopper
- Prepare backup in case of network issues

✅ **For Production**
- Add request queuing
- Implement retry logic
- Add monitoring and metrics
- Use Claude's tool use for actual code editing

---

**Built for Bynder Hackathon 2026** 🎮🤖🚀

Team: Byndiecraft | Tech: Minecraft + Jira + AWS Bedrock + GitHub
