# Kiro Quest Enhanced - User Guide

## Overview

Welcome to Kiro Quest Enhanced v2.0! This interactive learning experience helps you master Kiro IDE through gamified quests, achievements, and personalized guidance. The enhanced version includes backward compatibility with the original quest system while adding powerful new features.

## What's New in v2.0

### 🎯 Enhanced Features
- **Smart Progress Tracking**: Detailed analytics and completion metrics
- **Streak System**: Daily engagement tracking with fire emoji chains
- **Achievement System**: Comprehensive badges and milestones
- **Interactive Guidance**: Context-aware help and suggestions
- **Accessibility Options**: Colorblind-friendly and high-contrast modes
- **Data Migration**: Seamless upgrade from v1.0 with data preservation

### 🔄 Backward Compatibility
- All existing progress is automatically preserved
- Original quest structure remains unchanged
- Legacy mode available for users who prefer the classic experience
- Feature flags allow selective enhancement activation

## Getting Started

### System Requirements
- **jq**: JSON processor (automatically installed on most systems)
- **Kiro IDE**: For full integration features (optional for standalone mode)
- **Bash**: Version 4.0 or higher
- **Operating System**: macOS, Linux, or Windows with WSL

### Installation

1. **Download the enhanced script**:
   ```bash
   # If upgrading from v1.0, your existing script will be automatically updated
   chmod +x kiro-quest.sh
   ```

2. **Run the quest**:
   ```bash
   ./kiro-quest.sh
   ```

3. **First-time setup**:
   - The system will automatically detect if you're upgrading from v1.0
   - Your existing progress will be migrated to the enhanced format
   - New users will start with a fresh enhanced experience

## Feature Modes

### Enhanced Mode (Default)
Enhanced mode provides the full v2.0 experience with all new features enabled.

**Features included**:
- Detailed progress tracking and analytics
- Streak monitoring and celebrations
- Interactive guidance and hints
- Achievement system with special badges
- Accessibility options
- Export/import functionality

**Enable enhanced mode**:
```bash
export KIRO_QUEST_ENHANCED=true
./kiro-quest.sh
```

### Legacy Mode
Legacy mode provides the classic v1.0 experience for users who prefer simplicity.

**Features included**:
- Original quest structure
- Basic badge system
- Simple progress tracking
- All original functionality

**Enable legacy mode**:
```bash
export KIRO_QUEST_ENHANCED=false
./kiro-quest.sh
```

### Tutorial Mode
Tutorial mode provides step-by-step guidance for complete beginners.

**Enable tutorial mode**:
```bash
export KIRO_QUEST_TUTORIAL=true
./kiro-quest.sh
```

## Quest Structure

### Beginner Quests (1-2)
Perfect for first-time Kiro users:
- **Quest 1**: 🗺️ Explore Kiro Interface
- **Quest 2**: 💬 Master Chat Features

### Intermediate Quests (3-4)
Build on basic knowledge:
- **Quest 3**: 📁 Discover File Context Magic
- **Quest 4**: 🚁 Experience Autopilot Mode

### Advanced Quests (5-6)
For users ready to dive deeper:
- **Quest 5**: 📋 Create Your First Spec
- **Quest 6**: 🎣 Set Up Agent Hooks

### Expert Quests (7-9)
Master advanced Kiro features:
- **Quest 7**: 🔌 Configure MCP Tools
- **Quest 8**: 🎯 Customize with Steering
- **Quest 9**: ⚡ Master Code Assistance

## Enhanced Features Guide

### Progress Tracking

#### Visual Progress Bars
Enhanced mode displays ASCII art progress bars:
```
Progress: [████████████░░░░░░░░] 60%
Streak: 🔥🔥🔥🔥🔥 5 days
```

#### Detailed Analytics
View comprehensive statistics:
- Quest completion times
- Feature usage patterns
- Help request frequency
- Learning style analysis

### Achievement System

#### Badge Types
- **Quest Badges**: Earned by completing individual quests
- **Milestone Badges**: Earned at specific progress points
- **Special Badges**: Earned through unique accomplishments
- **Streak Badges**: Earned through consistent daily engagement

#### Achievement Examples
- ⚡ **Speed Demon**: Complete 3 quests in under 30 minutes
- 🔥 **Streak Master**: Complete quests for 7 consecutive days
- 🗺️ **Feature Explorer**: Use all major Kiro features in one session
- 🎓 **Tutorial Graduate**: Complete the interactive tutorial mode

### Streak System

#### How Streaks Work
- Complete at least one quest per day to maintain your streak
- Streaks reset if you skip a day
- Visual indicators show current and longest streaks
- Special celebrations for milestone streaks (7, 30, 100 days)

#### Streak Benefits
- Motivational fire emoji chains
- Special streak-based achievements
- Progress momentum tracking
- Engagement analytics

### Interactive Guidance

#### Context-Aware Help
The enhanced system provides intelligent assistance:
- Detects when you might be struggling
- Offers progressive hints and suggestions
- Provides Kiro-specific command recommendations
- Includes troubleshooting guidance

#### Smart Recommendations
Based on your progress and preferences:
- Suggests optimal next quests
- Recommends learning paths
- Adapts difficulty to your skill level
- Filters quests by feature interests

## Configuration Options

### Environment Variables

Set these before running the script to customize your experience:

```bash
# Enable/disable enhanced mode (default: true)
export KIRO_QUEST_ENHANCED=true

# Enable/disable tutorial mode (default: false)
export KIRO_QUEST_TUTORIAL=false

# Enable/disable Kiro integration (default: true)
export KIRO_QUEST_INTEGRATION=true

# Enable/disable accessibility mode (default: false)
export KIRO_QUEST_ACCESSIBILITY=false
```

### In-App Configuration

Access the configuration menu from the main quest menu (Enhanced mode only):
- Toggle tutorial mode on/off
- Enable accessibility features
- Reset enhanced data while preserving legacy progress
- Export/import progress data

### Accessibility Features

#### Colorblind-Friendly Mode
- High contrast color schemes
- Alternative visual indicators
- Reduced reliance on color-only information

#### Keyboard Navigation
- Efficient menu navigation
- Keyboard shortcuts for common actions
- Screen reader friendly output

#### Reduced Animations
- Minimal visual effects
- Static progress indicators
- Simplified celebrations

## Data Management

### File Locations

All quest data is stored in `~/.kiro/`:

```
~/.kiro/
├── quest-progress.json              # Legacy progress (v1.0 compatible)
├── quest-progress-enhanced.json     # Enhanced progress (v2.0)
├── quest-streak.json               # Streak tracking data
├── quest-achievements.json         # Achievement definitions and progress
├── quest-config.json              # User configuration
├── accessibility-config.json      # Accessibility preferences
├── quest-badges/                  # Badge files
│   ├── explorer.badge
│   ├── chat_master.badge
│   └── ...
└── quest-samples/                 # Generated practice files
    ├── sample-project/
    └── ...
```

### Data Migration

#### Automatic Migration
When upgrading from v1.0 to v2.0:
1. Original progress is automatically detected
2. Data is migrated to enhanced format
3. Original files are backed up
4. Migration validation ensures data integrity

#### Manual Migration
If automatic migration fails:
```bash
# Reset enhanced data and re-migrate
rm ~/.kiro/quest-progress-enhanced.json
./kiro-quest.sh
```

### Backup and Restore

#### Export Progress
From the configuration menu, select "Export Progress Data" to create a backup:
```bash
# Creates: ~/kiro-quest-backup-YYYYMMDD_HHMMSS.json
```

#### Import Progress
From the configuration menu, select "Import Progress Data" and provide the backup file path.

#### Manual Backup
```bash
# Backup all quest data
cp -r ~/.kiro ~/.kiro-backup-$(date +%Y%m%d)
```

## Troubleshooting

### Common Issues

#### jq Not Found
```bash
# macOS
brew install jq

# Ubuntu/Debian
sudo apt install jq

# CentOS/RHEL
sudo yum install jq
```

#### Migration Issues
```bash
# Check data integrity
ls -la ~/.kiro/

# Reset and start fresh (preserves backups)
rm ~/.kiro/quest-progress-enhanced.json
./kiro-quest.sh
```

#### Kiro Integration Not Working
1. Ensure Kiro IDE is running
2. Check that you're running the script from within Kiro's terminal
3. Verify Kiro workspace is properly configured
4. Try running in standalone mode: `export KIRO_QUEST_INTEGRATION=false`

#### Performance Issues
```bash
# Enable performance mode
export KIRO_QUEST_ENHANCED=false

# Clear temporary files
rm -rf ~/.kiro/temp/
```

### Data Recovery

#### Restore from Backup
```bash
# Find available backups
ls ~/.kiro/backups/

# Restore from specific backup
cp ~/.kiro/backups/BACKUP_DATE/* ~/.kiro/
```

#### Reset to Factory Defaults
```bash
# Complete reset (creates backup first)
mv ~/.kiro ~/.kiro-backup-$(date +%Y%m%d)
./kiro-quest.sh
```

## Advanced Usage

### Custom Configuration

#### Feature Flags
Create `~/.kiro/quest-config.json` to customize behavior:
```json
{
  "version": "2.0",
  "preferences": {
    "enhanced_mode": true,
    "tutorial_mode": false,
    "accessibility": {
      "colorblind_friendly": false,
      "high_contrast": false,
      "reduced_animations": false
    }
  },
  "feature_flags": {
    "interactive_tutorial": true,
    "smart_recommendations": true,
    "kiro_integration": true,
    "advanced_analytics": true
  }
}
```

#### Custom Achievements
Advanced users can modify `~/.kiro/quest-achievements.json` to add custom achievements.

### Integration with Development Workflow

#### Git Hooks
Add quest completion to your git workflow:
```bash
# .git/hooks/post-commit
#!/bin/bash
if [ -f "./kiro-quest.sh" ]; then
    echo "🎮 Don't forget to continue your Kiro Quest!"
fi
```

#### CI/CD Integration
Include quest progress in your development metrics:
```bash
# Check quest completion status
jq '.progress.completed_quests | length' ~/.kiro/quest-progress-enhanced.json
```

## Support and Feedback

### Getting Help
1. **In-app help**: Use the help system within quests
2. **Documentation**: Refer to this guide and the migration guide
3. **Kiro community**: Ask questions in Kiro IDE support channels
4. **GitHub issues**: Report bugs or request features

### Contributing
The Kiro Quest system is designed to be extensible:
- Add new quests by following the existing pattern
- Contribute achievement definitions
- Improve accessibility features
- Enhance Kiro IDE integration

### Version History
- **v1.0**: Original quest system with basic gamification
- **v2.0**: Enhanced system with analytics, streaks, and accessibility
- **v2.1**: (Planned) Advanced tutorial system and AI-powered hints

---

*Happy questing! May your code be bug-free and your Kiro skills legendary! 🚀*