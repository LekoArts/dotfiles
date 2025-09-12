# fnm
eval "$(fnm env --use-on-cd)"

# Macports
export PATH=/opt/local/bin:/opt/local/sbin:$PATH
# Go
export PATH=$PATH:$(go env GOPATH)/bin

# Add NPM token
export NPM_TOKEN="grep registry.npmjs.org/:_authToken ~/.npmrc | cut -d = -f 2"
# Bat
export BAT_CONFIG_PATH="$HOME/bat.conf"
# fd as fzf standard
export FZF_DEFAULT_COMMAND="fd --type f"
# Change zsh-z default cmd
export ZSHZ_CMD="_z"

# fpath changes
fpath+=${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions/src

autoload -U compinit && compinit

# enable color support of ls and also add handy aliases
# GNU tools from MacPorts, to install run:
# sudo port install coreutils +with_default_names
if [ -x /opt/local/libexec/gnubin/dircolors ]; then
  alias dircolors=/opt/local/libexec/gnubin/dircolors
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Default editor
export REACT_EDITOR="code"
export EDITOR="code"

DEFAULT_USER="whoami"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="spaceship"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

ZSH_TAB_TITLE_CONCAT_FOLDER_PROCESS=true
ZSH_TAB_TITLE_DEFAULT_DISABLE_PREFIX=true

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git zsh-autosuggestions zsh-syntax-highlighting zsh-dircolors-solarized history gh rust ohmyzsh-full-autoupdate zsh-tab-title z)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.

# Aliases

alias zshrc="code ~/.zshrc"
alias ohmyzsh="cd ~/.oh-my-zsh"
alias c="code ."
alias sb="source ~/.zshrc"
alias npmg="npm list -g --depth 0"
alias npkill="npx npkill"
alias portupdate="sudo port selfupdate && sudo port upgrade outdated"
alias preview="fzf --preview 'bat --color=always {}' --preview-window '~3'"
alias rm=trash

## eza
alias ls="eza" # ls
alias ll='eza -lbF --git' # list, size, type, git
alias llm='eza -lbGd --git --sort=modified' # long list, modified date sort
alias la='eza -lbhHigUmuSa --time-style=long-iso --git --color-scale' # all list
alias lx='eza -lbhHigUmuSa@ --time-style=long-iso --git --color-scale' # all + extended list
alias lS='eza -1' # one column, just names
alias lt='eza --tree --level=2' # tree

# Other functions

# Navigate directories with fzf
z() {
  [ $# -gt 0 ] && _z "$*" && return
  cd "$(_z -l 2>&1 | fzf --height 40% --nth 2.. --reverse --inline-info +s --tac --query "${*##-* }" | sed 's/^[0-9,.]* *//')"
}
# Fuzzy-search branches
gcos() {
  _fzf_git_branches --no-multi | xargs git checkout
}
# Copy globally installed packages from one version of Node to another
# Usage: fnm_upgrade 18.17.1
fnm_upgrade () {
  fnm exec --using=$1 npm ls --global --json \
    | jq -r '.dependencies | to_entries[] | .key+"@"+.value.version' \
    | xargs npm i -g
}

# Git worktree helper function
# Usage: wt <type>/<name> or wt <name>
# Examples: 
#   wt feat/awesome-feature
#   wt fix/login-bug
#   wt simple-feature
wt() {
    if [[ $# -eq 0 ]]; then
        echo "Usage: wt <branch-name>"
        echo "Examples:"
        echo "  wt feat/awesome-feature"
        echo "  wt fix/login-bug"
        echo "  wt simple-feature"
        echo ""
        echo "Creates a new worktree in ../<repo-name>--<folder-name> with a new branch from main"
        return 1
    fi
    
    local branch_name="$1"
    local folder_name
    
    # If branch contains a slash, use only the part after the slash for folder name
    # Otherwise use the full branch name
    if [[ "$branch_name" == */* ]]; then
        folder_name="${branch_name##*/}"  # Extract everything after the last slash
    else
        folder_name="$branch_name"
    fi
    
    # Get the main repo name from the first worktree (which is always the main repo)
    local main_repo_path=$(git worktree list | head -n1 | awk '{print $1}')
    local repo_name=$(basename "$main_repo_path")
    local worktree_path="../$repo_name--$folder_name"
    
    echo "Creating worktree '$worktree_path' with branch '$branch_name' from main..."
    
    # Create the worktree with new branch from main
    if git worktree add -b "$branch_name" "$worktree_path" main; then
        echo "✅ Successfully created worktree at $worktree_path"
        echo "🌿 Branch: $branch_name"
        echo "📁 Folder: $worktree_path"
        cd "$worktree_path"
    else
        echo "❌ Failed to create worktree"
        return 1
    fi
}

# PR worktree helper function
# Usage: wtpr <pr-number>
# Example: wtpr 5235
wtpr() {
    if [[ $# -eq 0 ]]; then
        echo "Usage: wtpr <pr-number>"
        echo "Example: wtpr 5235"
        echo ""
        echo "Checks out a PR branch in a new worktree using GitHub CLI"
        return 1
    fi
    
    local pr_number="$1"
    
    # Check if gh is installed
    if ! command -v gh &> /dev/null; then
        echo "❌ GitHub CLI (gh) is not installed"
        echo "Install it with: brew install gh"
        return 1
    fi
    
    echo "Fetching PR #$pr_number info..."
    
    # Check if we're in a git repository (including worktrees)
    if ! git status &>/dev/null; then
        echo "❌ Not in a git repository or git is not working"
        return 1
    fi
    
    # Show current repo (works in worktrees too)
    echo "Repository: $(git remote get-url origin 2>/dev/null | sed 's/.*github\.com[:/]\([^/]*\/[^/]*\)\.git.*/\1/' || echo 'Unknown')"
    
    # Get PR branch name using gh with explicit repo context
    local branch_name
    local repo_url=$(git remote get-url origin 2>/dev/null)
    if [[ -z "$repo_url" ]]; then
        echo "❌ Could not determine repository origin"
        return 1
    fi
    
    # Extract owner/repo from URL
    local repo_path=$(echo "$repo_url" | sed 's/.*github\.com[:/]\([^/]*\/[^/]*\)\.git.*/\1/')
    
    if ! branch_name=$(gh pr view "$pr_number" --repo "$repo_path" --json headRefName --jq '.headRefName' 2>/dev/null); then
        echo "❌ Failed to fetch PR #$pr_number from $repo_path"
        echo "💡 Try running: gh pr view $pr_number --repo $repo_path"
        echo "💡 Or check: gh pr list --repo $repo_path"
        return 1
    fi
    
    if [[ -z "$branch_name" ]]; then
        echo "❌ Could not determine branch name for PR #$pr_number"
        return 1
    fi
    
    # Get current directory name for the folder
    # If we're in a worktree, use the main repo folder name instead
    local project_name
    if [[ -f .git ]]; then
        # We're in a worktree, get the main repo path
        local main_repo_path=$(cat .git | sed 's/gitdir: //' | sed 's|/\.git/worktrees/.*||')
        project_name=$(basename "$main_repo_path")
    else
        # We're in the main repo
        project_name=$(basename "$PWD")
    fi
    local folder_name="$project_name-pr-$pr_number"
    local worktree_path="../$folder_name"
    
    # Check if worktree already exists
    if [[ -d "$worktree_path" ]]; then
        echo "📁 Worktree already exists at $worktree_path"
        echo "🚀 Switching to existing worktree..."
        cd "$worktree_path" && pwd
        return 0
    fi
    
    echo "Creating worktree '$worktree_path' for PR #$pr_number (branch: $branch_name)..."
    
    # Fetch the PR branch first to ensure we have it locally
    if ! gh pr checkout "$pr_number" --repo "$repo_path"; then
        echo "❌ Failed to checkout PR #$pr_number"
        return 1
    fi
    
    # Store current branch to switch back later
    local original_branch=$(git branch --show-current)
    
    # Check if we already have the PR branch locally (gh pr checkout creates it)
    if git show-ref --verify --quiet refs/heads/"$branch_name"; then
        echo "Using existing local branch: $branch_name"
        # Create worktree from the actual PR branch
        if git worktree add "$worktree_path" "$branch_name"; then
            echo "✅ Successfully created worktree at $worktree_path"
            echo "🔀 PR: #$pr_number"
            echo "🌿 Branch: $branch_name"
            echo "📁 Folder: $worktree_path"
            
            # Switch back to original branch
            git checkout "$original_branch" > /dev/null 2>&1
            
            echo "🚀 Switching to worktree..."
            cd "$worktree_path" && pwd
        else
            echo "❌ Failed to create PR worktree"
            return 1
        fi
    else
        echo "❌ Could not create local branch for PR #$pr_number"
        return 1
    fi
}

# Git worktree helper function from current branch
# Usage: wtb <type>/<name> or wtb <name>
# Examples: 
#   wtb feat/awesome-feature
#   wtb fix/login-bug
#   wtb simple-feature
wtb() {
    if [[ $# -eq 0 ]]; then
        echo "Usage: wtb <branch-name>"
        echo "Examples:"
        echo "  wtb feat/awesome-feature"
        echo "  wtb fix/login-bug"
        echo "  wtb simple-feature"
        echo ""
        echo "Creates a new worktree in ../<repo-name>--<folder-name> with a new branch from current branch"
        return 1
    fi
    
    local branch_name="$1"
    local folder_name
    
    # If branch contains a slash, use only the part after the slash for folder name
    # Otherwise use the full branch name
    if [[ "$branch_name" == */* ]]; then
        folder_name="${branch_name##*/}"  # Extract everything after the last slash
    else
        folder_name="$branch_name"
    fi
    
    # Get the main repo name from the first worktree (which is always the main repo)
    local main_repo_path=$(git worktree list | head -n1 | awk '{print $1}')
    local repo_name=$(basename "$main_repo_path")
    local worktree_path="../$repo_name--$folder_name"
    local current_branch=$(git branch --show-current)
    
    echo "Creating worktree '$worktree_path' with branch '$branch_name' from current branch ($current_branch)..."
    
    # Create the worktree with new branch from current HEAD
    if git worktree add -b "$branch_name" "$worktree_path" HEAD; then
        echo "✅ Successfully created worktree at $worktree_path"
        echo "🌿 Branch: $branch_name (from $current_branch)"
        echo "📁 Folder: $worktree_path"
        cd "$worktree_path"
    else
        echo "❌ Failed to create worktree"
        return 1
    fi
}

# Git worktree cleanup functions

# Remove current worktree and switch back to main repo
# Usage: wtc (no arguments - removes the current worktree you're in)
wtc() {
    # Check if we're in a worktree
    if [[ ! -f .git ]] || ! grep -q "gitdir:" .git 2>/dev/null; then
        echo "❌ Not in a git worktree (you're in the main repo)"
        echo "💡 Use 'wtc <path>' to remove a specific worktree"
        return 1
    fi
    
    local current_path=$(pwd)
    local worktree_name=$(basename "$current_path")
    
    # Get the main repo path from .git file
    local main_repo_path=$(cat .git | sed 's/gitdir: //' | sed 's|/\.git/worktrees/.*||')
    
    echo "🗑️  Removing current worktree: $worktree_name"
    echo "🏠 Switching back to main repo at: $main_repo_path"
    
    # Switch to main repo first
    cd "$main_repo_path"
    
    # Remove the worktree (try without force first)
    if git worktree remove "$current_path"; then
        echo "✅ Successfully removed worktree"
        # Also remove the local branch if it exists and is not checked out elsewhere
        local branch_name=$(basename "$worktree_name")
        if git show-ref --verify --quiet refs/heads/"$branch_name"; then
            echo "🌿 Removing local branch: $branch_name"
            git branch -D "$branch_name" 2>/dev/null || echo "⚠️  Could not remove branch (might be checked out elsewhere)"
        fi
    else
        echo "❌ Failed to remove worktree"
        return 1
    fi
}

# List all worktrees with status
# Usage: wtl
wtl() {
    echo "📂 Git worktrees:"
    git worktree list
}

# Remove a specific worktree by name/path
# Usage: wtr <worktree-name-or-path>
wtr() {
    if [[ $# -eq 0 ]]; then
        echo "Usage: wtr <worktree-name-or-path>"
        echo "Example: wtr my-project--feature-branch"
        echo ""
        echo "💡 Use 'wtl' to list all worktrees"
        echo "💡 Use 'wtc' to remove the current worktree you're in"
        return 1
    fi
    
    local target="$1"
    
    # If it's just a name, try to find it as a sibling directory
    if [[ "$target" != /* ]] && [[ "$target" != ./* ]]; then
        target="../$target"
    fi
    
    if [[ ! -d "$target" ]]; then
        echo "❌ Worktree not found: $target"
        echo "💡 Use 'wtl' to list all worktrees"
        return 1
    fi
    
    local worktree_name=$(basename "$target")
    
    echo "🗑️  Removing worktree: $worktree_name"
    
    if git worktree remove "$target"; then
        echo "✅ Successfully removed worktree: $target"
        # Try to remove the associated branch
        if git show-ref --verify --quiet refs/heads/"$worktree_name"; then
            echo "🌿 Removing local branch: $worktree_name"
            git branch -D "$worktree_name" 2>/dev/null || echo "⚠️  Could not remove branch (might be checked out elsewhere)"
        fi
    else
        echo "❌ Failed to remove worktree"
        return 1
    fi
}

# Clean up all stale worktree references
# Usage: wtprune
wtprune() {
    echo "🧹 Pruning stale worktree references..."
    git worktree prune
    echo "✅ Done"
}

# Check out existing branch as worktree
# Usage: wte <existing-branch-name>
# Examples:
#   wte feature/existing-branch
#   wte bugfix/old-fix
wte() {
    if [[ $# -eq 0 ]]; then
        echo "Usage: wte <existing-branch-name>"
        echo "Examples:"
        echo "  wte feature/existing-branch"
        echo "  wte bugfix/old-fix"
        echo ""
        echo "Creates a worktree from an existing branch"
        echo "💡 Use 'git branch -a' to see all available branches"
        return 1
    fi
    
    local branch_name="$1"
    local folder_name
    
    # Check if branch exists (local or remote)
    if ! git show-ref --verify --quiet refs/heads/"$branch_name" && ! git show-ref --verify --quiet refs/remotes/origin/"$branch_name"; then
        echo "❌ Branch '$branch_name' not found"
        echo "💡 Available branches:"
        git branch -a | head -10
        return 1
    fi
    
    # If branch contains a slash, use only the part after the slash for folder name
    # Otherwise use the full branch name
    if [[ "$branch_name" == */* ]]; then
        folder_name="${branch_name##*/}"  # Extract everything after the last slash
    else
        folder_name="$branch_name"
    fi
    
    # Get the main repo name from the first worktree (which is always the main repo)
    local main_repo_path=$(git worktree list | head -n1 | awk '{print $1}')
    local repo_name=$(basename "$main_repo_path")
    local worktree_path="../$repo_name--$folder_name"
    
    # Check if worktree path already exists
    if [[ -d "$worktree_path" ]]; then
        echo "❌ Directory already exists: $worktree_path"
        return 1
    fi
    
    echo "Creating worktree '$worktree_path' for existing branch '$branch_name'..."
    
    # Create the worktree with existing branch
    if git worktree add "$worktree_path" "$branch_name"; then
        echo "✅ Successfully created worktree at $worktree_path"
        echo "🌿 Branch: $branch_name (existing)"
        echo "📁 Folder: $worktree_path"
        cd "$worktree_path"
    else
        echo "❌ Failed to create worktree"
        return 1
    fi
}

# Interactive worktree TUI
# Usage: wti
wti() {
    # Check if we're in a git repo
    if ! git status &>/dev/null; then
        echo "❌ Not in a git repository"
        return 1
    fi
    
    # Check if fzf is available
    if ! command -v fzf &> /dev/null; then
        echo "❌ fzf is required for the interactive interface"
        echo "Install with: brew install fzf"
        return 1
    fi
    
    # Main menu options
    local options=(
        "📝 Create new branch from main (wt)"
        "🌿 Create new branch from current (wtb)"
        "📂 Checkout existing branch (wte)"
        "🔄 Checkout PR branch (wtpr)"
        "📋 List all worktrees (wtl)"
        "🗑️  Remove current worktree (wtc)"
        "🗂️  Remove specific worktree (wtr)"
        "🧹 Prune stale references (wtprune)"
        "❌ Cancel"
    )
    
    echo "🚀 Interactive Worktree Manager"
    echo "==============================="
    
    local choice=$(printf '%s\n' "${options[@]}" | fzf --height=12 --prompt="Select action: " --border --header="Choose a worktree operation:")
    
    case "$choice" in
        "📝 Create new branch from main (wt)")
            echo "Enter new branch name (e.g., feat/awesome-feature):"
            read -r branch_name
            if [[ -n "$branch_name" ]]; then
                wt "$branch_name"
            else
                echo "❌ Branch name required"
            fi
            ;;
        "🌿 Create new branch from current (wtb)")
            local current_branch=$(git branch --show-current)
            echo "Enter new branch name (will branch from: $current_branch):"
            read -r branch_name
            if [[ -n "$branch_name" ]]; then
                wtb "$branch_name"
            else
                echo "❌ Branch name required"
            fi
            ;;
        "📂 Checkout existing branch (wte)")
            echo "🔍 Finding branches..."
            
            # Get all branches efficiently in one command, sorted by recency
            # This includes both local and remote branches
            local current_branch=$(git branch --show-current)
            
            # Use git for-each-ref for fast branch listing with commit info
            local selected_branch=$(git for-each-ref --format='%(refname:short) %(committerdate:relative)' --sort=-committerdate refs/heads/ refs/remotes/origin/ | \
                grep -v "^$current_branch " | \
                sed 's|^origin/||' | \
                awk '!seen[$1]++ {printf "%-30s (%s)\n", $1, $2}' | \
                fzf --height=20 --prompt="Select branch: " --border --header="Choose existing branch (sorted by recency):" | \
                awk '{print $1}')
            
            if [[ -n "$selected_branch" ]]; then
                wte "$selected_branch"
            else
                echo "❌ No branch selected"
            fi
            ;;
        "🔄 Checkout PR branch (wtpr)")
            echo "Enter PR number:"
            read -r pr_number
            if [[ -n "$pr_number" && "$pr_number" =~ ^[0-9]+$ ]]; then
                wtpr "$pr_number"
            else
                echo "❌ Valid PR number required"
            fi
            ;;
        "📋 List all worktrees (wtl)")
            wtl
            ;;
        "🗑️  Remove current worktree (wtc)")
            # Check if we're in a worktree first
            if [[ -f .git ]] && grep -q "gitdir:" .git 2>/dev/null; then
                local current_worktree=$(basename "$PWD")
                echo "⚠️  You're about to remove the current worktree: $current_worktree"
                echo "Are you sure? (y/N):"
                read -r confirm
                if [[ "$confirm" =~ ^[Yy]$ ]]; then
                    wtc
                else
                    echo "❌ Cancelled"
                fi
            else
                echo "❌ Not in a worktree (you're in the main repo)"
                echo "💡 Use 'Remove specific worktree' option instead"
            fi
            ;;
        "🗂️  Remove specific worktree (wtr)")
            echo "🔍 Finding worktrees..."
            # Get all worktrees except the main one
            local worktrees=($(git worktree list | tail -n +2 | awk '{print $1}' | xargs -I {} basename {}))
            
            if [[ ${#worktrees[@]} -eq 0 ]]; then
                echo "❌ No additional worktrees found"
                return 1
            fi
            
            local selected_worktree=$(printf '%s\n' "${worktrees[@]}" | fzf --height=10 --prompt="Select worktree to remove: " --border --header="Choose worktree to remove:")
            
            if [[ -n "$selected_worktree" ]]; then
                echo "⚠️  You're about to remove worktree: $selected_worktree"
                echo "Are you sure? (y/N):"
                read -r confirm
                if [[ "$confirm" =~ ^[Yy]$ ]]; then
                    wtr "$selected_worktree"
                else
                    echo "❌ Cancelled"
                fi
            else
                echo "❌ No worktree selected"
            fi
            ;;
        "🧹 Prune stale references (wtprune)")
            echo "🧹 This will clean up stale worktree references"
            echo "Continue? (y/N):"
            read -r confirm
            if [[ "$confirm" =~ ^[Yy]$ ]]; then
                wtprune
            else
                echo "❌ Cancelled"
            fi
            ;;
        "❌ Cancel"|"")
            echo "❌ Cancelled"
            ;;
        *)
            echo "❌ Invalid selection"
            ;;
    esac
}

# Git worktree helper function for GitHub issues
# Usage: wtis <issue-number> or wtis <issue-url>
# Examples:
#   wtis 6701
#   wtis https://github.com/mastra-ai/mastra/issues/6701
wtis() {
    if [[ $# -eq 0 ]]; then
        echo "Usage: wtis <issue-number> or wtis <issue-url>"
        echo "Examples:"
        echo "  wtis 6701"
        echo "  wtis https://github.com/mastra-ai/mastra/issues/6701"
        echo ""
        echo "Creates a new worktree with a branch to fix a GitHub issue"
        return 1
    fi
    
    local input="$1"
    local issue_number
    
    # Extract issue number from URL or use directly if it's just a number
    if [[ "$input" =~ ^[0-9]+$ ]]; then
        # Direct issue number
        issue_number="$input"
    elif [[ "$input" =~ github\.com/.*/issues/([0-9]+) ]]; then
        # GitHub issue URL - in zsh, captured groups are in the match array
        issue_number="${match[1]}"
    else
        echo "❌ Invalid input. Please provide an issue number or GitHub issue URL"
        return 1
    fi
    
    # Check if gh is installed
    if ! command -v gh &> /dev/null; then
        echo "❌ GitHub CLI (gh) is not installed"
        echo "Install it with: brew install gh"
        return 1
    fi
    
    echo "📋 Fetching issue #$issue_number info..."
    
    # Check if we're in a git repository
    if ! git status &>/dev/null; then
        echo "❌ Not in a git repository"
        return 1
    fi
    
    # Get repository info
    local repo_url=$(git remote get-url origin 2>/dev/null)
    if [[ -z "$repo_url" ]]; then
        echo "❌ Could not determine repository origin"
        return 1
    fi
    
    # Extract owner/repo from URL
    local repo_path=$(echo "$repo_url" | sed 's/.*github\.com[:/]\([^/]*\/[^/]*\)\.git.*/\1/')
    echo "Repository: $repo_path"
    
    # Fetch issue details
    local issue_info
    if ! issue_info=$(gh issue view "$issue_number" --repo "$repo_path" --json number,title,state 2>/dev/null); then
        echo "❌ Failed to fetch issue #$issue_number from $repo_path"
        echo "💡 Try running: gh issue view $issue_number --repo $repo_path"
        return 1
    fi
    
    # Parse issue details
    local issue_title=$(echo "$issue_info" | jq -r '.title')
    local issue_state=$(echo "$issue_info" | jq -r '.state')
    
    # Check if issue is open
    if [[ "$issue_state" != "OPEN" ]]; then
        echo "⚠️  Issue #$issue_number is $issue_state"
        echo "Title: $issue_title"
        echo "Do you still want to create a worktree for this issue? (y/N):"
        read -r confirm
        if [[ ! "$confirm" =~ ^[Yy]$ ]]; then
            echo "❌ Cancelled"
            return 1
        fi
    else
        echo "✅ Issue #$issue_number: $issue_title"
    fi
    
    # Slugify the title for branch name (lowercase, replace spaces and special chars with hyphens)
    local slugified_title=$(echo "$issue_title" | tr '[:upper:]' '[:lower:]' | sed 's/[^a-z0-9]/-/g' | sed 's/--*/-/g' | sed 's/^-//' | sed 's/-$//')
    
    # Truncate if too long (keep it under 50 chars for the title part)
    if [[ ${#slugified_title} -gt 50 ]]; then
        slugified_title="${slugified_title:0:50}"
        # Remove trailing hyphen if any
        slugified_title="${slugified_title%-}"
    fi
    
    # Create branch name
    local branch_name="fix/issue-${issue_number}-${slugified_title}"
    
    # Get the main repo name from the first worktree
    local main_repo_path=$(git worktree list | head -n1 | awk '{print $1}')
    local repo_name=$(basename "$main_repo_path")
    
    # Create folder name with hyphens instead of slashes
    local folder_name=$(echo "$branch_name" | sed 's|/|-|g')
    local worktree_path="../$repo_name--$folder_name"
    
    # Check if worktree already exists
    if [[ -d "$worktree_path" ]]; then
        echo "📁 Worktree already exists at $worktree_path"
        echo "🚀 Switching to existing worktree..."
        cd "$worktree_path" && pwd
        return 0
    fi
    
    echo "Creating worktree '$worktree_path' with branch '$branch_name' from main..."
    
    # Fetch the latest main branch before creating worktree
    echo "📥 Fetching latest main branch..."
    git fetch origin main:main
    
    # Create the worktree with new branch from main
    if git worktree add -b "$branch_name" "$worktree_path" main; then
        echo "✅ Successfully created worktree at $worktree_path"
        echo "🔧 Issue: #$issue_number - $issue_title"
        echo "🌿 Branch: $branch_name"
        echo "📁 Folder: $worktree_path"
        
        cd "$worktree_path"
        
        # Optional: Link the branch to the issue using gh
        echo "🔗 Linking branch to issue #$issue_number..."
        gh issue develop "$issue_number" --name "$branch_name" --repo "$repo_path" 2>/dev/null || echo "ℹ️  Branch linking is optional, continuing..."
        
        echo "✅ Ready to fix issue #$issue_number!"
    else
        echo "❌ Failed to create worktree"
        return 1
    fi
}

# fzf
source /opt/local/share/fzf/shell/key-bindings.zsh
source /opt/local/share/fzf/shell/completion.zsh

source "$HOME/fzf-git.sh"

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
