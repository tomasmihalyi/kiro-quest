#!/bin/bash

# Kiro Onboarding Quest - Enhanced Version
# Version 2.0 - Enhanced Interactive Learning Experience with Legacy Compatibility

set -e

# =============================================================================
# FEATURE FLAGS AND CONFIGURATION
# =============================================================================

# Feature flags to enable/disable enhanced features
ENHANCED_MODE="${KIRO_QUEST_ENHANCED:-true}"
TUTORIAL_MODE="${KIRO_QUEST_TUTORIAL:-false}"
ACCESSIBILITY_MODE="${KIRO_QUEST_ACCESSIBILITY:-false}"

# Version information
QUEST_VERSION="2.0"

# Colors and styling
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'
BOLD='\033[1m'
NC='\033[0m' # No Color

# =============================================================================
# FILE PATHS AND DIRECTORIES
# =============================================================================

# Core directories
KIRO_DIR="$HOME/.kiro"
BADGES_DIR="$KIRO_DIR/quest-badges"

# Legacy files (maintained for backward compatibility)
PROGRESS_FILE="$KIRO_DIR/quest-progress.json"

# Enhanced files (only used when ENHANCED_MODE=true)
ENHANCED_PROGRESS_FILE="$KIRO_DIR/quest-progress-enhanced.json"
STREAK_FILE="$KIRO_DIR/quest-streak.json"

# Ensure directories exist
mkdir -p "$BADGES_DIR"

# Initialize progress if it doesn't exist
if [[ ! -f "$PROGRESS_FILE" ]]; then
    echo '{"completed_quests": [], "total_score": 0, "level": 1}' > "$PROGRESS_FILE"
fi

# =============================================================================
# ENHANCED FEATURES (Only loaded when ENHANCED_MODE=true)
# =============================================================================

# Create enhanced progress schema
create_enhanced_progress_schema() {
    if [[ "$ENHANCED_MODE" != "true" ]]; then
        return 0
    fi
    
    local user_id=$(uuidgen 2>/dev/null || echo "user_$(date +%s)")
    local current_date=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
    
    cat > "$ENHANCED_PROGRESS_FILE" << 'EOF'
{
  "version": "2.0",
  "user_id": "USER_ID_PLACEHOLDER",
  "profile": {
    "created_date": "DATE_PLACEHOLDER",
    "last_active": "DATE_PLACEHOLDER",
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
    
    # Replace placeholders with actual values
    sed -i.bak "s/USER_ID_PLACEHOLDER/$user_id/g" "$ENHANCED_PROGRESS_FILE"
    sed -i.bak "s/DATE_PLACEHOLDER/$current_date/g" "$ENHANCED_PROGRESS_FILE"
    rm -f "${ENHANCED_PROGRESS_FILE}.bak"
}

# Initialize enhanced features if enabled
initialize_enhanced_features() {
    if [[ "$ENHANCED_MODE" == "true" ]]; then
        if [[ ! -f "$ENHANCED_PROGRESS_FILE" ]]; then
            create_enhanced_progress_schema
        fi
        if [[ ! -f "$STREAK_FILE" ]]; then
            echo '{"last_day": "'$(date +%Y-%m-%d)'", "streak": 1, "longest_streak": 1}' > "$STREAK_FILE"
        fi
    fi
}

# Badge descriptions function
get_badge_description() {
    case "$1" in
        "explorer") echo "🗺️  Explorer - Discovered Kiro's interface" ;;
        "chat_master") echo "💬 Chat Master - Had your first conversation with Kiro" ;;
        "file_wizard") echo "📁 File Wizard - Used file context features" ;;
        "autopilot_ace") echo "🚁 Autopilot Ace - Experienced autonomous mode" ;;
        "spec_architect") echo "📋 Spec Architect - Created your first spec" ;;
        "hook_hero") echo "🎣 Hook Hero - Set up an agent hook" ;;
        "mcp_pioneer") echo "🔌 MCP Pioneer - Configured Model Context Protocol" ;;
        "steering_captain") echo "🎯 Steering Captain - Customized Kiro with steering files" ;;
        "code_commander") echo "⚡ Code Commander - Mastered code assistance features" ;;
        "quest_champion") echo "🏆 Quest Champion - Completed the full onboarding quest" ;;
        *) echo "Unknown badge" ;;
    esac
}

# Functions
print_header() {
    clear
    echo -e "${PURPLE}${BOLD}"
    echo "╔══════════════════════════════════════════════════════════════╗"
    echo "║                    🚀 KIRO ONBOARDING QUEST 🚀               ║"
    echo "║                                                              ║"
    echo "║           Welcome to your AI-powered development             ║"
    echo "║                      adventure!                              ║"
    echo "╚══════════════════════════════════════════════════════════════╝"
    echo -e "${NC}"
    echo
}

print_progress() {
    local completed=$(jq -r '.completed_quests | length' "$PROGRESS_FILE")
    local total=9
    local level=$(jq -r '.level' "$PROGRESS_FILE")
    local score=$(jq -r '.total_score' "$PROGRESS_FILE")
    
    echo -e "${CYAN}${BOLD}Quest Progress:${NC} ${completed}/${total} quests completed"
    echo -e "${YELLOW}${BOLD}Level:${NC} ${level} | ${GREEN}${BOLD}Score:${NC} ${score} points"
    
    # Enhanced progress display
    if [[ "$ENHANCED_MODE" == "true" ]]; then
        show_enhanced_progress_display "$completed" "$total"
    fi
    
    echo
}

# Enhanced progress display (only in enhanced mode)
show_enhanced_progress_display() {
    local completed="$1"
    local total="$2"
    
    if [[ "$ENHANCED_MODE" != "true" ]]; then
        return 0
    fi
    
    # ASCII progress bar
    local progress_percent=$((completed * 100 / total))
    local filled=$((completed * 20 / total))
    local empty=$((20 - filled))
    
    printf "${BLUE}Progress: ${NC}["
    printf "%*s" $filled | tr ' ' '█'
    printf "%*s" $empty | tr ' ' '░'
    printf "] ${progress_percent}%%\n"
    
    # Show streak if available
    if [[ -f "$STREAK_FILE" ]]; then
        local current_streak=$(jq -r '.streak // 0' "$STREAK_FILE")
        if [[ $current_streak -gt 0 ]]; then
            printf "${CYAN}Streak: ${NC}"
            for ((i=1; i<=current_streak && i<=10; i++)); do
                printf "🔥"
            done
            if [[ $current_streak -gt 10 ]]; then
                printf " (+$((current_streak - 10)))"
            fi
            printf " ${current_streak} days\n"
        fi
    fi
}

award_badge() {
    local badge_key="$1"
    local points="$2"
    
    # Check if badge already earned
    if jq -e ".completed_quests | index(\"$badge_key\")" "$PROGRESS_FILE" > /dev/null; then
        return 0
    fi
    
    # Award the badge
    local badge_desc=$(get_badge_description "$badge_key")
    echo "$badge_desc" > "$BADGES_DIR/$badge_key.badge"
    
    # Update progress
    jq ".completed_quests += [\"$badge_key\"] | .total_score += $points" "$PROGRESS_FILE" > /tmp/progress.json
    mv /tmp/progress.json "$PROGRESS_FILE"
    
    # Level up logic
    local new_score=$(jq -r '.total_score' "$PROGRESS_FILE")
    local new_level=$(( (new_score / 100) + 1 ))
    jq ".level = $new_level" "$PROGRESS_FILE" > /tmp/progress.json
    mv /tmp/progress.json "$PROGRESS_FILE"
    
    # Update enhanced progress if enabled
    if [[ "$ENHANCED_MODE" == "true" && -f "$ENHANCED_PROGRESS_FILE" ]]; then
        local timestamp=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
        jq --arg badge_key "$badge_key" \
           --argjson points "$points" \
           --arg timestamp "$timestamp" \
           '.progress.completed_quests += [$badge_key] |
            .progress.total_score += $points |
            .progress.level = '"$new_level"' |
            .achievements.badges += [$badge_key] |
            .profile.last_active = $timestamp' \
           "$ENHANCED_PROGRESS_FILE" > /tmp/enhanced_progress.json && \
           mv /tmp/enhanced_progress.json "$ENHANCED_PROGRESS_FILE"
    fi
    
    echo
    echo -e "${GREEN}${BOLD}🎉 BADGE EARNED! 🎉${NC}"
    echo -e "${WHITE}$badge_desc${NC}"
    echo -e "${YELLOW}+${points} points!${NC}"
    
    # Enhanced celebration for enhanced mode
    if [[ "$ENHANCED_MODE" == "true" ]]; then
        show_enhanced_celebration "$badge_key" "$points"
    fi
    
    if [[ $new_level -gt $(( ($(jq -r '.total_score' "$PROGRESS_FILE") - points) / 100 + 1 )) ]]; then
        echo -e "${PURPLE}${BOLD}🆙 LEVEL UP! You're now level $new_level!${NC}"
    fi
    echo
    read -p "Press Enter to continue..."
}

# Enhanced celebration (only in enhanced mode)
show_enhanced_celebration() {
    local badge_key="$1"
    local points="$2"
    
    if [[ "$ENHANCED_MODE" != "true" ]]; then
        return 0
    fi
    
    # Show streak information
    if [[ -f "$STREAK_FILE" ]]; then
        local current_streak=$(jq -r '.streak // 0' "$STREAK_FILE")
        if [[ $current_streak -gt 1 ]]; then
            echo -e "${CYAN}🔥 ${current_streak}-day streak! Keep it up!${NC}"
        fi
    fi
    
    # Show progress towards completion
    local total_completed=$(jq -r '.completed_quests | length' "$PROGRESS_FILE")
    case $total_completed in
        3) echo -e "${YELLOW}💫 3 quests completed! You're getting the hang of this!${NC}" ;;
        5) echo -e "${YELLOW}⭐ Halfway there! 5 quests completed!${NC}" ;;
        7) echo -e "${YELLOW}🌟 Almost done! Just 2 more quests to go!${NC}" ;;
        9) echo -e "${PURPLE}🎊 QUEST CHAMPION! All quests completed! 🎊${NC}" ;;
    esac
}

show_badges() {
    echo -e "${BOLD}${PURPLE}🏆 Your Badge Collection 🏆${NC}"
    echo
    
    if [[ -d "$BADGES_DIR" && $(ls -A "$BADGES_DIR" 2>/dev/null | wc -l) -gt 0 ]]; then
        for badge_file in "$BADGES_DIR"/*.badge; do
            if [[ -f "$badge_file" ]]; then
                cat "$badge_file"
                echo
            fi
        done
    else
        echo -e "${YELLOW}No badges earned yet. Complete quests to earn badges!${NC}"
    fi
    echo
}

reset_progress() {
    clear
    echo -e "${BOLD}${RED}🔄 Reset Quest Progress${NC}"
    echo
    echo -e "${YELLOW}This will permanently delete:${NC}"
    echo "• All earned badges"
    echo "• Quest completion progress"
    echo "• Level and score data"
    echo
    echo -e "${RED}${BOLD}⚠️  This action cannot be undone!${NC}"
    echo
    read -p "Are you sure you want to reset all progress? (type 'RESET' to confirm): " confirm
    
    if [[ "$confirm" == "RESET" ]]; then
        # Remove all badges and progress
        rm -rf "$BADGES_DIR"
        rm -f "$PROGRESS_FILE"
        
        # Recreate directories and initialize fresh progress
        mkdir -p "$BADGES_DIR"
        echo '{"completed_quests": [], "total_score": 0, "level": 1}' > "$PROGRESS_FILE"
        
        echo
        echo -e "${GREEN}${BOLD}✅ Progress Reset Complete!${NC}"
        echo -e "${CYAN}Your quest adventure starts fresh. Good luck!${NC}"
        echo
        read -p "Press Enter to continue..."
    else
        echo
        echo -e "${YELLOW}Reset cancelled. Your progress is safe!${NC}"
        sleep 2
    fi
}

quest_menu() {
    while true; do
        print_header
        print_progress
        
        echo -e "${BOLD}${BLUE}Choose your quest:${NC}"
        echo
        
        # Check completion status for each quest
        local completed_quests=$(jq -r '.completed_quests[]' "$PROGRESS_FILE" 2>/dev/null || echo "")
        
        # Quest 1
        if echo "$completed_quests" | grep -q "explorer"; then
            echo -e "1. ${GREEN}✅ 🗺️  Explore Kiro Interface (Beginner) - COMPLETED${NC}"
        else
            echo "1. 🗺️  Explore Kiro Interface (Beginner)"
        fi
        
        # Quest 2
        if echo "$completed_quests" | grep -q "chat_master"; then
            echo -e "2. ${GREEN}✅ 💬 Master Chat Features (Beginner) - COMPLETED${NC}"
        else
            echo "2. 💬 Master Chat Features (Beginner)"
        fi
        
        # Quest 3
        if echo "$completed_quests" | grep -q "file_wizard"; then
            echo -e "3. ${GREEN}✅ 📁 Discover File Context Magic (Intermediate) - COMPLETED${NC}"
        else
            echo "3. 📁 Discover File Context Magic (Intermediate)"
        fi
        
        # Quest 4
        if echo "$completed_quests" | grep -q "autopilot_ace"; then
            echo -e "4. ${GREEN}✅ 🚁 Experience Autopilot Mode (Intermediate) - COMPLETED${NC}"
        else
            echo "4. 🚁 Experience Autopilot Mode (Intermediate)"
        fi
        
        # Quest 5
        if echo "$completed_quests" | grep -q "spec_architect"; then
            echo -e "5. ${GREEN}✅ 📋 Create Your First Spec (Advanced) - COMPLETED${NC}"
        else
            echo "5. 📋 Create Your First Spec (Advanced)"
        fi
        
        # Quest 6
        if echo "$completed_quests" | grep -q "hook_hero"; then
            echo -e "6. ${GREEN}✅ 🎣 Set Up Agent Hooks (Advanced) - COMPLETED${NC}"
        else
            echo "6. 🎣 Set Up Agent Hooks (Advanced)"
        fi
        
        # Quest 7
        if echo "$completed_quests" | grep -q "mcp_pioneer"; then
            echo -e "7. ${GREEN}✅ 🔌 Configure MCP Tools (Expert) - COMPLETED${NC}"
        else
            echo "7. 🔌 Configure MCP Tools (Expert)"
        fi
        
        # Quest 8
        if echo "$completed_quests" | grep -q "steering_captain"; then
            echo -e "8. ${GREEN}✅ 🎯 Customize with Steering (Expert) - COMPLETED${NC}"
        else
            echo "8. 🎯 Customize with Steering (Expert)"
        fi
        
        # Quest 9
        if echo "$completed_quests" | grep -q "code_commander"; then
            echo -e "9. ${GREEN}✅ ⚡ Master Code Assistance (Expert) - COMPLETED${NC}"
        else
            echo "9. ⚡ Master Code Assistance (Expert)"
        fi
        
        echo
        echo "0. 🏆 View Badge Collection"
        echo "r. 🔄 Reset All Progress"
        echo "q. Quit Quest"
        echo
        read -p "Enter your choice: " choice
        
        case $choice in
            1) quest_explore_interface ;;
            2) quest_chat_features ;;
            3) quest_file_context ;;
            4) quest_autopilot ;;
            5) quest_specs ;;
            6) quest_hooks ;;
            7) quest_mcp ;;
            8) quest_steering ;;
            9) quest_code_assistance ;;
            0) show_badges; read -p "Press Enter to continue..." ;;
            r|R) reset_progress ;;
            q|Q) echo -e "${GREEN}Thanks for playing! May your code be bug-free! 🚀${NC}"; exit 0 ;;
            *) echo -e "${RED}Invalid choice. Try again!${NC}"; sleep 1 ;;
        esac
    done
}

quest_explore_interface() {
    clear
    echo -e "${BOLD}${BLUE}🗺️  Quest 1: Explore Kiro Interface${NC}"
    echo
    echo "Welcome, brave developer! Let's start your journey by exploring Kiro's interface."
    echo
    echo -e "${YELLOW}Your mission:${NC}"
    echo "• Open Kiro in your IDE"
    echo "• Locate the chat panel"
    echo "• Find the feature panel with MCP servers, Agent Hooks, etc."
    echo "• Explore the command palette (Cmd+Shift+P / Ctrl+Shift+P)"
    echo
    echo -e "${CYAN}💡 Pro Tips:${NC}"
    echo "• 👻 If unsure or want more info, ask Kiro"
    echo "• The chat panel is where you'll spend most of your time"
    echo "• The feature panel contains advanced Kiro tools"
    echo "• Search for 'Kiro' in the command palette to see all available commands"
    echo
    
    echo -e "${GREEN}${BOLD}Press 'y' or 'Y' to mark this quest as complete!${NC}"
    read -p "Have you explored Kiro's interface? (y/n): " response
    if [[ $response =~ ^[Yy]$ ]]; then
        award_badge "explorer" 50
    else
        echo -e "${YELLOW}Take your time! Come back when you're ready.${NC}"
        sleep 2
    fi
}

quest_chat_features() {
    clear
    echo -e "${BOLD}${BLUE}💬 Quest 2: Master Chat Features${NC}"
    echo
    echo "Time to have your first conversation with Kiro!"
    echo
    echo -e "${YELLOW}Your mission:${NC}"
    echo "• Start a chat with Kiro"
    echo "• Try using context shortcuts like #File, #Folder, #Problems"
    echo "• Ask Kiro to explain a piece of code"
    echo "• Upload an image by dragging it into chat"
    echo
    echo -e "${CYAN}💡 Pro Tips:${NC}"
    echo "• 👻 If unsure or want more info, ask Kiro"
    echo "• Use #Codebase to scan your entire project (after indexing)"
    echo "• #Terminal shows your current terminal state"
    echo "• #Git shows your current git diff"
    echo "• Kiro can see problems in your current file with #Problems"
    echo
    echo -e "${GREEN}Example questions to try:${NC}"
    echo "• 'Explain this function' (with #File context)"
    echo "• 'What are the current problems in my code?' (with #Problems)"
    echo "• 'Help me refactor this component'"
    echo
    
    echo -e "${GREEN}${BOLD}Press 'y' or 'Y' to mark this quest as complete!${NC}"
    read -p "Have you chatted with Kiro and used context features? (y/n): " response
    if [[ $response =~ ^[Yy]$ ]]; then
        award_badge "chat_master" 75
    else
        echo -e "${YELLOW}Don't be shy! Kiro loves to chat. Come back when you're ready.${NC}"
        sleep 2
    fi
}

quest_file_context() {
    clear
    echo -e "${BOLD}${BLUE}📁 Quest 3: Discover File Context Magic${NC}"
    echo
    echo "Now let's explore how Kiro understands your files and folders!"
    echo
    echo -e "${YELLOW}Your mission:${NC}"
    echo "• Use #File to reference a specific file in chat"
    echo "• Use #Folder to include an entire directory"
    echo "• Try asking Kiro to analyze your project structure"
    echo "• Ask Kiro to find files matching a pattern"
    echo
    echo -e "${CYAN}💡 Pro Tips:${NC}"
    echo "• 👻 If unsure or want more info, ask Kiro"
    echo "• You can drag files directly into the chat"
    echo "• #Codebase gives Kiro access to your entire indexed project"
    echo "• Kiro can understand relationships between files"
    echo
    echo -e "${GREEN}Example tasks to try:${NC}"
    echo "• 'Analyze the structure of #Folder src/'"
    echo "• 'Find all TODO comments in #Codebase'"
    echo "• 'What does #File package.json tell you about this project?'"
    echo
    
    echo -e "${GREEN}${BOLD}Press 'y' or 'Y' to mark this quest as complete!${NC}"
    read -p "Have you used file context features successfully? (y/n): " response
    if [[ $response =~ ^[Yy]$ ]]; then
        award_badge "file_wizard" 100
    else
        echo -e "${YELLOW}File context is powerful! Try it out and come back.${NC}"
        sleep 2
    fi
}

quest_autopilot() {
    clear
    echo -e "${BOLD}${BLUE}🚁 Quest 4: Experience Autopilot Mode${NC}"
    echo
    echo "Ready to let Kiro take the wheel? Let's explore autonomous mode!"
    echo
    echo -e "${YELLOW}Your mission:${NC}"
    echo "• Enable Autopilot mode in Kiro settings"
    echo "• Ask Kiro to make a simple change to a file"
    echo "• Watch as Kiro modifies files autonomously"
    echo "• Try Supervised mode to review changes before applying"
    echo
    echo -e "${CYAN}💡 Pro Tips:${NC}"
    echo "• 👻 If unsure or want more info, ask Kiro"
    echo "• Autopilot mode lets Kiro modify files without asking permission"
    echo "• Supervised mode gives you a chance to review changes"
    echo "• Start with small tasks to get comfortable"
    echo "• You can always undo changes with git or IDE history"
    echo
    echo -e "${GREEN}Example tasks to try:${NC}"
    echo "• 'Add a comment to the main function in #File app.js'"
    echo "• 'Create a simple README.md file for this project'"
    echo "• 'Fix the indentation in #File style.css'"
    echo
    echo -e "${RED}⚠️  Safety Note:${NC} Always have version control or backups!"
    echo
    
    echo -e "${GREEN}${BOLD}Press 'y' or 'Y' to mark this quest as complete!${NC}"
    read -p "Have you tried Autopilot or Supervised mode? (y/n): " response
    if [[ $response =~ ^[Yy]$ ]]; then
        award_badge "autopilot_ace" 125
    else
        echo -e "${YELLOW}Autopilot is exciting but be careful! Come back when ready.${NC}"
        sleep 2
    fi
}

quest_specs() {
    clear
    echo -e "${BOLD}${BLUE}📋 Quest 5: Create Your First Spec${NC}"
    echo
    echo "Time to plan like a pro! Specs help you build complex features systematically."
    echo
    echo -e "${YELLOW}Your mission:${NC}"
    echo "• Create a new spec file (.md format)"
    echo "• Define requirements for a simple feature"
    echo "• Include design considerations"
    echo "• Let Kiro help implement based on your spec"
    echo
    echo -e "${CYAN}💡 Pro Tips:${NC}"
    echo "• 👻 If unsure or want more info, ask Kiro"
    echo "• Specs formalize the design and implementation process"
    echo "• Use #[[file:filename]] to reference other files in specs"
    echo "• Specs allow incremental development of complex features"
    echo "• Great for planning before coding"
    echo
    echo -e "${GREEN}Example spec ideas:${NC}"
    echo "• A simple todo list component"
    echo "• A user authentication system"
    echo "• A data validation utility"
    echo "• An API endpoint design"
    echo
    
    echo -e "${GREEN}${BOLD}Press 'y' or 'Y' to mark this quest as complete!${NC}"
    read -p "Have you created and used a spec with Kiro? (y/n): " response
    if [[ $response =~ ^[Yy]$ ]]; then
        award_badge "spec_architect" 150
    else
        echo -e "${YELLOW}Specs are powerful planning tools! Give it a try.${NC}"
        sleep 2
    fi
}

quest_hooks() {
    clear
    echo -e "${BOLD}${BLUE}🎣 Quest 6: Set Up Agent Hooks${NC}"
    echo
    echo "Automate your workflow! Hooks trigger Kiro actions based on events."
    echo
    echo -e "${YELLOW}Your mission:${NC}"
    echo "• Open the Agent Hooks section in the explorer view"
    echo "• Create a hook that triggers on file save"
    echo "• Set up a manual hook for a common task"
    echo "• Test your hook by triggering the event"
    echo
    echo -e "${CYAN}💡 Pro Tips:${NC}"
    echo "• 👻 If unsure or want more info, ask Kiro"
    echo "• Use Command Palette: 'Open Kiro Hook UI' to get started"
    echo "• Hooks can trigger on saves, updates, or manual clicks"
    echo "• Great for running tests, updating translations, or code reviews"
    echo "• Start simple and build complexity over time"
    echo
    echo -e "${GREEN}Example hook ideas:${NC}"
    echo "• Auto-run tests when you save a test file"
    echo "• Update documentation when code changes"
    echo "• Spell-check README files on demand"
    echo "• Format code on save"
    echo
    
    echo -e "${GREEN}${BOLD}Press 'y' or 'Y' to mark this quest as complete!${NC}"
    read -p "Have you created and tested an agent hook? (y/n): " response
    if [[ $response =~ ^[Yy]$ ]]; then
        award_badge "hook_hero" 175
    else
        echo -e "${YELLOW}Hooks are automation magic! Try creating one.${NC}"
        sleep 2
    fi
}

quest_mcp() {
    clear
    echo -e "${BOLD}${BLUE}🔌 Quest 7: Configure MCP Tools${NC}"
    echo
    echo "Extend Kiro's capabilities with Model Context Protocol tools!"
    echo
    echo -e "${YELLOW}Your mission:${NC}"
    echo "• Create or edit .kiro/settings/mcp.json in your workspace"
    echo "• Add an MCP server configuration"
    echo "• Test the MCP tool with Kiro"
    echo "• Explore available MCP servers"
    echo
    echo -e "${CYAN}💡 Pro Tips:${NC}"
    echo "• 👻 If unsure or want more info, ask Kiro"
    echo "• MCP servers typically use 'uvx' command (requires uv installation)"
    echo "• Check MCP Server view in Kiro feature panel"
    echo "• Servers reconnect automatically on config changes"
    echo "• Use autoApprove to skip confirmations for trusted tools"
    echo
    echo -e "${GREEN}Popular MCP servers to try:${NC}"
    echo "• aws-docs: AWS documentation access"
    echo "• filesystem: Enhanced file operations"
    echo "• web-search: Internet search capabilities"
    echo "• database: Database query tools"
    echo
    echo -e "${YELLOW}Example mcp.json structure:${NC}"
    echo '{'
    echo '  "mcpServers": {'
    echo '    "server-name": {'
    echo '      "command": "uvx",'
    echo '      "args": ["package-name@latest"],'
    echo '      "disabled": false'
    echo '    }'
    echo '  }'
    echo '}'
    echo
    
    echo -e "${GREEN}${BOLD}Press 'y' or 'Y' to mark this quest as complete!${NC}"
    read -p "Have you configured and tested an MCP server? (y/n): " response
    if [[ $response =~ ^[Yy]$ ]]; then
        award_badge "mcp_pioneer" 200
    else
        echo -e "${YELLOW}MCP tools are powerful extensions! Give them a try.${NC}"
        sleep 2
    fi
}

quest_steering() {
    clear
    echo -e "${BOLD}${BLUE}🎯 Quest 8: Customize with Steering${NC}"
    echo
    echo "Make Kiro work exactly how you want with steering files!"
    echo
    echo -e "${YELLOW}Your mission:${NC}"
    echo "• Create a .kiro/steering/ directory"
    echo "• Add a custom steering file (.md format)"
    echo "• Include team standards or project-specific instructions"
    echo "• Test how it influences Kiro's responses"
    echo
    echo -e "${CYAN}💡 Pro Tips:${NC}"
    echo "• 👻 If unsure or want more info, ask Kiro"
    echo "• Steering files are always included by default"
    echo "• Use front-matter for conditional inclusion"
    echo "• Reference other files with #[[file:filename]]"
    echo "• Great for coding standards, team norms, and project context"
    echo
    echo -e "${GREEN}Steering file ideas:${NC}"
    echo "• Code style guidelines"
    echo "• Testing requirements"
    echo "• Architecture decisions"
    echo "• API specifications"
    echo "• Team conventions"
    echo
    echo -e "${YELLOW}Example steering file:${NC}"
    echo "---"
    echo "inclusion: always"
    echo "---"
    echo "# Team Coding Standards"
    echo "- Always use TypeScript"
    echo "- Include unit tests for new functions"
    echo "- Follow ESLint configuration"
    echo
    
    echo -e "${GREEN}${BOLD}Press 'y' or 'Y' to mark this quest as complete!${NC}"
    read -p "Have you created and tested a steering file? (y/n): " response
    if [[ $response =~ ^[Yy]$ ]]; then
        award_badge "steering_captain" 225
    else
        echo -e "${YELLOW}Steering files customize Kiro perfectly! Try creating one.${NC}"
        sleep 2
    fi
}

quest_code_assistance() {
    clear
    echo -e "${BOLD}${BLUE}⚡ Quest 9: Master Code Assistance${NC}"
    echo
    echo "The final quest! Master all of Kiro's code assistance features."
    echo
    echo -e "${YELLOW}Your mission:${NC}"
    echo "• Ask Kiro to refactor a complex function"
    echo "• Use Kiro to debug an issue"
    echo "• Generate tests for existing code"
    echo "• Optimize code performance with Kiro's help"
    echo "• Create documentation for your code"
    echo
    echo -e "${CYAN}💡 Pro Tips:${NC}"
    echo "• 👻 If unsure or want more info, ask Kiro"
    echo "• Kiro excels at explaining complex code"
    echo "• Use specific, detailed requests for best results"
    echo "• Combine multiple features (specs + autopilot + steering)"
    echo "• Kiro can help with architecture decisions"
    echo
    echo -e "${GREEN}Advanced tasks to try:${NC}"
    echo "• 'Refactor this class to use dependency injection'"
    echo "• 'Generate comprehensive tests for #File utils.js'"
    echo "• 'Optimize this algorithm for better performance'"
    echo "• 'Create API documentation from this code'"
    echo "• 'Suggest architectural improvements for this module'"
    echo
    
    echo -e "${GREEN}${BOLD}Press 'y' or 'Y' to mark this quest as complete!${NC}"
    read -p "Have you mastered Kiro's code assistance features? (y/n): " response
    if [[ $response =~ ^[Yy]$ ]]; then
        award_badge "code_commander" 250
        
        # Check if this completes all quests
        local completed=$(jq -r '.completed_quests | length' "$PROGRESS_FILE")
        if [[ $completed -eq 9 ]]; then
            award_badge "quest_champion" 500
            echo
            echo -e "${PURPLE}${BOLD}🎊 CONGRATULATIONS! 🎊${NC}"
            echo -e "${WHITE}You've completed the entire Kiro Onboarding Quest!${NC}"
            echo -e "${GREEN}You're now a certified Kiro master! 🚀${NC}"
            echo
        fi
    else
        echo -e "${YELLOW}The final challenge awaits! Master these features to complete your quest.${NC}"
        sleep 2
    fi
}

# Main execution
main() {
    # Check if jq is available
    if ! command -v jq &> /dev/null; then
        echo -e "${RED}Error: jq is required but not installed.${NC}"
        echo "Please install jq to run the Kiro Onboarding Quest."
        echo "On macOS: brew install jq"
        exit 1
    fi
    
    # Initialize enhanced features if enabled
    initialize_enhanced_features
    
    quest_menu
}

# Run the quest
main "$@"