# 🧪 Testing Guide - Step by Step

## Prerequisites Check

Run these commands to verify setup:

```bash
# 1. Check plugin is loaded
/plugins

# 2. Check board configuration
/jiraboard info
```

You should see:
```
=== Byndiecraft Jira Board ===
World: world
Columns: X
```

If columns = 0, you need to configure frames!

## Step 1: Configure Frames

### Option A: Get Coordinates Manually

1. **Place item frames** on a wall in a column layout
2. **Stand next to the first frame** in "To Do" column
3. **Run:** `/execute at @p run tp ~ ~ ~`
4. **Note the coordinates** (example: `-100, 64, 200`)
5. **Repeat for each frame**

### Option B: Use Debug Mode

1. Enable debug in `plugins/Byndiecraft/config.yml`:
   ```yaml
   debug: true
   ```
2. Restart server: `/reload confirm`
3. Right-click an item frame - console shows coordinates

### Add to Config

Edit `plugins/Byndiecraft/config.yml`:

```yaml
board:
  world: "world"  # Your world name
  columns:
    - name: "To Do"
      jira_status_name: "To Do"
      frames:
        - { x: -100, y: 64, z: 200 }  # First frame
        - { x: -100, y: 65, z: 200 }  # Second frame
        - { x: -100, y: 66, z: 200 }  # Third frame
    
    - name: "In Progress"
      jira_status_name: "In Progress"
      frames:
        - { x: -95, y: 64, z: 200 }
        - { x: -95, y: 65, z: 200 }
    
    - name: "Done"
      jira_status_name: "Done"
      frames:
        - { x: -90, y: 64, z: 200 }
        - { x: -90, y: 65, z: 200 }
```

**Reload:** `/reload confirm`

## Step 2: Create a Test Book

### In-Game Commands:

```
/give @s writable_book
```

### Write the Book:

1. **Open the book** (right-click)
2. **Write anything on the first page** (or leave blank)
3. **Click "Sign"** at the bottom
4. **TITLE:** Type a real Jira ticket key
   - Example: `SHARE-123`
   - Or: `SHARE-123: Test ticket`
5. **Click "Sign and Close"**

⚠️ **CRITICAL:** The ticket key **MUST** be in the **TITLE**, not the content!

### Valid Title Formats:

✅ `SHARE-123`  
✅ `SHARE-123: Fix bug`  
✅ `Working on SHARE-456`  

❌ `tap-123` (lowercase)  
❌ `SHARE123` (no dash)  
❌ `My book` (no ticket key)

## Step 3: Test the Sync

### Place Book in Frame:

1. **Hold the written book**
2. **Right-click an item frame** (one you configured)
3. **Watch the chat** for feedback:

**Success:**
```
⏳ Updating SHARE-123 to 'To Do'...
✓ SHARE-123 moved to 'To Do'
[*ding* sound]
```

**Error:**
```
✗ Failed to update SHARE-123 in Jira
Check if the ticket exists and you have permission to transition it.
[*error* sound]
```

### Move the Book:

1. **Right-click the frame** to remove the book
2. **Place it in a different column's frame**
3. **Watch for:** `✓ SHARE-123 moved to 'In Progress'`

## Troubleshooting

### "Nothing happens when I place the book"

**Check:**
1. Is the frame registered in config.yml?
   - Run `/jiraboard info` to see configured frames
2. Is it a WRITTEN book (signed)?
   - Regular books don't work
3. Does the title contain a valid ticket key?
   - Format: `PROJECT-NUMBER` (e.g., `SHARE-123`)

**Debug mode:**
```yaml
debug: true  # in config.yml
```
Then check console logs when placing books.

### "Failed to update ticket"

**Check:**
1. Does the ticket exist in Jira?
   - Go to https://bynder.atlassian.net/browse/SHARE-123
2. Do you have permission to edit it?
3. Is your API token correct?
4. Is the status transition valid?
   - Can you manually move the ticket to that status in Jira?

**Check console logs:**
```bash
tail -f logs/latest.log
```

Look for:
```
[Byndiecraft] Fetching issue: SHARE-123
[Byndiecraft] Issue fetched: SHARE-123 - To Do
[Byndiecraft] Fetching transitions for: SHARE-123
[Byndiecraft]   Transition: In Progress (ID: 21)
[Byndiecraft] Transitioning SHARE-123 with transition ID: 21
```

### "Book title shows correctly but still fails"

The ticket might not exist or you don't have permission. Try:

1. **Create a test ticket in Jira:**
   - Go to https://bynder.atlassian.net/projects/SHARE
   - Create a new issue
   - Note the ticket key (e.g., `SHARE-999`)

2. **Use that exact ticket key** in your book title

3. **Verify transitions work:**
   - Try manually moving the ticket in Jira first
   - If you can't, you don't have permission

## Quick Verification Checklist

Before testing:

- [ ] Plugin loaded (`/plugins` shows Byndiecraft in green)
- [ ] Config has frame coordinates (`/jiraboard info` shows frames)
- [ ] Debug mode enabled (`debug: true` in config.yml)
- [ ] API token configured (JIRA_API_TOKEN env var or config.yml)
- [ ] Real Jira ticket exists (check in browser)
- [ ] Book is WRITTEN (signed), not writable
- [ ] Ticket key is in TITLE, not content
- [ ] Ticket key format is correct (`SHARE-123`)

## Example Success Flow

1. `/give @s writable_book`
2. Write book, title = `SHARE-123`
3. Sign book
4. Place in "To Do" frame
5. See: `✓ SHARE-123 moved to 'To Do'`
6. Check Jira - ticket status updated!
7. Remove book from frame
8. Place in "In Progress" frame
9. See: `✓ SHARE-123 moved to 'In Progress'`
10. Check Jira - status changed again!

## Console Debug Output

With `debug: true`, you should see:

```
[Byndiecraft] Book placed: SHARE-123 -> Column: To Do (Jira: To Do)
[Byndiecraft] Fetching issue: SHARE-123
[Byndiecraft] Issue fetched: SHARE-123 - Backlog
[Byndiecraft] Fetching transitions for: SHARE-123
[Byndiecraft]   Transition: To Do (ID: 11)
[Byndiecraft]   Transition: In Progress (ID: 21)
[Byndiecraft]   Transition: Done (ID: 31)
[Byndiecraft] Transitioning SHARE-123 with transition ID: 11
[Byndiecraft] Successfully transitioned SHARE-123
```

---

**Still stuck?** Share the console logs and I'll help diagnose! 🔍
