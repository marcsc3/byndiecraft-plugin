# CLAUDE.md - Project Instructions for Claude Code

## Project Overview

Byndiecraft is a Minecraft Paper plugin (1.21) that creates a physical Jira board in-game with AI-powered ticket implementation. Built for the Bynder Hackathon 2026.

## Build & Deploy

```bash
mvn clean package
cp target/byndiecraft-plugin-1.0.0-SNAPSHOT.jar /path/to/server/plugins/
```

- Java 25, Maven (not Gradle)
- Paper API 1.21 (provided scope — don't bundle it)
- OkHttp + Gson are shaded into the JAR via maven-shade-plugin

## Architecture

- `src/main/java/com/bynder/byndiecraft/` — Java plugin source
  - `board/` — Board rendering (BoardSpawner, BoardManager, StatusColumn)
  - `jira/` — Jira REST API client (JiraClient, JiraTicket)
  - `ai/` — AI hopper system (AIChestListener, AITaskManager)
  - `commands/` — Plugin commands (/jiraboard)
  - `util/` — Helpers (BookParser, ConfigLoader)
- `mcp-server/` — Node.js Express server that orchestrates Bedrock + GitHub
- `src/main/resources/config.yml` — Default plugin configuration

## Key Conventions

- Use Paper's Adventure API for text (Component, NamedTextColor) — never legacy ChatColor
- All async operations must use a custom executor with the plugin classloader (ForkJoinPool causes NoClassDefFoundError)
- Broadcast messages to all players with `Bukkit.broadcast()`, not `player.sendMessage()`
- Jira API v3 uses ADF (Atlassian Document Format) for descriptions — parse with extractTextFromAdf()
- Book titles are capped at 32 chars by Minecraft; use displayName for the full title

## Server Details

- EC2: `ssh -i 'byndiecraft.pem' ubuntu@<ec2-host>`
- Minecraft server: `/home/ubuntu/minecraft/`
- Plugin config: `/home/ubuntu/minecraft/plugins/Byndiecraft/config.yml`
- MCP server: `/home/ubuntu/minecraft/byndiecraft-plugin/mcp-server/`
- MCP logs: `tail -f /tmp/mcp-server.log`

## Common Tasks

- **Deploy plugin**: `git pull && mvn clean package -q && cp target/*.jar ../plugins/ && restart server`
- **Restart MCP**: `pkill -f "node server.js"; cd mcp-server && nohup node server.js > /tmp/mcp-server.log 2>&1 &`
- **Test MCP health**: `curl http://localhost:3000/health`
