# Kiro Quest Migration Guide

## Overview

This guide helps you upgrade from Kiro Quest v1.0 to the enhanced v2.0 system while preserving all your existing progress, badges, and achievements.

## Migration Process

### Automatic Migration

The enhanced Kiro Quest system automatically detects and migrates your existing data:

1. **Detection**: System checks for existing v1.0 progress files
2. **Backup**: Creates automatic backups of all original data
3. **Migration**: Converts data to enhanced v2.0 format
4. **Validation**: Ensures all data was migrated correctly
5. **Compatibility**: Maintains both legacy and enhanced formats

### What Gets Migrated

#### ✅ Preserved Data
- **Quest Progress**: All completed quests and their completion status
- **Badge Collection**: All earned badges with their descriptions
- **Score and Level**: Total points and current level
- **Timestamps**: Badge earning dates (estimated if not available)

#### 🆕 Enhanced Data
- **Detailed Analytics**: Quest completion times, hints used, retry counts
- **Streak Tracking**: Daily engagement patterns and streak milestones
- **Achievement System**: Comprehensive achievement definitions and progress
- **User Preferences**: Learning style, accessibility settings, feature usage

#### 📁 File Structure Changes

**Before (v1.0)**:
```
~/.kiro/
├── quest-progress.json
└── quest-badges/
    ├── explorer.badge
    ├── chat_master.badge
    └── ...
```

**After (v2.0)**:
```
~/.kiro/
├── quest-progress.json              # ✅ Preserved for compatibility
├── quest-progress-enhanced.json     # 🆕 Enhanced progress tracking
├── quest-streak.json               # 🆕 Streak tracking
├── quest-achievements.json         # 🆕 Achievement system
├── quest-config.json              # 🆕 User configuration
├── quest-badges/                  # ✅ Preserved badge files
│   ├── explorer.badge
│   ├── chat_master.badge
│   └── ...
├── quest-samples/                 # 🆕 Practice files
└── backups/                       # 🆕 Automatic backups
    └── YYYYMMDD_HHMMSS/
        ├── quest-progress.json.backup
        └── quest-badges.backup/
```

## Step-by-Step Migration

### Pre-Migration Checklist

Before upgrading, ensure you have:

1. **Backup your data** (optional but recommended):
   ```bash
   cp -r ~/.kiro ~/.kiro-backup-$(date +%Y%m%d)
   ```

2. **Check current progress**:
   ```bash
   cat ~/.kiro/quest-progress.json
   ls ~/.kiro/quest-badges/
   ```

3. **Verify jq installation**:
   ```bash
   jq --version
   # If not installed: brew install jq (macOS) or sudo apt install jq (Ubuntu)
   ```

### Running the Migration

1. **Download the enhanced script**:
   ```bash
   # Replace your existing kiro-quest.sh with the enhanced version
   chmod +x kiro-quest.sh
   ```

2. **Start the migration**:
   ```bash
   ./kiro-quest.sh
   ```

3. **Migration output example**:
   ```
   🚀 Initializing Kiro Quest System...
   🔄 Migrating legacy progress data to enhanced format...
   💾 Creating comprehensive backup...
   🏆 Migrating badge files to enhanced format...
   ⚙️ Migrating user preferences...
   🔢 Updating data file versions...
   ✅ Comprehensive migration completed successfully!
   📁 Backup created at: ~/.kiro/backups/20241215_143022
   🔍 Validating migration success...
   ✅ Migration validation successful - all data consistent
   🎉 Enhanced Kiro Quest System ready!
   ```

### Post-Migration Verification

After migration, verify your data:

1. **Check quest progress**:
   ```bash
   # Your completed quests should be preserved
   jq '.progress.completed_quests' ~/.kiro/quest-progress-enhanced.json
   ```

2. **Verify badge collection**:
   ```bash
   # All badges should still be available
   ls ~/.kiro/quest-badges/
   ```

3. **Test the enhanced features**:
   ```bash
   ./kiro-quest.sh
   # Navigate to "View Badge Collection" to see enhanced badge details
   # Check "View Statistics" for new analytics
   ```

## Migration Scenarios

### Scenario 1: Fresh Installation (No Existing Data)

**What happens**:
- System creates new enhanced data structures
- No migration needed
- Full v2.0 experience from the start

**Expected output**:
```
🚀 Initializing Kiro Quest System...
ℹ️ No legacy progress file found. Starting fresh.
🌟 Welcome to Enhanced Kiro Quest!
📊 Setting up your personalized learning experience...
✅ Enhanced data structures initialized successfully!
🎉 Enhanced Kiro Quest System ready!
```

### Scenario 2: Existing v1.0 Data

**What happens**:
- Automatic detection of legacy progress
- Complete data migration with backups
- Both legacy and enhanced formats maintained

**Expected files after migration**:
- Original files preserved and backed up
- New enhanced files created with migrated data
- Validation confirms data consistency

### Scenario 3: Partial v1.0 Data

**What happens**:
- Migration handles missing or incomplete data gracefully
- Creates default values for missing information
- Preserves whatever data is available

**Example with only badges, no progress file**:
```
🔄 Migrating legacy progress data to enhanced format...
ℹ️ No legacy progress file found. Starting fresh.
🏆 Migrating badge files to enhanced format...
  ✅ Migrated badge: explorer (earned: 2024-12-15T14:30:22Z)
  ✅ Migrated badge: chat_master (earned: 2024-12-15T14:35:18Z)
📊 Migrated 2 badges to enhanced format
```

### Scenario 4: Corrupted v1.0 Data

**What happens**:
- System detects corrupted data
- Attempts recovery from available information
- Creates fresh data structures if recovery fails
- Preserves original files for manual recovery

**Recovery process**:
```
⚠️ Enhanced progress data corrupted. Attempting repair...
🔧 Creating fresh enhanced progress file...
✅ Data integrity check completed!
```

## Troubleshooting Migration Issues

### Common Migration Problems

#### Problem: Migration Fails with JSON Error
```
Error: Invalid JSON in progress file
```

**Solution**:
```bash
# Check the JSON syntax
jq empty ~/.kiro/quest-progress.json

# If invalid, restore from backup or reset
rm ~/.kiro/quest-progress.json
echo '{"completed_quests": [], "total_score": 0, "level": 1}' > ~/.kiro/quest-progress.json
./kiro-quest.sh
```

#### Problem: Missing Badge Files
```
⚠️ Badge count mismatch: files=0, enhanced=3
```

**Solution**:
```bash
# Check badge directory
ls -la ~/.kiro/quest-badges/

# If empty, badges will be recreated based on progress data
# Or restore from backup:
cp -r ~/.kiro-backup-*/quest-badges ~/.kiro/
```

#### Problem: Permission Errors
```
Permission denied: ~/.kiro/quest-progress-enhanced.json
```

**Solution**:
```bash
# Fix permissions
chmod 755 ~/.kiro
chmod 644 ~/.kiro/*.json
```

#### Problem: Disk Space Issues
```
No space left on device
```

**Solution**:
```bash
# Clean up old backups
rm -rf ~/.kiro/backups/old_backup_*

# Or move to external storage
mv ~/.kiro/backups ~/Desktop/kiro-quest-backups
```

### Manual Migration Recovery

If automatic migration fails, you can manually recover your data:

#### Step 1: Identify Your Data
```bash
# Check what data you have
ls -la ~/.kiro/
cat ~/.kiro/quest-progress.json 2>/dev/null || echo "No progress file"
ls ~/.kiro/quest-badges/ 2>/dev/null || echo "No badges"
```

#### Step 2: Manual Progress Recreation
```bash
# Create a basic enhanced progress file
cat > ~/.kiro/quest-progress-enhanced.json << 'EOF'
{
  "version": "2.0",
  "user_id": "manual_migration",
  "profile": {
    "created_date": "2024-12-15T00:00:00Z",
    "last_active": "2024-12-15T00:00:00Z",
    "total_sessions": 1,
    "preferred_learning_style": "guided"
  },
  "progress": {
    "level": 1,
    "total_score": 0,
    "completed_quests": [],
    "current_streak": 0,
    "longest_streak": 0,
    "total_time_spent": 0,
    "quests_detail": {}
  },
  "achievements": {
    "badges": [],
    "milestones": [],
    "special_achievements": []
  },
  "analytics": {
    "feature_usage": {
      "chat_context": 0,
      "file_references": 0,
      "mcp_usage": 0
    },
    "help_requests": 0,
    "tutorial_completed": false
  }
}
EOF
```

#### Step 3: Add Your Completed Quests
```bash
# For each badge file, add to completed quests
for badge in ~/.kiro/quest-badges/*.badge; do
    if [[ -f "$badge" ]]; then
        quest_name=$(basename "$badge" .badge)
        echo "Adding quest: $quest_name"
        jq --arg quest "$quest_name" '.progress.completed_quests += [$quest] | .achievements.badges += [$quest]' \
           ~/.kiro/quest-progress-enhanced.json > /tmp/progress.json
        mv /tmp/progress.json ~/.kiro/quest-progress-enhanced.json
    fi
done
```

#### Step 4: Calculate Score and Level
```bash
# Calculate total score (50 points per quest)
quest_count=$(jq '.progress.completed_quests | length' ~/.kiro/quest-progress-enhanced.json)
total_score=$((quest_count * 50))
level=$(((total_score / 100) + 1))

jq --argjson score "$total_score" --argjson level "$level" \
   '.progress.total_score = $score | .progress.level = $level' \
   ~/.kiro/quest-progress-enhanced.json > /tmp/progress.json
mv /tmp/progress.json ~/.kiro/quest-progress-enhanced.json
```

### Migration Rollback

If you need to revert to v1.0:

#### Option 1: Use Backup
```bash
# Find your backup
ls ~/.kiro/backups/

# Restore from backup
backup_dir="~/.kiro/backups/YYYYMMDD_HHMMSS"  # Replace with actual backup
cp "$backup_dir/quest-progress.json.backup" ~/.kiro/quest-progress.json
cp -r "$backup_dir/quest-badges.backup" ~/.kiro/quest-badges

# Remove enhanced files
rm ~/.kiro/quest-progress-enhanced.json
rm ~/.kiro/quest-streak.json
rm ~/.kiro/quest-achievements.json
rm ~/.kiro/quest-config.json
```

#### Option 2: Use Legacy Mode
```bash
# Run in legacy mode without removing enhanced files
export KIRO_QUEST_ENHANCED=false
./kiro-quest.sh
```

## Validation and Testing

### Validate Migration Success

After migration, run these checks:

```bash
# 1. Check file existence
test -f ~/.kiro/quest-progress-enhanced.json && echo "✅ Enhanced progress exists"
test -f ~/.kiro/quest-streak.json && echo "✅ Streak data exists"
test -f ~/.kiro/quest-achievements.json && echo "✅ Achievements exist"

# 2. Validate JSON syntax
jq empty ~/.kiro/quest-progress-enhanced.json && echo "✅ Enhanced progress valid JSON"
jq empty ~/.kiro/quest-streak.json && echo "✅ Streak data valid JSON"
jq empty ~/.kiro/quest-achievements.json && echo "✅ Achievements valid JSON"

# 3. Check data consistency
legacy_count=$(jq '.completed_quests | length' ~/.kiro/quest-progress.json 2>/dev/null || echo "0")
enhanced_count=$(jq '.progress.completed_quests | length' ~/.kiro/quest-progress-enhanced.json 2>/dev/null || echo "0")
badge_count=$(ls ~/.kiro/quest-badges/*.badge 2>/dev/null | wc -l | tr -d ' ')

echo "Legacy quests: $legacy_count"
echo "Enhanced quests: $enhanced_count"
echo "Badge files: $badge_count"

if [[ "$legacy_count" == "$enhanced_count" && "$enhanced_count" == "$badge_count" ]]; then
    echo "✅ Data consistency check passed"
else
    echo "⚠️ Data consistency check failed - manual review needed"
fi
```

### Test Enhanced Features

```bash
# Test the enhanced script
./kiro-quest.sh

# In the quest menu:
# 1. Check "View Badge Collection" - should show enhanced badge details
# 2. Check "View Statistics" - should show analytics
# 3. Try "Configuration" menu - should have enhanced options
# 4. Complete a quest - should show enhanced celebration
```

## Best Practices

### Before Migration
1. **Backup your data** - Always create a backup before major changes
2. **Document your progress** - Note which quests you've completed
3. **Test in a safe environment** - Try migration on a copy first if possible

### During Migration
1. **Don't interrupt the process** - Let migration complete fully
2. **Monitor for errors** - Watch for any error messages
3. **Verify each step** - Check that files are being created correctly

### After Migration
1. **Validate your data** - Run the validation checks above
2. **Test functionality** - Try completing a quest to ensure everything works
3. **Explore new features** - Take advantage of enhanced analytics and streaks
4. **Keep backups** - Maintain periodic backups of your enhanced data

## Support

If you encounter issues during migration:

1. **Check this guide** - Most common issues are covered here
2. **Review error messages** - The system provides detailed error information
3. **Use backup data** - You can always restore from backups
4. **Start fresh if needed** - The quest system works perfectly with fresh data
5. **Report bugs** - Help improve the migration process for others

Remember: Your quest progress is valuable, but the learning experience is what matters most. Even if migration doesn't work perfectly, you can always restart your Kiro journey with the enhanced system!

---

*Happy migrating! Your enhanced Kiro Quest adventure awaits! 🚀*