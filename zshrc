PROMPT='
%{$fg[green]%}%n%{$fg[blue]%}@%{$fg[cyan]%}%m%{$fg[blue]%}:%{$fg[yellow]%}%~$(git_prompt)$(vi_prompt)
%{$fg_bold[cyan]%}>%{$reset_color%} '

autoload -U colors && colors
autoload -U compinit && compinit

setopt prompt_subst   # substitute params in prompt
setopt noflowcontrol  # Turn off terminal driver flow control (CTRL+S/CTRL+Q)

############
## ZSTYLE ##
############
# zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' list-colors ''
zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'
zstyle ':completion:*:*:*:*:processes' command "ps -u `whoami` -o pid,user,comm -w -w"
zstyle ':completion:*:cd:*' tag-order local-directories directory-stack path-directories
zstyle ':completion:*:hosts' hosts $hosts
zstyle ':completion:*' users off
zstyle ':completion::complete:*' use-cache 1
zstyle ':completion::complete:*' cache-path $ZSH/cache/
zstyle ':completion:*:cd:*' tag-order local-directories directory-stack path-directories

##############
## BINDKEYS ##
##############
bindkey -v
bindkey '^P' up-line-or-search
bindkey '^N' down-line-or-search
bindkey '^S' history-incremental-search-backward
bindkey '^[[Z' reverse-menu-complete
bindkey '^?' backward-delete-char
bindkey '^[[3~' delete-char
bindkey '^[[1;5C' forward-word
bindkey '^[[1;5D' backward-word

###############
## VARIABLES ##
###############
HISTFILE=$HOME/.zsh_history
HISTSIZE=50000
SAVEHIST=10000
ZLS_COLORS=$LS_COLORS

#############
## EXPORTS ##
#############
export SHELL=/usr/bin/zsh
export ZSH=$HOME/.zsh
export EDITOR=/usr/bin/vim
export PAGER=/usr/bin/less
export GREP_OPTIONS='--color=auto'

#############
## ALIASES ##
#############
# ls
alias ls="ls --color=auto"
alias l="ls -lh"
alias ll="l -A"

# Pacman
alias pacupg="sudo pacman -Syu"
alias pacin="sudo pacman -S"
alias pacre="sudo pacman -Rns"
alias pacse="pacsearch"

# git
alias gst="git status"
alias gd="git diff"
alias gc="git commit"
alias ga="git add"

# misc
alias cal="cal -3"
alias rss="newsbeuter -r"
alias diff="diff -yEbwB --suppress-common-lines"

###############
## FUNCTIONS ##
###############

git_prompt() {
  if git rev-parse --git-dir >/dev/null 2>&1; then
    ref=$(git symbolic-ref HEAD 2>/dev/null || git name-rev --name-only --no-undefined --always HEAD)
    ref=${ref#refs/heads/}
    if ! git diff-index --quiet HEAD 2>/dev/null; then
      ref="$ref %{$fg[cyan]%}*"
    fi
    echo " %{$reset_color%}[%{$fg[red]%}$ref%{$reset_color%}]"
  fi
}

# Ensures that $terminfo values are valid and updates editor information when
# the keymap changes.
function zle-keymap-select zle-line-init zle-line-finish {
  # The terminal must be in application mode when ZLE is active for $terminfo
  # values to be valid.
  if (( ${+terminfo[smkx]} )); then
    printf '%s' ${terminfo[smkx]}
  fi
  if (( ${+terminfo[rmkx]} )); then
    printf '%s' ${terminfo[rmkx]}
  fi

  zle reset-prompt
  zle -R
}

zle -N zle-line-init
zle -N zle-line-finish
zle -N zle-keymap-select

function vi_prompt() {
  MODE_INDICATOR=" %{$reset_color%}[%{$fg[red]%}CMD%{$reset_color%}]"
  echo "${${KEYMAP/vicmd/$MODE_INDICATOR}/(main|viins)/}"
}
