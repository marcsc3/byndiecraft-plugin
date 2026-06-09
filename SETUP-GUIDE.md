# 🎮 Byndiecraft Setup Guide

## Step-by-Step Installation

### 1. Generate Jira API Token

1. **Log into Jira** at https://bynder.atlassian.net
2. **Go to Profile Settings**:
   - Click your profile icon (top right)
   - Select "Manage account"
   - Or go directly to: https://id.atlassian.com/manage-profile/security/api-tokens
3. **Create API Token**:
   - Click "Create API token"
   - Give it a label: `Byndiecraft Hackathon`
   - Click "Create"
   - **Copy the token immediately** (you won't be able to see it again!)
4. **Save the token** securely - you'll need it in the next step

### 2. Set Up Paper Server (if you don't have one)

```bash
# Create server directory
mkdir minecraft-server
cd minecraft-server

# Download Paper 1.21
curl -o paper.jar https://api.papermc.io/v2/projects/paper/versions/1.21/builds/90/downloads/paper-1.21-90.jar

# Accept EULA
echo "eula=true" > eula.txt

# Start server once to generate files
java -Xmx2G -Xms2G -jar paper.jar --nogui
```

Wait for "Done!" message, then stop the server with `/stop` in console.

### 3. Install Byndiecraft Plugin

```bash
# Copy plugin to plugins directory
cp ~/Documents/Bynder/Github/byndiecraft-plugin/build/libs/byndiecraft-plugin-1.0.0-SNAPSHOT.jar plugins/

# Start server again
java -Xmx2G -Xms2G -jar paper.jar --nogui
```

The plugin will create a config file at `plugins/Byndiecraft/config.yml`.

### 4. Configure Jira Credentials

**Option A: Environment Variable (Recommended)**

```bash
# Set environment variable
export JIRA_API_TOKEN="your_token_from_step_1"

# Start server with the environment variable
java -Xmx2G -Xms2G -jar paper.jar --nogui
```

**Option B: Direct Config (Less secure)**

Edit `plugins/Byndiecraft/config.yml`:

```yaml
jira:
  url: "https://bynder.atlassian.net"
  email: "your.email@bynder.com"  # ← Change this
  api_token: "your_api_token_here"  # ← Paste your token
  project_key: "TAP"
```

### 5. Reload Plugin

In the Minecraft console or as an in-game operator:
```
/reload confirm
```

Check the console logs - you should see:
```
[Byndiecraft] ✓ Jira client initialized: https://bynder.atlassian.net
[Byndiecraft] ✓ Board loaded: 3 columns
```

## In-Game Setup

### 1. Join the Server

Connect to `localhost` (or your server IP) in Minecraft 1.21.

### 2. Build Your Jira Board

Create a wall with item frames organized into columns:

```
╔════════════════════════════════════════╗
║           BYNDIECRAFT BOARD            ║
╠════════════╦════════════╦═══════════════╣
║   To Do    ║ In Progress║     Done      ║
╠════════════╬════════════╬═══════════════╣
║ [Frame] [F]║ [Frame] [F]║ [Frame] [Frame]║
║ [Frame] [F]║ [Frame] [F]║ [Frame] [Frame]║
║ [Frame] [F]║ [Frame] [F]║ [Frame] [Frame]║
╚════════════╩════════════╩═══════════════╝
```

**Tips:**
- Use different colored blocks as column backgrounds
- Add signs above each column with the status name
- Keep frames at the same Y level for a cleaner look

### 3. Get Frame Coordinates

Stand next to an item frame and run:
```
/execute at @p run tp ~ ~ ~
```

Note the X, Y, Z coordinates shown.

### 4. Configure Board in config.yml

Stop the server and edit `plugins/Byndiecraft/config.yml`:

```yaml
board:
  world: "world"  # ← Your world name
  columns:
    - name: "To Do"
      jira_status_name: "To Do"
      frames:
        - { x: 100, y: 64, z: 200 }  # ← Your frame coordinates
        - { x: 100, y: 65, z: 200 }
        - { x: 100, y: 66, z: 200 }
    
    - name: "In Progress"
      jira_status_name: "In Progress"
      frames:
        - { x: 105, y: 64, z: 200 }
        - { x: 105, y: 65, z: 200 }
        - { x: 105, y: 66, z: 200 }
    
    - name: "Done"
      jira_status_name: "Done"
      frames:
        - { x: 110, y: 64, z: 200 }
        - { x: 110, y: 65, z: 200 }
        - { x: 110, y: 66, z: 200 }
```

**Important:** The `jira_status_name` must **exactly match** the status names in your Jira project!

### 5. Restart Server

```bash
java -Xmx2G -Xms2G -jar paper.jar --nogui
```

### 6. Verify Configuration

In-game, run:
```
/jiraboard info
```

You should see your board layout with all configured frames.

## Create Ticket Books

### 1. Get Real Jira Tickets

Go to https://bynder.atlassian.net/projects/TAP and note some ticket keys (e.g., `TAP-123`, `TAP-456`).

### 2. Create Written Books

In Minecraft:
1. Craft a **Book and Quill** (book + feather + ink sac)
2. Write the ticket key as the title:
   - Format: `TAP-123: Brief summary`
   - Or just: `TAP-123`
3. Click "Sign" (not "Sign and Close")
4. This creates a **Written Book**

**Pro tip:** Use `/give @s written_book` to skip crafting.

### 3. Place Books in Frames

- Right-click an item frame with a written book
- The book appears in the frame
- Check chat - you should see: `⏳ Updating TAP-123 to 'To Do'...`
- Then: `✓ TAP-123 moved to 'To Do'`

### 4. Move Books Between Columns

- Right-click the frame to remove the book
- Place it in a different column's frame
- Jira will update automatically!

## Troubleshooting

### "Failed to update ticket in Jira"

**Check the console logs** for details. Common issues:

1. **Invalid ticket key**
   - Make sure the ticket exists in your Jira project
   - Format must be `PROJECT-NUMBER` (e.g., `TAP-123`)

2. **Permission denied**
   - You need permission to transition tickets in Jira
   - Ask your Jira admin for "Edit Issues" permission

3. **Invalid transition**
   - The target status might not be available for this ticket type
   - Check Jira workflow: Can you manually move the ticket to that status?

4. **Network error**
   - Check server internet connection
   - Verify Jira URL is correct

### "API token not configured"

Make sure either:
- Environment variable `JIRA_API_TOKEN` is set, OR
- `jira.api_token` in config.yml has your actual token (not `${JIRA_API_TOKEN}`)

### "No valid Jira ticket key found"

Book title must contain a valid ticket key matching the pattern `[A-Z]+-\d+`.

Examples:
- ✅ `TAP-123`
- ✅ `TAP-123: Fix login bug`
- ✅ `Working on TAP-456 today`
- ❌ `tap-123` (lowercase)
- ❌ `TAP123` (missing dash)
- ❌ `Just a note` (no ticket key)

### Enable Debug Mode

Set `debug: true` in config.yml to see detailed API calls:

```yaml
debug: true
```

Restart the plugin, then check logs for:
```
[Byndiecraft] Fetching issue: TAP-123
[Byndiecraft] Issue fetched: TAP-123 - To Do
[Byndiecraft] Fetching transitions for: TAP-123
[Byndiecraft]   Transition: In Progress (ID: 21)
[Byndiecraft]   Transition: Done (ID: 31)
[Byndiecraft] Transitioning TAP-123 with transition ID: 21
```

## Demo Script (Hackathon Presentation)

### Setup (Before Demo)
1. ✅ Server running with plugin loaded
2. ✅ Board built and configured
3. ✅ 3-5 real Jira tickets ready (from TAP project)
4. ✅ Books created with those ticket keys
5. ✅ Browser open to Jira board view
6. ✅ Screen sharing: Split screen (Minecraft + Jira)

### Demo Flow (5 minutes)

**1. Introduction (30 seconds)**
- "We wanted to make stand-ups more fun..."
- "So we built a Minecraft Jira board!"

**2. Show the Board (30 seconds)**
- Pan camera across the Minecraft board
- Point out the three columns (To Do, In Progress, Done)

**3. Live Sync Demo (2 minutes)**
- **Teammate 1:** "I'm starting work on TAP-123"
  - Places book in "In Progress" frame
  - ✓ Success message appears
  - **Switch to browser** → Show Jira updated instantly
  
- **Teammate 2:** "I finished TAP-456!"
  - Moves book to "Done" frame
  - ✓ Success message appears
  - **Switch to browser** → Show Jira updated

- **You:** "TAP-789 is blocked"
  - (If you added a "Blocked" column) Move book there
  - Show update in Jira

**4. Error Handling (30 seconds)**
- Try to place a book with fake ticket (`TAP-9999`)
- Show error message: `✗ Failed to update TAP-9999 in Jira`
- Explain: "We validate tickets exist and handle errors gracefully"

**5. Wrap Up (30 seconds)**
- Show quick code snippet of the Jira API integration
- Mention Phase 2 features (bi-directional sync)
- Thank judges!

### Talking Points
- ✅ "Makes stand-ups more engaging and visual"
- ✅ "Real-time sync with Jira's REST API"
- ✅ "Built in 6 hours using AI assistance"
- ✅ "Extensible: could add webhooks, polling, analytics..."

## Next Steps (Phase 2)

If you have extra time, consider adding:

- [ ] **Bi-directional sync**: Poll Jira every 60 seconds and update Minecraft
- [ ] **Visual effects**: Particles when books are moved
- [ ] **Sound effects**: Different sounds for success/error
- [ ] **Jira webhooks**: Real-time push from Jira → Minecraft
- [ ] **Multi-board support**: Multiple boards in different locations
- [ ] **Assignee visualization**: Use player heads to show who's assigned

## Support

**Console logs:** `logs/latest.log`

**Plugin config:** `plugins/Byndiecraft/config.yml`

**Commands:**
- `/jiraboard info` - Show board configuration
- `/jiraboard setup` - Display setup guide

Good luck with your hackathon! 🚀
