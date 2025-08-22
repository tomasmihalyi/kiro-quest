# Kiro Quest Troubleshooting Guide

## Common Issues and Solutions

### Installation and Setup Issues

#### Issue: "jq: command not found"
**Symptoms**: Script fails to start with error about missing jq
**Solution**:
```bash
# macOS
brew install jq

# Ubuntu/Debian
sudo apt update && sudo apt install jq

# CentOS/RHEL/Fedora
sudo yum install jq
# or
sudo dnf install jq

# Windows (WSL)
sudo apt update && sudo apt install jq

# Verify installation
jq --version
```

#### Issue: Permission denied when running script
**Symptoms**: `bash: ./kiro-quest.sh: Permission denied`
**Solution**:
```bash
# Make script executable
chmod +x kiro-quest.sh

# Verify permissions
ls -la kiro-quest.sh
# Should show: -rwxr-xr-x
```

#### Issue: Script won't run on older bash versions
**Symptoms**: Syntax errors or unexpected behavior
**Solution**:
```bash
# Check bash version
bash --version

# If version < 4.0, update bash or use newer system
# macOS: brew install bash
# Linux: Usually comes with bash 4.0+
```

### Data and Migration Issues

#### Issue: Migration fails with "Invalid JSON"
**Symptoms**: 
```
Error: Invalid JSON in progress file
Migration validation failed
```
**Solution**:
```bash
# Check JSON syntax
jq empty ~/.kiro/quest-progress.json

# If invalid, fix or recreate
cp ~/.kiro/quest-progress.json ~/.kiro/quest-progress.json.broken
echo '{"completed_quests": [], "total_score": 0, "level": 1}' > ~/.kiro/quest-progress.json

# Re-run migration
./kiro-quest.sh
```

#### Issue: "No space left on device"
**Symptoms**: Migration or script execution fails due to disk space
**Solution**:
```bash
# Check disk space
df -h ~/.kiro

# Clean up old backups
rm -rf ~/.kiro/backups/old_*

# Move backups to external storage
mv ~/.kiro/backups ~/Desktop/kiro-quest-backups

# Clean temporary files
rm -rf ~/.kiro/temp/*
rm -rf /tmp/kiro-*
```

#### Issue: Badge files missing after migration
**Symptoms**: "Badge count mismatch" warning
**Solution**:
```bash
# Check badge directory
ls -la ~/.kiro/quest-badges/

# If empty, restore from backup
ls ~/.kiro/backups/
cp -r ~/.kiro/backups/LATEST_BACKUP/quest-badges.backup ~/.kiro/quest-badges

# Or recreate badges based on progress
./kiro-quest.sh
# Complete any quest to regenerate badge files
```

#### Issue: Corrupted enhanced progress data
**Symptoms**: 
```
⚠️ Enhanced progress data corrupted. Attempting repair...
❌ Enhanced progress data validation failed
```
**Solution**:
```bash
# Try automatic repair first
./kiro-quest.sh

# If repair fails, restore from backup
ls ~/.kiro/backups/
cp ~/.kiro/backups/LATEST_BACKUP/quest-progress-enhanced.json.backup ~/.kiro/quest-progress-enhanced.json

# If no backup available, reset enhanced data
rm ~/.kiro/quest-progress-enhanced.json
./kiro-quest.sh
```

### Kiro IDE Integration Issues

#### Issue: Kiro IDE not detected
**Symptoms**: "Kiro IDE not detected - running in standalone mode"
**Solution**:
```bash
# Verify Kiro IDE is running
ps aux | grep -i kiro

# Check environment variables
echo $KIRO_SESSION_ID
echo $KIRO_WORKSPACE
echo $KIRO_IDE_VERSION

# Run from within Kiro IDE terminal
# Or disable integration:
export KIRO_QUEST_INTEGRATION=false
./kiro-quest.sh
```

#### Issue: Kiro features not working in quest
**Symptoms**: File context, MCP, or other Kiro features don't work as expected
**Solution**:
1. **Verify Kiro IDE setup**:
   ```bash
   # Check if running in Kiro terminal
   echo $TERM_PROGRAM
   
   # Verify workspace
   ls .kiro/
   ```

2. **Test Kiro features manually**:
   - Open Kiro chat
   - Try `#File` or `#Folder` commands
   - Check MCP server status in feature panel

3. **Use standalone mode if needed**:
   ```bash
   export KIRO_QUEST_INTEGRATION=false
   ./kiro-quest.sh
   ```

### Performance Issues

#### Issue: Script runs slowly
**Symptoms**: Long delays between menu selections or quest completions
**Solution**:
```bash
# Use legacy mode for better performance
export KIRO_QUEST_ENHANCED=false
./kiro-quest.sh

# Clear cache and temporary files
rm -rf ~/.kiro/temp/*
rm -rf ~/.kiro/cache/*

# Optimize JSON files (remove formatting)
jq -c . ~/.kiro/quest-progress-enhanced.json > /tmp/progress.json
mv /tmp/progress.json ~/.kiro/quest-progress-enhanced.json
```

#### Issue: High memory usage
**Symptoms**: System becomes slow or unresponsive during quest execution
**Solution**:
```bash
# Monitor memory usage
ps aux | grep kiro-quest

# Use minimal mode
export KIRO_QUEST_ENHANCED=false
export KIRO_QUEST_ACCESSIBILITY=false
./kiro-quest.sh

# Close other applications
# Restart terminal session
```

### Display and Interface Issues

#### Issue: Colors not displaying correctly
**Symptoms**: Strange characters instead of colors, or no colors at all
**Solution**:
```bash
# Check terminal color support
echo $TERM
tput colors

# Enable accessibility mode
export KIRO_QUEST_ACCESSIBILITY=true
./kiro-quest.sh

# Or disable colors entirely
export NO_COLOR=1
./kiro-quest.sh
```

#### Issue: ASCII art not displaying properly
**Symptoms**: Broken progress bars or malformed visual elements
**Solution**:
```bash
# Check terminal encoding
locale

# Use simple text mode
export KIRO_QUEST_ACCESSIBILITY=true
./kiro-quest.sh

# Or use legacy mode
export KIRO_QUEST_ENHANCED=false
./kiro-quest.sh
```

#### Issue: Menu options not working
**Symptoms**: Selecting menu items doesn't work or causes errors
**Solution**:
```bash
# Check for input issues
# Try typing numbers clearly and pressing Enter

# Restart script
./kiro-quest.sh

# Check for keyboard layout issues
# Try using different terminal
```

### Configuration Issues

#### Issue: Settings not persisting
**Symptoms**: Configuration changes don't save between sessions
**Solution**:
```bash
# Check config file permissions
ls -la ~/.kiro/quest-config.json

# Fix permissions
chmod 644 ~/.kiro/quest-config.json

# Verify config file syntax
jq empty ~/.kiro/quest-config.json

# Recreate config if corrupted
rm ~/.kiro/quest-config.json
./kiro-quest.sh
```

#### Issue: Environment variables not working
**Symptoms**: Export commands don't affect script behavior
**Solution**:
```bash
# Verify variables are set
env | grep KIRO_QUEST

# Set variables in same session
export KIRO_QUEST_ENHANCED=true
./kiro-quest.sh

# Or set permanently in shell profile
echo 'export KIRO_QUEST_ENHANCED=true' >> ~/.bashrc
source ~/.bashrc
```

### Advanced Troubleshooting

#### Debug Mode
Enable debug output to diagnose issues:
```bash
# Enable bash debug mode
bash -x ./kiro-quest.sh

# Or add debug to script
export KIRO_QUEST_DEBUG=true
./kiro-quest.sh
```

#### Log Analysis
Check system logs for errors:
```bash
# Check system logs (macOS)
log show --predicate 'process == "bash"' --last 1h

# Check system logs (Linux)
journalctl -u bash --since "1 hour ago"

# Check for core dumps
ls /cores/ 2>/dev/null || ls /var/crash/ 2>/dev/null
```

#### Network Issues (MCP Integration)
If MCP features aren't working:
```bash
# Check network connectivity
ping 8.8.8.8

# Check for proxy issues
echo $HTTP_PROXY
echo $HTTPS_PROXY

# Test MCP server manually
uvx --help
```

## Recovery Procedures

### Complete Reset
If all else fails, perform a complete reset:

```bash
# 1. Backup current data
cp -r ~/.kiro ~/.kiro-emergency-backup-$(date +%Y%m%d_%H%M%S)

# 2. Remove all quest data
rm -rf ~/.kiro/quest-*
rm -rf ~/.kiro/backups

# 3. Start fresh
./kiro-quest.sh

# 4. Manually restore important data if needed
# (badges, completed quests, etc.)
```

### Selective Reset
Reset only problematic components:

```bash
# Reset enhanced data only (keep legacy)
rm ~/.kiro/quest-progress-enhanced.json
rm ~/.kiro/quest-streak.json
rm ~/.kiro/quest-achievements.json

# Reset configuration only
rm ~/.kiro/quest-config.json
rm ~/.kiro/accessibility-config.json

# Reset badges only
rm -rf ~/.kiro/quest-badges/*
```

### Data Recovery
Recover from backups:

```bash
# List available backups
ls -la ~/.kiro/backups/

# Restore from specific backup
backup_date="20241215_143022"  # Replace with actual date
cp ~/.kiro/backups/$backup_date/* ~/.kiro/

# Verify restoration
./kiro-quest.sh
```

## Prevention Tips

### Regular Maintenance
```bash
# Weekly cleanup
rm -rf ~/.kiro/temp/*
find ~/.kiro/backups -mtime +30 -delete

# Monthly backup
cp -r ~/.kiro ~/Desktop/kiro-quest-backup-$(date +%Y%m)
```

### Monitoring
```bash
# Check data integrity
jq empty ~/.kiro/quest-*.json

# Monitor disk usage
du -sh ~/.kiro

# Check for permission issues
ls -la ~/.kiro/
```

### Best Practices
1. **Regular backups**: Create backups before major changes
2. **Keep it simple**: Use legacy mode if enhanced features cause issues
3. **Update dependencies**: Keep jq and bash updated
4. **Monitor resources**: Watch disk space and memory usage
5. **Test changes**: Try configuration changes in a safe environment

## Getting Help

### Self-Diagnosis Checklist
Before seeking help, try these steps:

1. ✅ **Check system requirements**: jq installed, bash 4.0+, sufficient disk space
2. ✅ **Verify file permissions**: Script executable, data files writable
3. ✅ **Test basic functionality**: Can you run `./kiro-quest.sh` at all?
4. ✅ **Check error messages**: Look for specific error text
5. ✅ **Try legacy mode**: Does `KIRO_QUEST_ENHANCED=false ./kiro-quest.sh` work?
6. ✅ **Review logs**: Any system-level errors or warnings?

### Information to Provide
When reporting issues, include:

- **Operating system**: macOS, Linux distribution, Windows version
- **Bash version**: Output of `bash --version`
- **jq version**: Output of `jq --version`
- **Error messages**: Exact text of any errors
- **Steps to reproduce**: What you did before the issue occurred
- **Configuration**: Any environment variables or custom settings
- **Data state**: Are you migrating from v1.0 or starting fresh?

### Support Channels
1. **Documentation**: Check user guide and migration guide first
2. **Kiro community**: Ask in Kiro IDE support channels
3. **GitHub issues**: Report bugs with detailed information
4. **Local debugging**: Use debug mode and log analysis

Remember: Most issues have simple solutions, and the quest system is designed to be resilient. When in doubt, try the simplest solution first!

---

*May your troubleshooting be swift and your quests bug-free! 🐛🔧*