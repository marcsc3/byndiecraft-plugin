# 🎮 Byndiecraft - Hackathon Setup (30 Minutes)

## ✅ Your API Token is Ready!

I've securely saved your Jira API token. Let's get this running!

## Step 1: Get a Minecraft Server (10 min)

### Option A: Download Paper Server (Recommended)

```bash
# Create server directory
mkdir ~/minecraft-byndiecraft-server
cd ~/minecraft-byndiecraft-server

# Download Paper 1.21
curl -o paper.jar https://api.papermc.io/v2/projects/paper/versions/1.21/builds/90/downloads/paper-1.21-90.jar

# Accept EULA
echo "eula=true" > eula.txt

# Copy the plugin
cp ~/Documents/Bynder/Github/byndiecraft-plugin/build/libs/byndiecraft-plugin-1.0.0-SNAPSHOT.jar plugins/
```

### Option B: Use Existing Server

If you already have a Paper/Spigot 1.21 server:

```bash
# Just copy the plugin
cp ~/Documents/Bynder/Github/byndiecraft-plugin/build/libs/byndiecraft-plugin-1.0.0-SNAPSHOT.jar /path/to/your/server/plugins/
```

## Step 2: Configure Your Email (1 min)

Edit the config file that will be created:

**After first server start**, edit: `plugins/Byndiecraft/config.yml`

Change this line:
```yaml
email: "your.email@bynder.com"  # ← Change to your actual Bynder email
```

To your email, for example:
```yaml
email: "marc.soler.colomer@bynder.com"
```

## Step 3: Start Server with API Token (2 min)

```bash
cd ~/minecraft-byndiecraft-server

# Load the API token from setup script
source ~/Documents/Bynder/Github/byndiecraft-plugin/setup-env.sh

# Start server
java -Xmx2G -Xms2G -jar paper.jar --nogui
```

**Watch the console logs** - you should see:
```
[Byndiecraft] =================================
[Byndiecraft]   Byndiecraft Plugin Starting
[Byndiecraft]   Minecraft ❤ Jira Integration
[Byndiecraft] =================================
[Byndiecraft] ✓ Jira client initialized: https://bynder.atlassian.net
[Byndiecraft] ✓ Board loaded: 3 columns
[Byndiecraft] =================================
[Byndiecraft]   Byndiecraft Ready!
[Byndiecraft] =================================
```

If you see warnings about email or token, stop the server, update `config.yml`, and restart.

## Step 4: Join the Server (1 min)

1. Open Minecraft 1.21 Java Edition
2. Multiplayer → Direct Connect
3. Server address: `localhost`
4. Join!

## Step 5: Build Your Jira Board (10 min)

### Quick Board Layout

Use these commands in Minecraft:

```
/gamemode creative
/give @s item_frame 64
/give @s oak_sign 12
```

Build a simple 3-column board:

```
┌──────────────────────────────────────────┐
│           BYNDIECRAFT BOARD              │
├────────────┬─────────────┬───────────────┤
│   TO DO    │ IN PROGRESS │     DONE      │
├────────────┼─────────────┼───────────────┤
│  [Frame]   │   [Frame]   │   [Frame]     │
│  [Frame]   │   [Frame]   │   [Frame]     │
│  [Frame]   │   [Frame]   │   [Frame]     │
└────────────┴─────────────┴───────────────┘
```

**Tips:**
- Use different colored concrete blocks as column backgrounds
- Place signs above columns with status names
- Keep frames at the same Y level for clean look

### Get Frame Coordinates

Stand next to an item frame and run:
```
/execute at @p run tp ~ ~ ~
```

You'll see coordinates like: `Teleported to 100.00, 64.00, 200.00`

Note the **X, Y, Z** values (ignore decimals).

## Step 6: Configure Frame Locations (5 min)

1. **Stop the server**: Type `stop` in console
2. **Edit config**: Open `plugins/Byndiecraft/config.yml`
3. **Add your coordinates**:

```yaml
board:
  world: "world"
  columns:
    - name: "To Do"
      jira_status_name: "To Do"
      frames:
        - { x: 100, y: 64, z: 200 }  # ← Your actual coordinates
        - { x: 100, y: 65, z: 200 }
        - { x: 100, y: 66, z: 200 }
    
    - name: "In Progress"
      jira_status_name: "In Progress"
      frames:
        - { x: 105, y: 64, z: 200 }  # ← Adjust to your layout
        - { x: 105, y: 65, z: 200 }
        - { x: 105, y: 66, z: 200 }
    
    - name: "Done"
      jira_status_name: "Done"
      frames:
        - { x: 110, y: 64, z: 200 }
        - { x: 110, y: 65, z: 200 }
        - { x: 110, y: 66, z: 200 }
```

4. **Restart server**:
```bash
source ~/Documents/Bynder/Github/byndiecraft-plugin/setup-env.sh
java -Xmx2G -Xms2G -jar paper.jar --nogui
```

## Step 7: Test with Real Jira Tickets (3 min)

### Find Real SHARE Tickets

1. Go to: https://bynder.atlassian.net/projects/SHARE
2. Find 3-5 tickets you can use for demo
3. Note their ticket keys (e.g., `SHARE-123`, `SHARE-456`)

**Important:** Make sure these tickets:
- ✅ Actually exist
- ✅ You have permission to edit
- ✅ Can be transitioned between statuses

### Create Books in Minecraft

```
/give @s writable_book 5
```

Or craft: Book + Feather + Ink Sac

**For each book:**
1. Write the ticket key as title: `SHARE-123`
2. Click "Sign and Close"
3. You now have a "Written Book"

### Test the Sync!

1. **Place book in frame** in "To Do" column
2. **Watch chat** - you should see:
   ```
   ⏳ Updating SHARE-123 to 'To Do'...
   ✓ SHARE-123 moved to 'To Do'
   ```
3. **Check Jira** in browser - ticket should be updated!
4. **Move book** to "In Progress" frame
5. **Check Jira again** - status should change!

🎉 **IT WORKS!**

## Troubleshooting

### "API token not configured"
Make sure you ran:
```bash
source ~/Documents/Bynder/Github/byndiecraft-plugin/setup-env.sh
```
**Before** starting the server.

### "Failed to update ticket"
Check console logs for details:
- Is the ticket key valid? (e.g., `SHARE-123`)
- Does the ticket exist in Jira?
- Do you have permission to edit it?
- Can the ticket be transitioned to that status?

### "No valid Jira ticket key found"
Book title must contain the pattern: `PROJECT-123`
- ✅ `SHARE-123`
- ✅ `SHARE-123: Summary`
- ❌ `tap-123` (lowercase)
- ❌ `Just a book` (no ticket key)

### Enable Debug Mode
Already enabled in the config! Check logs for detailed API calls.

## Demo Preparation

Once everything works:

1. **Create 3-5 demo books** with real ticket keys
2. **Practice moving them** between columns
3. **Have Jira board open** in browser for split screen
4. **Prepare screen share** (Minecraft + Jira side-by-side)
5. **Review demo script** in `DEMO-CHECKLIST.md`

## Quick Commands Reference

```bash
# Start server (from server directory)
source ~/Documents/Bynder/Github/byndiecraft-plugin/setup-env.sh
java -Xmx2G -Xms2G -jar paper.jar --nogui

# In-game commands
/jiraboard info          # Show board configuration
/jiraboard setup         # Setup help
/gamemode creative       # Creative mode
/give @s item_frame 64   # Get item frames
/give @s writable_book 5 # Get books
```

## Need Help?

**Check logs:** `logs/latest.log` in server directory

**Console shows:**
- Jira API calls
- Transition attempts
- Error details

**Discord/Slack:** Share the error message with your team

## You're Ready! 🚀

Once you see tickets updating in Jira when you move books in Minecraft, you're all set for the demo!

**Next:** Review `DEMO-CHECKLIST.md` for presentation tips.

Good luck with the hackathon! 🎮✨
