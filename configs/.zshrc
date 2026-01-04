# Enable Powerlevel10k instant prompt (keep at top)
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to oh-my-zsh
export ZSH="$HOME/.oh-my-zsh"

# Theme
ZSH_THEME="powerlevel10k/powerlevel10k"

# Plugins
plugins=(
  git
  docker
  docker-compose
  kubectl
  fzf
  zsh-autosuggestions
  zsh-syntax-highlighting
  zsh-completions
)

source $ZSH/oh-my-zsh.sh

# ----- User Configuration -----

# Zoxide (smart cd)
eval "$(zoxide init zsh)"

# Editor
export EDITOR="nvim"
export VISUAL="nvim"

# Path additions
export PATH="$HOME/.local/bin:$PATH"

# ----- Aliases -----

# File listing (eza)
alias ls="eza --icons"
alias ll="eza -la --icons --git"
alias la="eza -a --icons"
alias lt="eza --tree --icons --level=2"
alias lta="eza --tree --icons --level=2 -a"

# File operations
alias cat="batcat"
alias fd="fdfind"

# TUI tools
alias lg="lazygit"
alias lzd="lazydocker"
alias zj="zellij"
alias y="yazi"

# Editor
alias vim="nvim"
alias v="nvim"

# Navigation (zoxide)
alias cd="z"
alias cdi="zi"  # interactive

# System
alias ports="sudo lsof -i -P -n | grep LISTEN"
alias myip="curl -s ifconfig.me"
alias reload="source ~/.zshrc"

# Docker shortcuts
alias dps="docker ps --format 'table {{.Names}}\t{{.Status}}\t{{.Ports}}'"
alias dlog="docker logs -f"
alias dex="docker exec -it"

# Git shortcuts (beyond oh-my-zsh)
alias glog="git log --oneline --graph --decorate -20"
alias gst="git status -sb"

# ----- Functions -----

# Create directory and cd into it
mkcd() {
  mkdir -p "$1" && cd "$1"
}

# Extract any archive
extract() {
  if [ -f "$1" ]; then
    case "$1" in
      *.tar.bz2) tar xjf "$1" ;;
      *.tar.gz)  tar xzf "$1" ;;
      *.tar.xz)  tar xJf "$1" ;;
      *.bz2)     bunzip2 "$1" ;;
      *.gz)      gunzip "$1" ;;
      *.tar)     tar xf "$1" ;;
      *.tbz2)    tar xjf "$1" ;;
      *.tgz)     tar xzf "$1" ;;
      *.zip)     unzip "$1" ;;
      *.7z)      7z x "$1" ;;
      *)         echo "'$1' cannot be extracted" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

# Yazi with cd on exit
function yy() {
  local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
  yazi "$@" --cwd-file="$tmp"
  if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
    cd -- "$cwd"
  fi
  rm -f -- "$tmp"
}

# ----- History -----
HISTSIZE=50000
SAVEHIST=50000
HISTFILE=~/.zsh_history
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_REDUCE_BLANKS

# ----- Completion -----
autoload -Uz compinit
compinit

# ----- Key bindings -----
bindkey '^[[A' history-substring-search-up 2>/dev/null || true
bindkey '^[[B' history-substring-search-down 2>/dev/null || true

# ----- Load Powerlevel10k config -----
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
