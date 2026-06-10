# Byndiecraft

**Your Jira board lives inside Minecraft. Move a book, move a ticket. Throw a book, and AI writes the code.**

---

## What is this?

Byndiecraft transforms Minecraft into a fully functional Jira board. Tickets from your active sprint appear as colored books sitting in item frames on a physical board. Pick up a book and place it in a different column — the Jira ticket transitions instantly. Want a ticket implemented? Throw the book into the AI Hopper and Claude writes the code, pushes a branch, and opens a Pull Request on GitHub. All without leaving Minecraft.

---

## How It Works

### Phase 1: The Living Jira Board

A single command (`/jiraboard spawn`) connects to Jira's REST API v3, runs a JQL query against the active sprint, and builds a physical board in the Minecraft world.

**Board Generation:**
- The plugin authenticates with Jira using email + API token (Basic Auth over HTTPS)
- Fetches all tickets in the active sprint via JQL: `sprint in openSprints() AND project = <KEY>`
- For each ticket, generates a written book — title = ticket key + summary, pages = full description (multi-page support)
- Books are **color-coded** by issue type: red = bug, green = story, aqua = task/subtask, gold = spike
- Places books in item frames on colored terracotta columns (one column per status)
- Columns auto-size their width based on ticket count (max 4 rows per column)

**Real-Time Jira Sync (the core mechanic):**
- `ItemFrameListener` hooks into Paper's `PlayerInteractEntityEvent`
- When a player places a book in a frame, the plugin extracts the ticket key via regex (`[A-Z]+-\d+`)
- The frame's world coordinates are mapped to a status column via `BoardManager` (frame location → column lookup)
- The plugin calls `GET /rest/api/3/issue/{key}/transitions` to fetch available Jira transitions
- Matches the target column's Jira status name against available transitions
- Fires `POST /rest/api/3/issue/{key}/transitions` with the matched transition ID
- All HTTP calls use **OkHttp with CompletableFuture** — fully async, zero server tick lag
- Duplicate transitions are prevented: the plugin caches current ticket status and skips if the book is just being rotated in place
- On success: chat confirmation + sound effect. On "Done"/"Closed": fireworks with configurable colors, trails, and effects

**Columns → Jira Status Mapping (configurable in YAML):**
```
Ready to be Picked Up  →  Backlog
In Progress            →  In Progress
Review                 →  Code Review
Merge                  →  Merge
Done                   →  Closed
```

### Phase 2: AI-Powered Implementation

Place a hopper block in the world and mark it as the AI Hopper. Then:

1. Write (or pick up) a book with a Jira ticket key
2. Throw it into the AI Hopper
3. The plugin sends the ticket details to an MCP server
4. Claude (via AWS Bedrock) analyzes the ticket and determines the correct repository
5. Claude generates the implementation
6. A feature branch is created, code is committed, and a **Pull Request appears on GitHub**
7. The PR link is sent back to you in Minecraft chat

Elevator music plays while you wait.

---

## Architecture

```
┌──────────────────────────────────────────────────────────────────────┐
│                         MINECRAFT SERVER                              │
│                        (Paper 1.21 / Java)                           │
│                                                                      │
│   /jiraboard spawn         Move book between frames                  │
│         │                          │                                 │
│         ▼                          ▼                                 │
│   BoardSpawner              ItemFrameListener                        │
│   (build board from         (detect movement,                        │
│    live Jira data)           extract ticket key)                     │
│         │                          │                                 │
│         │         ┌────────────────┼────────────────┐                │
│         ▼         ▼                ▼                ▼                │
│    ┌─────────────────┐    ┌─────────────────┐  ┌────────────┐       │
│    │  Jira REST API  │    │  Jira REST API  │  │ AI Hopper  │       │
│    │  (fetch sprint) │    │  (transition)   │  │ (throw book)│      │
│    └─────────────────┘    └─────────────────┘  └─────┬──────┘       │
│                                                      │               │
└──────────────────────────────────────────────────────┼───────────────┘
                                                       │
                                                       ▼
                                            ┌─────────────────────┐
                                            │   MCP Server (Node)  │
                                            │                     │
                                            │  Claude / Bedrock   │
                                            │  (analyze ticket,   │
                                            │   generate code)    │
                                            │         │           │
                                            │         ▼           │
                                            │   GitHub CLI (gh)   │
                                            │   (create PR)       │
                                            └─────────────────────┘
```

---

## Tech Stack

| Layer | Technology | Why |
|-------|-----------|-----|
| Minecraft Server | Paper 1.21 | Modern Minecraft server with plugin API |
| Plugin | Java 21 | Event-driven listeners, async HTTP via OkHttp |
| Jira Integration | REST API v3 + OAuth | Real-time ticket search and transitions |
| AI Orchestration | Node.js + Express | Lightweight MCP server bridging Minecraft to Claude |
| Code Generation | Claude Sonnet 4.5 (AWS Bedrock) | Analyzes tickets and generates implementations |
| PR Creation | GitHub CLI | Branches, commits, and opens PRs automatically |
| World Design | Minecraft Datapack | Feudal Japanese town built with mcfunction files |

---

## The World

The board lives inside a custom-built feudal Japanese town — a ceremonial plaza surrounded by houses, walking paths, and a five-tier pagoda (the "MCP Tower"). The entire world is generated from a datapack with 17 mcfunction files. It's not just a board floating in space; it's a place your team gathers for standup.

Run `/standup` and all online players teleport to the board in a semicircle, ready to discuss the sprint.

---

## Key Commands

| Command | What it does |
|---------|-------------|
| `/jiraboard spawn` | Build the board from your live Jira sprint |
| `/jiraboard refresh` | Rebuild with fresh data |
| `/jiraboard delete` | Destroy the board (with TNT, naturally) |
| `/jiraboard setaihopper` | Mark a hopper as the AI implementation trigger |
| `/standup` | Teleport everyone to the board |

---

## What Makes This Impressive

- **It actually works end-to-end** — move a book, Jira updates; throw a book, a real PR appears on GitHub
- **Fully async** — Jira calls and AI generation never lag the Minecraft server
- **Two-phase architecture** — clean separation between the Java plugin (game events + Jira) and the Node.js MCP server (AI + GitHub)
- **Production-grade details** — duplicate transition prevention, error handling with player feedback, configurable fireworks, debug mode
- **Playful UX** — color-coded books, fireworks on completion, elevator music during AI generation, TNT on board deletion

---

## Want to run it?

See [QUICKSTART.md](QUICKSTART.md) for a 5-minute setup, or [SETUP-GUIDE.md](SETUP-GUIDE.md) for the full walkthrough.

---

Built by **Team Byndiecraft** for the Bynder Hackathon 2026.
