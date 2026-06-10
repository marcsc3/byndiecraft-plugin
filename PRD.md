# Product Requirements Document: Byndiecraft

## Overview

**Product Name:** Byndiecraft
**Team:** Team Byndiecraft
**Category:** Wildcard - BYOI
**Date:** June 9-10, 2026

## Problem Statement

Stand-ups and sprint management are repetitive, disengaging rituals. Engineers interact with Jira through a flat web UI that offers no spatial awareness of work progress. Meanwhile, AI-assisted development remains disconnected from project management — developers must context-switch between Jira, their IDE, and AI tools.

**Key pain points:**
- Sprint boards are passive — you look at them, you don't *interact* with them
- AI coding assistants require manual context gathering (copy ticket, open repo, describe task)
- There's no visceral, shared experience of "work getting done" — no celebration when a ticket ships

## Solution

Byndiecraft turns a Minecraft world into a living, interactive Jira board where:

1. **Tickets are physical objects** — colored books in item frames, organized by status columns
2. **Moving a book between columns transitions the Jira ticket** — drag-and-drop with physics
3. **Throwing a book into the AI Hopper triggers autonomous implementation** — Claude reads the ticket, determines the correct repository, writes code, and creates a Pull Request
4. **Everything is multiplayer** — the whole team sees progress, gets notifications, and celebrates together with fireworks

## Target Users

- Engineering teams using Jira for sprint management
- Teams exploring AI-augmented development workflows
- Anyone who wants standups to be less boring

## Functional Requirements

### Phase 1: Physical Jira Board

| ID | Requirement | Status |
|----|------------|--------|
| F1.1 | Fetch active sprint tickets from Jira via REST API v3 | Done |
| F1.2 | Render tickets as colored written books (red=bug, green=story, aqua=task, gold=spike) | Done |
| F1.3 | Display tickets in item frames on a terracotta wall, organized by status columns | Done |
| F1.4 | Auto-size column widths based on ticket count | Done |
| F1.5 | Moving a book between columns triggers Jira status transition | Done |
| F1.6 | Multi-page book content with full ticket description | Done |
| F1.7 | Fireworks celebration when a ticket moves to "Done" | Done |
| F1.8 | Prevent duplicate transitions when rotating items in frames | Done |
| F1.9 | Command block support (`/jiraboard spawn [x y z]`) for automated refresh | Done |
| F1.10 | Board spawn broadcasts progress to all players | Done |

### Phase 2: AI-Powered Implementation

| ID | Requirement | Status |
|----|------------|--------|
| F2.1 | Detect books thrown into a designated AI Hopper | Done |
| F2.2 | Extract ticket key and description from book content | Done |
| F2.3 | Call MCP server with ticket details | Done |
| F2.4 | Claude (via AWS Bedrock) determines target repository from ticket description | Done |
| F2.5 | Claude generates actual code implementation (not just plans) | Done |
| F2.6 | Create branch, commit, and open Pull Request on GitHub automatically | Done |
| F2.7 | Return PR link to player in-game (clickable) | Done |
| F2.8 | Broadcast all AI progress messages to entire server | Done |
| F2.9 | Visual/audio feedback: enchantment particles, sounds on submission and completion | Done |
| F2.10 | Configurable timeout (120s) for long-running AI tasks | Done |

## Non-Functional Requirements

| ID | Requirement | Details |
|----|------------|---------|
| NF1 | Latency | Board spawn < 5s, AI implementation < 120s |
| NF2 | Reliability | Graceful error handling with player-visible error messages |
| NF3 | Multiplayer | All events visible to all connected players |
| NF4 | Security | Jira credentials in separate `credentials.yml`, AWS via IAM role |
| NF5 | Configurability | All settings in `config.yml` — no code changes needed for new projects |
| NF6 | Deployment | Single JAR + Node.js MCP server, deployable on any Paper 1.21 server |

## Architecture

```
+--------------------------------------------------+
|          Minecraft Server (Paper 1.21)           |
|                                                  |
|  +------------------+  +---------------------+  |
|  |  BoardSpawner    |  |  AIChestListener    |  |
|  |  - Fetch Jira    |  |  - Detect books     |  |
|  |  - Build board   |  |  - Trigger AI       |  |
|  +--------+---------+  +----------+----------+  |
|           |                        |             |
+-----------|------------------------|-------------+
            |                        |
            v                        v
   +--------+--------+     +--------+--------+
   |  Jira REST API  |     |   MCP Server    |
   |  (Cloud)        |     |   (Node.js)     |
   +-----------------+     +--------+--------+
                                    |
                           +--------+--------+
                           |                 |
                           v                 v
                    +------+------+   +------+------+
                    | AWS Bedrock |   |  GitHub API |
                    | (Claude 4.5)|   |  (gh CLI)   |
                    +-------------+   +-------------+
```

## Tech Stack

| Layer | Technology |
|-------|-----------|
| Game Server | Paper 1.21 (Minecraft), Java 25 |
| Plugin Framework | Paper API, Adventure Text API |
| HTTP Client | OkHttp 4.12 (shaded into plugin JAR) |
| AI Orchestration | Node.js Express server (MCP) |
| AI Model | Claude Sonnet 4.5 via AWS Bedrock |
| Source Control | GitHub + `gh` CLI |
| Infrastructure | AWS EC2 (eu-central-1) with IAM role |
| Project Management | Jira Cloud (REST API v3) |

## User Flows

### Flow 1: Viewing the Sprint Board

1. Player (or command block) runs `/jiraboard spawn`
2. Plugin fetches active sprint tickets from Jira
3. Board materializes: terracotta walls, column signs, colored books in item frames
4. All players see "Board spawned with N tickets!" broadcast

### Flow 2: Transitioning a Ticket

1. Player takes a book from one column's item frame
2. Player places it in another column's item frame
3. Plugin detects the move, maps column to Jira status
4. Jira ticket transitions via REST API
5. If moved to "Done" — fireworks launch above the board

### Flow 3: AI Implementation

1. Player throws a ticket book into the AI Hopper
2. All players see: "Claude is implementing SHARE-123..."
3. MCP server receives ticket details + book content
4. Claude determines target repo from description
5. Claude generates code implementation
6. Branch created, code committed, PR opened
7. All players see: "PR Created: [clickable link]"
8. Book returned to player with PR URL in lore

## Configuration

The plugin is fully configurable without code changes:

- **Jira connection:** URL, project key, credentials
- **Board layout:** anchor coordinates, column-to-status mapping
- **Visual effects:** firework colors, types, particles
- **AI settings:** MCP endpoint, hopper location, Bedrock model
- **GitHub:** default org/repo, auto-detection toggle

## Risks & Mitigations

| Risk | Mitigation |
|------|-----------|
| Jira API rate limits | Caching, fetch only on explicit spawn/refresh |
| AI generates incorrect code | PR review required before merge; code is never auto-merged |
| Classloader issues (Paper) | Custom executor with plugin classloader for async operations |
| Shell injection in git commands | File-based commit messages, no user input in shell commands |
| Concurrent AI requests | Stateless MCP server, unique branch names with timestamps |

## Success Metrics

- Board spawns correctly with live sprint data
- Ticket transitions reflect in Jira within seconds
- AI creates a valid PR with actual code (not just plans) in under 2 minutes
- Entire team can watch AI progress in real-time
- Zero manual steps between "throw book" and "PR created"

## Future Enhancements

- Voice-activated commands via Minecraft chat
- AI ticket estimation (story points) based on code complexity
- Auto-merge when CI passes + approvals received
- Slack notifications when AI creates a PR
- Multiple sprint board support
- Ticket creation from within Minecraft (write a new book)
