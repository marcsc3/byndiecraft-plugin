# AI Process Documentation: Byndiecraft

> How we used AI to build an AI-powered Minecraft plugin in 48 hours.

## Tools Used

| Tool | Purpose | Why |
|------|---------|-----|
| **Claude Code** (CLI) | Primary development tool | Full codebase context, file editing, git integration, SSH access to servers |
| **Claude Sonnet 4.5** (AWS Bedrock) | Runtime AI engine | Powers the in-game ticket implementation — reads tickets, writes code, creates PRs |
| **Claude Opus 4.6** | Development AI | Powers Claude Code for building the plugin itself |

## AI-Native Development Lifecycle

Our entire development process was AI-assisted. Claude Code was not just a code generator — it was a collaborator that:

1. **Architected the system** — designed the plugin structure, MCP server pattern, and data flow
2. **Implemented features** — wrote Java (Paper API), JavaScript (Node.js), and YAML configuration
3. **Debugged production issues** — SSH'd into EC2, read logs, diagnosed classloader issues, fixed shell escaping bugs
4. **Deployed code** — committed, pushed, and guided server restarts
5. **Wrote documentation** — README, MCP server docs, this process doc, and the PRD

## Development Timeline

### Day 1 — Foundation (June 9)

**Phase 1: Jira Board**
- Prompted Claude Code to scaffold a Paper plugin with Jira integration
- Iteratively refined: book colors, multi-page descriptions, column sizing
- Fixed production issues live: item frame rotation duplicates, status mapping

**Phase 2: AI Hopper**
- Designed the MCP server architecture through conversation
- Claude Code implemented the full Node.js server (Bedrock + GitHub integration)
- Deployed to EC2, debugged credential/classloader issues via SSH

### Day 2 — Polish & Ship (June 10)

- Fixed `NoClassDefFoundError` — Claude identified ForkJoinPool classloader issue
- Added server-wide broadcasting for all messages
- Improved AI code generation (actual files, not just plans)
- Documentation and PRD

## Key AI Interactions & Prompts

### Effective Patterns

**1. Iterative debugging via SSH**
We gave Claude Code SSH access to the EC2 server. It could read logs, inspect JARs, check running processes, and fix issues without us needing to relay error messages manually.

**2. "Just make it work" delegation**
Rather than specifying exact implementations, we described desired behavior:
> "I want to throw a book into a hopper and have Claude implement the ticket and create a PR"

Claude Code designed the entire data flow: event detection, HTTP calls, Bedrock prompts, git operations.

**3. Production debugging as conversation**
When we hit `NoClassDefFoundError`, the conversation went:
- Us: "I get this error" (paste log)
- Claude: checks class exists in JAR, checks Java versions, identifies ForkJoinPool classloader issue
- Claude: implements fix (custom executor with plugin classloader)
- Claude: commits and pushes
- Us: "it works"

**4. Constraint-driven prompting**
> "The repo will always be in the description of the ticket. Just in case, let's have 'asset-enrichment-agent-svc' be the default one"

Giving Claude both the happy path and the fallback produced robust implementations.

### What Didn't Work

**1. Over-specifying implementation details**
Early prompts that dictated exact class structures led to more back-and-forth than prompts that described desired behavior.

**2. Assuming AI understood Minecraft internals**
Some Paper API specifics (item frame events, Adventure API text) needed explicit correction. The AI would sometimes use deprecated Bukkit APIs.

**3. First-attempt AI code generation**
The MCP server initially generated `IMPLEMENTATION.md` plans instead of actual code. We had to explicitly redesign the prompt format (FILE/CONTENT/END_FILE blocks) to get real implementations.

## Token Economy

We used Claude Code (Opus) for development and Claude Sonnet 4.5 (Bedrock) for runtime. Key efficiency decisions:

- **Reused context**: kept one long conversation rather than starting fresh for each bug
- **Delegated to the right model**: Sonnet for runtime tasks (cheaper, faster), Opus for development (needs full codebase understanding)
- **Minimized round-trips**: gave Claude Code SSH access so it could debug directly instead of us relaying logs back and forth
- **Avoided regeneration**: when something worked, we moved on — no "make it prettier" passes unless needed

## AI in the Product Itself

Byndiecraft doesn't just use AI in development — **AI is the product**:

1. **Repository Detection**: Claude reads ticket descriptions and intelligently routes to the correct GitHub repository from a list of 50+ org repos
2. **Code Generation**: Claude analyzes the ticket, understands the codebase structure (via file tree), and generates actual implementation files
3. **Commit & PR Creation**: The entire git workflow (branch, commit, push, PR) is automated with AI-generated commit messages and PR descriptions

This creates a complete loop: **Jira ticket -> Minecraft interaction -> AI implementation -> GitHub PR** — all without leaving the game.

## Lessons Learned

1. **AI excels at glue code** — connecting APIs (Jira, GitHub, Bedrock) is tedious for humans but trivial for AI
2. **Production debugging is where AI shines** — classloader issues, shell escaping, timeout tuning — all solved faster with AI
3. **The prompt IS the product** — for the MCP server, the quality of Claude's implementation depends entirely on how well we prompt it (file tree context, explicit output format)
4. **Multiplayer adds magic** — broadcasting AI progress to all players turns a solo coding tool into a shared experience
5. **Ship, then fix** — we deployed early and iterated in production, using Claude Code to debug live issues via SSH
