# Macports
export PATH=/opt/local/bin:/opt/local/sbin:$PATH

# Add NPM token
export NPM_TOKEN="grep registry.npmjs.org/:_authToken ~/.npmrc | cut -d = -f 2"
# Add GitHub token
export GITHUB_TOKEN="XXX"

# fpath changes
fpath+=${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions/src

# enable color support of ls and also add handy aliases
# GNU tools from MacPorts, to install run:
# sudo port install coreutils +with_default_names
if [ -x /opt/local/libexec/gnubin/dircolors ]; then
  alias dircolors=/opt/local/libexec/gnubin/dircolors
fi

# Macports
export PATH=/opt/local/bin:/opt/local/sbin:$PATH

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Default editor
export REACT_EDITOR="code"

DEFAULT_USER="whoami"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="spaceship"

# Spaceship Settings
SPACESHIP_GCLOUD_SHOW=false
SPACESHIP_DIR_TRUNC=2

# Colors
SPACESHIP_CHAR_COLOR_SUCCESS=32
SPACESHIP_CHAR_COLORS_FAILURE=31
SPACESHIP_CHAR_COLOR_SECONDARY=33
SPACESHIP_TIME_COLOR=33
SPACESHIP_USER_COLORS=33
SPACESHIP_USER_COLOR_ROOT=31
SPACESHIP_HOST_COLOR=34
SPACESHIP_HOST_COLOR_SSH=32
SPACESHIP_DIR_COLOR=36
SPACESHIP_DIR_LOCK_COLOR=31
SPACESHIP_GIT_BRANCH_COLOR=35
SPACESHIP_GIT_STATUS_COLOR=31
SPACESHIP_PACKAGE_COLOR=31
SPACESHIP_NODE_COLOR=32

# Edit the default prompt to save time
SPACESHIP_PROMPT_ORDER=(
  time          # Time stamps section
  user          # Username section
  dir           # Current directory section
  host          # Hostname section
  git           # Git section (git_branch + git_status)
  hg            # Mercurial section (hg_branch  + hg_status)
  package       # Package version
  node          # Node.js section
  # ruby          # Ruby section
  # elixir        # Elixir section
  # xcode         # Xcode section
  # swift         # Swift section
  # golang        # Go section
  # php           # PHP section
  rust          # Rust section
  # haskell       # Haskell Stack section
  # julia         # Julia section
  docker        # Docker section
  # aws           # Amazon Web Services section
  # gcloud        # Google Cloud Platform section
  # conda         # conda virtualenv section
  # dotnet        # .NET section
  # ember         # Ember.js section
  # venv          # virtualenv section
  # pyenv         # Pyenv section
  # kubectl       # Kubectl context section
  # terraform     # Terraform workspace section
  exec_time     # Execution time
  line_sep      # Line break
  # battery       # Battery level and status
  # vi_mode       # Vi-mode indicator
  jobs          # Background jobs indicator
  exit_code     # Exit code section
  char          # Prompt character
)

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
plugins=(git zsh-autosuggestions virtualenv yarn zsh-syntax-highlighting zsh-dircolors-solarized history gh rust ohmyzsh-full-autoupdate zsh-tab-title)

source $ZSH/oh-my-zsh.sh

# Init nvm - Should be last!
source /opt/local/share/nvm/init-nvm.sh

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

## exa
alias ls="exa" # ls
alias ll='exa -lbF --git' # list, size, type, git
alias llm='exa -lbGd --git --sort=modified' # long list, modified date sort
alias la='exa -lbhHigUmuSa --time-style=long-iso --git --color-scale' # all list
alias lx='exa -lbhHigUmuSa@ --time-style=long-iso --git --color-scale' # all + extended list
alias lS='exa -1' # one column, just names
alias lt='exa --tree --level=2' # tree

# Other functions
search() { grep -rHn -C 1 "$1" *; }
shorten() { node /Users/lejoe/code/github/shortener/node_modules/.bin/netlify-shortener "$1" "$2"; }
mkfile() { mkdir -p -- "$1" && touch -- "$1"/"$2" }

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
