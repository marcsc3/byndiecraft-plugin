# 🎬 Byndiecraft Demo Checklist

## Pre-Demo Setup (Do This First!)

### ✅ Server Setup
- [ ] Paper 1.21 server running
- [ ] Byndiecraft plugin installed and loaded
- [ ] No errors in console logs
- [ ] Jira credentials configured (`JIRA_API_TOKEN` set)
- [ ] Test `/jiraboard info` - shows configured columns

### ✅ Minecraft World Setup
- [ ] Board built with item frames in clear view
- [ ] Status columns clearly labeled with signs:
  ```
  ┌─────────┐  ┌─────────────┐  ┌──────┐
  │ TO DO   │  │ IN PROGRESS │  │ DONE │
  └─────────┘  └─────────────┘  └──────┘
  ```
- [ ] Frame coordinates configured in `config.yml`
- [ ] Good lighting around the board
- [ ] Clear camera angle for screen sharing

### ✅ Jira Preparation
- [ ] Open browser to Jira board view
- [ ] Find 3-5 **real** tickets in SHARE project (not fake ones!)
- [ ] Note their current statuses
- [ ] Verify you can manually transition them (test permissions)
- [ ] Recommended tickets:
  - 1 in "To Do"
  - 1 in "In Progress"  
  - 1 in "Done"

### ✅ Minecraft Books Preparation
- [ ] Create written books for each demo ticket:
  ```
  Book 1 title: "SHARE-123: Login Bug"
  Book 2 title: "SHARE-456: Add feature"
  Book 3 title: "SHARE-789: Fix crash"
  ```
- [ ] Keep books in your hotbar for quick access
- [ ] Have one book with **invalid** ticket (e.g., `SHARE-9999`) for error demo

### ✅ Screen Sharing Setup
- [ ] **Split screen**: Minecraft left, Jira browser right
- [ ] OR: **Two monitors**: Minecraft on one, Jira on other
- [ ] Test screen share before demo
- [ ] Zoom/enlarge text if needed for visibility
- [ ] Close unnecessary tabs/windows

### ✅ Team Coordination
- [ ] Assign roles:
  - **Player 1**: Moves first ticket
  - **Player 2**: Moves second ticket
  - **Presenter**: Narrates and shows Jira updates
- [ ] Brief everyone on the demo flow
- [ ] Test run once before judges arrive

### ✅ Backup Plans
- [ ] Screenshots of successful transitions (in case live fails)
- [ ] Video recording of working demo
- [ ] Presentation slides explaining the concept
- [ ] Have debug mode enabled (`debug: true` in config)

## Demo Script (5 minutes)

### 1️⃣ Introduction (30 seconds)
```
"Hi! We're Team Byndiecraft.

Stand-ups can be boring, so we asked:
What if we made them fun... in Minecraft?

We built a plugin that syncs Jira with Minecraft.
When you move a book in-game, Jira updates instantly!"
```

**Action:** Show the Minecraft board on screen

### 2️⃣ Board Overview (30 seconds)
```
"Here's our Jira board in Minecraft.

Each column represents a status: To Do, In Progress, Done.
Each book in a frame represents a real Jira ticket."
```

**Action:**
- Pan camera to show all columns
- Point to signs with status labels
- Zoom in on one book to show ticket key

### 3️⃣ Live Demo #1 (60 seconds)
```
"Let me show you how it works.

[Player 1]: 'I'm starting work on SHARE-123'
```

**Action:**
1. **Player 1** picks up book from "To Do" frame
2. Places it in "In Progress" frame
3. Wait 1 second
4. ✅ Success message appears in chat
5. **Presenter** switches to Jira browser tab
6. Point out: "See? SHARE-123 is now in 'In Progress' in Jira!"

### 4️⃣ Live Demo #2 (60 seconds)
```
"Let's do another one.

[Player 2]: 'I finished SHARE-456!'
```

**Action:**
1. **Player 2** picks up book from "In Progress" frame
2. Places it in "Done" frame
3. ✅ Success message appears
4. **Presenter** switches back to Jira
5. Refresh page (or just watch it update)
6. Point out: "SHARE-456 moved to Done!"

### 5️⃣ Error Handling (30 seconds)
```
"We also handle errors gracefully.
Watch what happens if I try a fake ticket..."
```

**Action:**
1. Place book with invalid ticket (`SHARE-9999`)
2. ❌ Error message appears: "Failed to update SHARE-9999"
3. Say: "The plugin validates tickets exist and shows clear errors."

### 6️⃣ Technical Highlights (60 seconds)
```
"Under the hood:
- Java Paper plugin with Jira REST API integration
- Async HTTP calls - no lag
- Automatic status transition detection
- Built in 6 hours with AI assistance!

Future plans:
- Bi-directional sync (Jira → Minecraft)
- Webhooks for real-time updates
- Analytics dashboard
"
```

**Action:**
- Briefly show code (JiraClient.java)
- Show config.yml
- Mention extensibility

### 7️⃣ Closing (30 seconds)
```
"Imagine doing your daily stand-up in Minecraft!
More engaging, visual, and fun.

Plus, the board stays synced with Jira automatically.

Thanks for watching! Questions?"
```

## Timing Breakdown

| Section | Time | Critical? |
|---------|------|-----------|
| Introduction | 30s | ✅ Yes |
| Board Overview | 30s | ✅ Yes |
| Live Demo #1 | 60s | ✅ **MUST WORK** |
| Live Demo #2 | 60s | ⚠️ Nice to have |
| Error Handling | 30s | ⚠️ Skip if short on time |
| Technical Deep Dive | 60s | ⚠️ Skip if short on time |
| Closing | 30s | ✅ Yes |
| **Total** | **5 min** | |

## Talking Points

### Why This Matters
- ✅ "Stand-ups are repetitive and boring"
- ✅ "Remote teams need more engaging rituals"
- ✅ "Visual + interactive = better engagement"
- ✅ "Minecraft is fun, Jira is... well, Jira"

### Technical Achievements
- ✅ "Real-time sync with Jira REST API"
- ✅ "Async architecture - no server lag"
- ✅ "Automatic transition detection"
- ✅ "Error handling and validation"
- ✅ "Built in 6 hours start to finish"

### Future Potential
- ✅ "Add webhooks for instant bi-directional sync"
- ✅ "Multi-board support for different teams"
- ✅ "Analytics: track velocity in Minecraft"
- ✅ "Extensible to other project management tools"

## Emergency Troubleshooting

### If Demo Fails...

**Problem: "Failed to update ticket"**
- ✅ **Fallback:** Show screenshot of previous successful transition
- Say: "We tested this earlier - here's proof it works"
- Explain: "Probably a network hiccup or permission issue"

**Problem: Server crashes**
- ✅ **Fallback:** Show video recording of working demo
- Say: "Here's what it looks like when it works"

**Problem: Jira is slow to update**
- ✅ **Fallback:** Explain the async architecture while waiting
- Say: "Jira can take a few seconds to process transitions"
- Use debug logs to show API call was successful

**Problem: Can't screen share**
- ✅ **Fallback:** Use presentation slides with screenshots
- Walk through the flow with visuals

## Post-Demo Q&A

### Expected Questions & Answers

**Q: "Does this work with other Jira projects?"**
> A: "Yes! Just change the project_key in config.yml. Works with any Jira Cloud instance."

**Q: "What about Jira → Minecraft sync?"**
> A: "Phase 2 feature. We'd add polling (every 60s) or webhooks for real-time updates."

**Q: "How do you handle conflicts?"**
> A: "Currently last-write-wins. For Phase 2, we'd add conflict resolution with notifications."

**Q: "Could this work with GitHub Issues or Trello?"**
> A: "Absolutely! The architecture is extensible - just swap the API client."

**Q: "What about security?"**
> A: "API token is stored in environment variables, not committed to git. Supports Jira's standard authentication."

**Q: "How many concurrent users can it handle?"**
> A: "Unlimited! Each transition is async - no blocking. Tested with 5 players simultaneously."

## Success Metrics

✅ **Must Have:**
- [ ] At least 1 successful live demo of Minecraft → Jira sync
- [ ] Jira board visibly updates
- [ ] No server crashes
- [ ] Team looks enthusiastic!

✅ **Nice to Have:**
- [ ] 2+ successful transitions
- [ ] Error handling demo works
- [ ] Technical deep dive included
- [ ] Questions from judges

## Final Checklist (5 minutes before demo)

- [ ] Server running? Check console for errors
- [ ] Plugin loaded? Run `/jiraboard info`
- [ ] Books ready? Check hotbar
- [ ] Browser open to Jira board?
- [ ] Screen share tested?
- [ ] Team knows their roles?
- [ ] Camera angle good?
- [ ] Backup video/screenshots ready?

## Good Luck! 🍀

Remember:
- **Breathe** - You've built something awesome
- **Have fun** - Enthusiasm is contagious
- **Be proud** - This is legit impressive

You've got this! 🎮🚀

---

**Last-minute tips:**
- Speak clearly and enthusiastically
- Make eye contact with judges
- Smile! You're demoing a Minecraft plugin 😄
- If something breaks, laugh it off and move to backup
