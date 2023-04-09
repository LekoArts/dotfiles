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
  # docker        # Docker section
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