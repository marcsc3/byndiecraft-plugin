# Byndiecraft - Minecraft Jira Integration

> **Bynder Hackathon 2026**: A physical Jira board inside Minecraft with AI-powered ticket implementation.

## Overview

Byndiecraft turns Minecraft into a living Jira board. Tickets appear as colored books in item frames, organized by status columns. Move a book between columns and the Jira ticket transitions automatically. Throw a book into the AI Hopper and Claude implements the ticket, creating a PR on GitHub.

### Features

**Phase 1 - Jira Board**
- `/jiraboard spawn [x y z]` builds a complete board from live Jira data (active sprint)
- Books are color-coded: red (bugs), green (stories), aqua (tasks/subtasks), gold (spikes)
- Book titles show ticket key + summary; pages contain description (multi-page)
- Moving books between columns triggers Jira status transitions via REST API
- Fireworks launch when a ticket moves to "Done"
- Duplicate transitions are skipped (rotating a book in its frame doesn't re-fire)
- Works from command blocks (no player required if coordinates provided)
- Board auto-sizes columns based on ticket count

**Phase 2 - AI Implementation**
- Throw a book into the AI Hopper to trigger automated ticket implementation
- MCP server calls AWS Bedrock (Claude) to determine the target repository
- Claude analyzes the ticket and generates an implementation
- A Pull Request is created automatically on GitHub
- PR link is returned to the player in Minecraft

## Architecture

```
Minecraft Server (Paper 1.21 / Java 25)
├── BoardSpawner ─────── Builds board: terracotta walls, item frames, signed books
├── ItemFrameListener ── Detects book movements → Jira transition API
├── AIChestListener ──── Detects books in AI Hopper → MCP Server
└── JiraBoardCommand ─── /jiraboard spawn|refresh|delete|setaihopper
         │                         │
         ▼                         ▼
    Jira REST API v3          MCP Server (Node.js, port 3000)
    (JQL search,              ├── Claude/Bedrock → determine repo
     transitions)             ├── Claude/Bedrock → implement ticket
                              └── gh CLI → create PR on GitHub
```

## Quick Start

### Prerequisites

- Java 25 + Maven
- Paper server 1.21 (paper-26.1.2)
- Node.js 18+ (for MCP server)
- GitHub CLI (`gh`)
- AWS credentials with Bedrock access (or EC2 IAM role)

### 1. Build the Plugin

```bash
mvn clean package
cp target/byndiecraft-plugin-1.0.0-SNAPSHOT.jar /path/to/server/plugins/
```

### 2. Configure Jira Credentials

Create `plugins/Byndiecraft/credentials.yml`:
```yaml
jira:
  email: "your-email@bynder.com"
  api_token: "your-api-token"
```

### 3. Configure the Plugin

Edit `plugins/Byndiecraft/config.yml`:
```yaml
jira:
  url: "https://bynder.atlassian.net"
  project_key: "SHARE"

board:
  world: "world"
  anchor:
    x: 0
    y: -59
    z: -15
  columns:
    - name: "Ready to be Picked Up"
      jira_status_name: "Backlog"
      frames: []
    - name: "In Progress"
      jira_status_name: "In Progress"
      frames: []
    - name: "Review"
      jira_status_name: "Code review"
      frames: []
    - name: "Merge"
      jira_status_name: "Merge"
      frames: []
    - name: "Done"
      jira_status_name: "Closed"
      frames: []

fireworks:
  enabled: true
  power: 1
  type: BALL_LARGE
  colors: ["#FF0000", "#FFD700", "#00FF00"]
  fade_colors: ["#FFFFFF"]
  trail: true
  flicker: true

ai:
  enabled: true
  mcp_endpoint: "http://localhost:3000/implement-ticket"

debug: true
```

### 4. Setup MCP Server (Phase 2)

```bash
cd mcp-server
npm install
cp .env.example .env
# Edit .env — see mcp-server/README.md for details
gh auth login
gh auth setup-git
npm start
```

### 5. Restart Minecraft Server

## Commands

| Command | Description |
|---------|-------------|
| `/jiraboard spawn [x y z]` | Spawn the board (optional coordinates) |
| `/jiraboard refresh` | Rebuild board with fresh Jira data |
| `/jiraboard delete` | Destroy the board with TNT |
| `/jiraboard setaihopper` | Set the AI Hopper location (look at a hopper) |
| `/jiraboard info` | Show board configuration |
| `/jiraboard debug` | Show debug information |

All commands work from command blocks (except `setaihopper` and `delete` which require a player).

## Configuration Details

### Fireworks

Fireworks are fully customizable via `config.yml`. Any RGB hex color is supported (Minecraft fireworks use raw RGB, not a limited palette).

Available effect types: `BALL`, `BALL_LARGE`, `STAR`, `BURST`, `CREEPER`

### Board Spawn

The board centers itself on the anchor X coordinate. Columns auto-size their width based on ticket count, with a fixed height of 4 rows. Each column uses colored terracotta backing and has a sign header.

You can spawn from a command block:
```
/jiraboard spawn 0 -59 -15
```

Or wire a button to a command block with this command to refresh on demand.

### AI Hopper

1. Place a hopper in-game
2. Look at it and run `/jiraboard setaihopper`
3. Throw written books with Jira ticket keys into the hopper
4. The MCP server handles implementation via Claude/Bedrock
5. A PR is created and the link is sent back to the player

## EC2 Deployment

The server runs on AWS EC2 (`eu-central-1`). The instance has an IAM role for Bedrock access — no manual AWS credentials needed.

```bash
ssh ubuntu@<ec2-host>

# Minecraft server
cd /home/ubuntu/minecraft
java -jar paper-26.1.2-69.jar

# MCP server
cd /home/ubuntu/minecraft/byndiecraft-plugin/mcp-server
nohup node server.js > /tmp/mcp-server.log 2>&1 &

# Check logs
tail -f /tmp/mcp-server.log
```

## Troubleshooting

| Problem | Solution |
|---------|----------|
| "Failed to update ticket" | Check Jira credentials and ticket permissions |
| Books not detected in hopper | Run `/jiraboard setaihopper` while looking at the hopper |
| MCP server "Repository not found" | Run `gh auth setup-git` to configure git HTTPS auth |
| No fireworks on Done | Check that the column's `jira_status_name` matches "Closed" or "Done" |
| Board too high/low | Adjust `board.anchor.y` in config.yml |

Enable debug mode (`debug: true`) for verbose logging in `logs/latest.log`.

## Team

Built by Team Byndiecraft for the Bynder Hackathon 2026.
