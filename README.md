# 🎮 Byndiecraft - Minecraft Jira Board Integration

> **Hackathon Project**: Recreate team stand-ups in Minecraft by syncing Jira tickets with in-game item frames!

## 🌟 Overview

Byndiecraft allows you to visualize and interact with your Jira board directly in Minecraft. Move written books between item frames to update ticket statuses in real-time!

### Features

- ✅ **Auto Board Spawning**: Run `/jiraboard spawn` to build the entire board from live Jira data
- ✅ **Visual Jira Board**: Dynamic columns auto-created from ticket statuses
- ✅ **Book-Based Tickets**: Written books auto-generated from Jira tickets
- ✅ **Real-Time Sync**: Moving books triggers Jira API calls to update ticket status
- ✅ **Instant Feedback**: Players receive chat messages on successful/failed updates
- ✅ **Refresh**: Run `/jiraboard refresh` to tear down and rebuild with fresh data
- 🚧 **Bi-directional Sync**: (Phase 2) Jira changes reflect back in Minecraft

## 🚀 Quick Start

### Prerequisites

- Java 21 or higher (including Java 25!)
- Maven 3.6+ or Gradle 8.x
- Paper/Spigot 1.21 Minecraft server
- Jira Cloud account with API access

### Installation

1. **Build the plugin:**
   
   **Option A: Maven (Recommended for Java 25)**
   ```bash
   cd byndiecraft-plugin
   mvn clean package
   ```
   Output: `target/byndiecraft-plugin-1.0.0-SNAPSHOT.jar`

   **Option B: Gradle**
   ```bash
   cd byndiecraft-plugin
   ./gradlew build
   ```
   Output: `build/libs/byndiecraft-plugin-1.0.0-SNAPSHOT.jar`

   > **Note:** If you're on Java 25, use Maven (it has better Java 25 support). Gradle requires Java 21 to run. See [BUILD.md](BUILD.md) for details.

2. **Copy to server:**
   ```bash
   # Maven
   cp target/byndiecraft-plugin-1.0.0-SNAPSHOT.jar /path/to/server/plugins/
   
   # Or Gradle
   cp build/libs/byndiecraft-plugin-1.0.0-SNAPSHOT.jar /path/to/server/plugins/
   ```

3. **Configure Jira credentials:**
   
   Edit `plugins/Byndiecraft/config.yml`:
   ```yaml
   jira:
     url: "https://bynder.atlassian.net"
     email: "your-email@bynder.com"
     api_token: "YOUR_API_TOKEN_HERE"
     project_key: "SHARE"
   ```

   Or set environment variable before starting server:
   ```bash
   export JIRA_API_TOKEN="your_token_here"
   ```

4. **Generate Jira API Token:**
   - Go to https://id.atlassian.com/manage-profile/security/api-tokens
   - Click "Create API token"
   - Copy the token and add it to config.yml or environment variable

5. **Restart server**

## 🎯 How to Use

### 1. Spawn the Board

Simply run the command in-game:
```
/jiraboard spawn
```

This will:
- Fetch all tickets from your Jira project
- Build a backing wall with item frames at the configured anchor point
- Auto-create columns for every status found in your tickets
- Place sign headers above each column
- Create written books for each ticket and place them in the correct column

### 2. Configure the Anchor Point

Set where the board spawns in `config.yml`:

```yaml
board:
  world: "world"
  anchor:
    x: 100
    y: 64
    z: 200
```

To find coordinates: stand where you want the board's top-left corner and press **F3**.

If no anchor is configured, the board spawns at the player's current position.

### 3. Move Tickets!

- Pick up a book from one column's item frame
- Place it in a different column's item frame
- Jira updates automatically!
- You'll receive a chat message: `✓ SHARE-123 moved to 'In Progress'`

### 4. Refresh the Board

To rebuild the board with fresh Jira data:
```
/jiraboard refresh
```

This clears the existing board and respawns it with current ticket statuses.

## 📋 Commands

| Command | Description | Permission |
|---------|-------------|------------|
| `/jiraboard spawn` | Spawn/create the Jira board in-world | `byndiecraft.admin` |
| `/jiraboard refresh` | Rebuild board with fresh Jira data | `byndiecraft.admin` |
| `/jiraboard info` | Show board configuration | `byndiecraft.use` |
| `/jiraboard setup` | Display setup guide | `byndiecraft.admin` |
| `/jiraboard addcolumn <name> <status>` | Add a status column | `byndiecraft.admin` |

## 🔧 Configuration

### config.yml Structure

```yaml
jira:
  url: "https://bynder.atlassian.net"
  email: "your-email@bynder.com"
  api_token: "${JIRA_API_TOKEN}"  # Environment variable or direct value
  project_key: "SHARE"

board:
  world: "world"
  anchor:
    x: 100
    y: 64
    z: 200
  # Pre-configured columns (optional — columns are also auto-created
  # from ticket statuses found in Jira at spawn time)
  columns:
    - name: "Ready to be Picked Up"
      jira_status_name: "Ready to be Picked Up"
      frames: []
    - name: "In Progress"
      jira_status_name: "In Progress"
      frames: []
    - name: "Review"
      jira_status_name: "Review"
      frames: []
    - name: "Merge"
      jira_status_name: "Merge"
      frames: []
    - name: "Done"
      jira_status_name: "Done"
      frames: []

debug: false  # Set to true for verbose logging
```

### Finding Anchor Coordinates

Stand where you want the board's top-left corner and press **F3** to see your coordinates, or run:
```
/execute at @p run tp ~ ~ ~
```

## 🎬 Demo Script (Hackathon)

1. **Spawn the board**: Run `/jiraboard spawn` — watch the board build itself from live Jira data
2. **Show the board**: Point out columns with sign headers and books with ticket details
3. **Simulate stand-up**:
   - Player 1: "I'm picking up SHARE-302795" → moves book to "In Progress"
   - Show browser with Jira board updating live
   - Player 2: "I finished SHARE-12783" → moves book to "Done"
   - Show browser update again
4. **Refresh**: Run `/jiraboard refresh` to show it rebuilds with current state
5. **Error handling**: Try invalid ticket key → see error message

## 🏗 Architecture

```
Minecraft Server (Paper)
├── ByndiecraftPlugin (Main)
├── BoardSpawner (Builds board: frames, signs, books)
├── ItemFrameListener (Detects book movements)
├── BoardManager (Tracks frame coordinates)
├── JiraClient (HTTP client for Jira API)
│   ├── searchIssues() — JQL search for project tickets
│   └── transitionIssue() — Move ticket to new status
└── Commands (/jiraboard spawn, refresh, info)
         ↓
    Jira REST API
```

## 🐛 Troubleshooting

### "Failed to update ticket"
- Check if the ticket exists in Jira
- Verify you have permission to transition the ticket
- Ensure the target status exists for that ticket type

### "API token not configured"
- Make sure `JIRA_API_TOKEN` environment variable is set, or
- Add the token directly to `config.yml` (not recommended for production)

### "No valid Jira ticket key found"
- Book title must contain a valid ticket key (e.g., `SHARE-123`)
- Format: `PROJECT-NUMBER`

### Enable Debug Mode
Set `debug: true` in config.yml to see detailed logs.

## 🔧 Building from Source

### Maven (Recommended)
```bash
# Install Maven if needed
sudo apt install maven  # Ubuntu/Debian
brew install maven      # macOS

# Build
mvn clean package

# Output
target/byndiecraft-plugin-1.0.0-SNAPSHOT.jar
```

### Gradle
```bash
# Build
./gradlew clean build

# Output
build/libs/byndiecraft-plugin-1.0.0-SNAPSHOT.jar
```

**Java 25 Users:** Maven works out-of-the-box on Java 25. Gradle requires Java 21 to run the build. See [BUILD.md](BUILD.md) for complete build instructions and [BUILD-ON-JAVA25.md](BUILD-ON-JAVA25.md) for Gradle workarounds.

## 🚀 Phase 2 Features (Roadmap)

- [ ] Bi-directional sync (Jira → Minecraft via polling)
- [ ] Auto-refresh on interval (every 60 seconds)
- [ ] Jira webhooks for real-time updates
- [ ] Visual effects (particles, sounds on spawn/transition)
- [ ] Multi-board support (multiple projects)
- [ ] Persistent board state in database
- [ ] Configurable max tickets per column

## 👥 Team Byndiecraft

Built with ❤️ during the Bynder Hackathon

## 📄 License

Internal Bynder project for hackathon demonstration.

---

**Need help?** Check the logs in `logs/latest.log` or run `/jiraboard setup` in-game.
