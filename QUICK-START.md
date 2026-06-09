# ⚡ Byndiecraft Quick Start

## 🚀 5-Minute Setup

### 1. Build Plugin
```bash
cd ~/Documents/Bynder/Github/byndiecraft-plugin
./gradlew build
```
✅ **Plugin built**: `build/libs/byndiecraft-plugin-1.0.0-SNAPSHOT.jar`

### 2. Get Jira API Token
1. Go to: https://id.atlassian.com/manage-profile/security/api-tokens
2. Create token → Copy it
3. Save for next step

### 3. Install & Configure
```bash
# Copy to server plugins directory
cp build/libs/byndiecraft-plugin-1.0.0-SNAPSHOT.jar /path/to/server/plugins/

# Set environment variable
export JIRA_API_TOKEN="your_token_here"

# Start server
cd /path/to/server
java -Xmx2G -jar paper.jar
```

### 4. Configure Board
Edit `plugins/Byndiecraft/config.yml`:
```yaml
jira:
  email: "your.email@bynder.com"  # ← Change this!
```

Add your frame coordinates:
```yaml
board:
  columns:
    - name: "To Do"
      jira_status_name: "To Do"
      frames:
        - { x: 100, y: 64, z: 200 }  # ← Your coordinates
```

Restart: `/reload confirm`

### 5. Test It!
1. Create written book with title: `SHARE-123`
2. Place in item frame
3. See: `✓ SHARE-123 moved to 'To Do'`
4. Check Jira - ticket updated! 🎉

## 📝 Book Format
- Title: `SHARE-123` or `SHARE-123: Summary`
- Must be **Written Book** (signed)
- Ticket key format: `PROJECT-NUMBER`

## 🎮 Commands
```
/jiraboard info      # Show board config
/jiraboard setup     # Setup guide
/jiraboard addcolumn <name> <status>  # Add column
```

## 🐛 Troubleshooting
| Problem | Solution |
|---------|----------|
| "API token not configured" | Set `JIRA_API_TOKEN` env var or in config.yml |
| "Failed to update ticket" | Check ticket exists, you have permission, and status transition is valid |
| "No valid ticket key" | Book title must contain `PROJECT-123` format |

**Enable debug mode**: Set `debug: true` in config.yml

## 🎬 Demo Checklist
- [ ] Server running, plugin loaded
- [ ] Board built with item frames
- [ ] 3-5 real Jira tickets ready
- [ ] Books created with ticket keys
- [ ] Browser open to Jira board
- [ ] Screen sharing ready (split: Minecraft + Jira)

## 📁 Project Structure
```
byndiecraft-plugin/
├── build/libs/byndiecraft-plugin-1.0.0-SNAPSHOT.jar  ← Deploy this
├── README.md           ← Full documentation
├── SETUP-GUIDE.md      ← Step-by-step setup
└── QUICK-START.md      ← This file!
```

---
**Need more help?** See `SETUP-GUIDE.md` for detailed instructions.
