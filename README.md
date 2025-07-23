# 🚀 Kiro Onboarding Quest

A gamified introduction to Kiro - your AI-powered development companion! Complete quests, earn badges, and level up while learning all of Kiro's powerful features.

## 🎬 Demo

<!-- Add your demo GIF or video here -->
![Kiro Quest Demo](./kiro-quest-demo.mp4)
*Experience the gamified onboarding journey*

<!-- Alternative video format:
<video width="600" controls>
  <source src="./demo.mp4" type="video/mp4">
  Your browser does not support the video tag.
</video>
-->

## 🎮 What is Kiro Quest?

Kiro Quest is an interactive onboarding experience that transforms learning Kiro into an engaging adventure. Instead of reading boring documentation, you'll complete hands-on quests that teach you everything from basic chat features to advanced automation.

## ✨ Features

- **9 Progressive Quests** - From beginner to expert level
- **Badge System** - Earn unique badges for each completed quest
- **Level Progression** - Gain points and level up as you master Kiro
- **Visual Progress Tracking** - See completed quests marked with checkmarks
- **Persistent Progress** - Your achievements are saved between sessions
- **Built-in Reset Option** - Safely clear all progress when needed

## 🏆 Quest Overview

| Quest | Difficulty | Badge | Points | What You'll Learn |
|-------|------------|-------|--------|-------------------|
| 1. Explore Interface | Beginner | 🗺️ Explorer | 50 | Navigate Kiro's UI and panels |
| 2. Master Chat | Beginner | 💬 Chat Master | 75 | Use context features like #File, #Problems |
| 3. File Context Magic | Intermediate | 📁 File Wizard | 100 | Reference files and folders in chat |
| 4. Autopilot Mode | Intermediate | 🚁 Autopilot Ace | 125 | Let Kiro modify files autonomously |
| 5. Create Specs | Advanced | 📋 Spec Architect | 150 | Plan features with structured specs |
| 6. Agent Hooks | Advanced | 🎣 Hook Hero | 175 | Automate workflows with event triggers |
| 7. MCP Tools | Expert | 🔌 MCP Pioneer | 200 | Extend Kiro with external tools |
| 8. Steering Files | Expert | 🎯 Steering Captain | 225 | Customize Kiro's behavior |
| 9. Code Assistance | Expert | ⚡ Code Commander | 250 | Master advanced coding features |
| **Complete All** | Champion | 🏆 Quest Champion | 500 | Become a certified Kiro master! |

## 🚀 Getting Started

### Prerequisites

- **jq** - JSON processor for progress tracking
  ```bash
  # macOS
  brew install jq
  
  # Ubuntu/Debian
  sudo apt install jq
  
  # Other systems: https://jqlang.github.io/jq/download/
  ```

### Installation & Usage

1. **Download the quest script:**
   ```bash
   curl -O https://raw.githubusercontent.com/your-repo/kiro-quest.sh
   chmod +x kiro-quest.sh
   ```

2. **Start your adventure:**
   ```bash
   ./kiro-quest.sh
   ```
- **For integrated experience, execute Kiro Quest from within Kiro IDE terminal.

3. **Follow the interactive menu** to choose and complete quests!

## 🎯 How It Works

### Progress Tracking
Your progress is automatically saved to `~/.kiro/quest-progress.json`:
```json
{
  "completed_quests": ["explorer", "chat_master"],
  "total_score": 125,
  "level": 2
}
```

### Badge Collection
Earned badges are stored in `~/.kiro/quest-badges/` as individual files you can view anytime.

### Quest Completion
Each quest provides:
- Clear mission objectives
- Pro tips (including "👻 If unsure, ask Kiro!")
- Example tasks to try
- Self-assessment completion

### Menu Options
- **0-9**: Select and complete quests
- **0**: View your earned badge collection
- **r**: Reset all progress (requires typing "RESET" to confirm)
- **q**: Quit the quest application

## 💡 Pro Tips

- **👻 If unsure or want more info, ask Kiro** - This appears in every quest because Kiro is your best resource!
- **Start with Quest 1** - Even if you've used Kiro before, the progression builds naturally
- **Take your time** - There's no rush; complete quests when you're ready
- **Experiment freely** - The best way to learn is by trying things out
- **Use real projects** - Apply quest learnings to your actual code for maximum benefit

## 🔧 Customization

### Adding New Quests
To add custom quests, modify the script and:
1. Add a new badge description in `get_badge_description()`
2. Create a new quest function following the existing pattern
3. Add the quest to the menu in `quest_menu()`
4. Update the total quest count in `print_progress()`

### Styling
Colors and formatting are defined at the top of the script using ANSI escape codes. Customize them to match your preferences.

## �  Resetting Progress

Need a fresh start? You have several options:

### Built-in Reset (Recommended)
1. Run `./kiro-quest.sh`
2. Choose option `r` for "Reset All Progress"
3. Type `RESET` to confirm (prevents accidental resets)
4. Your quest adventure starts fresh!

### Manual Reset
```bash
# Complete reset - removes all progress and badges
rm -rf ~/.kiro/quest-badges/ ~/.kiro/quest-progress.json

# Reset only badges (keep level/score)
rm -rf ~/.kiro/quest-badges/

# Reset only progress (keep badge files)
rm -f ~/.kiro/quest-progress.json

# Remove specific badges
rm -f ~/.kiro/quest-badges/explorer.badge
```

## 🐛 Troubleshooting

**Quest won't start:**
- Ensure `jq` is installed: `which jq`
- Check script permissions: `chmod +x kiro-quest.sh`

**Progress not saving:**
- Verify write permissions to `~/.kiro/` directory
- Check disk space availability

**Badges not displaying:**
- Ensure `~/.kiro/quest-badges/` directory exists and is writable

**Reset not working:**
- Use the built-in reset option (`r` in main menu) for safest reset
- Ensure you have write permissions to `~/.kiro/` directory

## 🤝 Contributing

Found a bug or have ideas for new quests? Contributions welcome!

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Submit a pull request

## 📄 License

MIT License - feel free to modify and distribute!

## 🎉 Happy Questing!

Ready to become a Kiro master? Run `./kiro-quest.sh` and start your adventure today!

---

*May your code be bug-free and your AI assistance be ever helpful! 🚀*