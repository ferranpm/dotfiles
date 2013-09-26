PROMPT='
%{$fg[green]%}%n%{$fg[blue]%}@%{$fg[cyan]%}%m%{$fg[blue]%}:%{$fg[yellow]%}%~$(git_prompt)$(vi_prompt)
%{$fg_bold[cyan]%}>%{$reset_color%} '

## FUNCTIONS ##
insert_sudo() {
	zle beginning-of-line;
	zle -U "sudo ";
}
zle -N insert-sudo insert_sudo

## VI PLUGIN
# Ensures that $terminfo values are valid and updates editor information when
# the keymap changes.
zle-line-init()
zle-line-finish() 
zle-keymap-select() {
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

# if mode indicator wasn't setup by theme, define default
if [[ "$MODE_INDICATOR" == "" ]]; then
	MODE_INDICATOR=" %{$reset_color%}[%{$fg[blue]%}><%{$reset_color%}]"
fi
function vi_prompt() {
echo "${${KEYMAP/vicmd/$MODE_INDICATOR}/(main|viins)/}"
}

# GIT PLUGIN
git_prompt() {
	if git rev-parse --git-dir >/dev/null 2>&1; then
		ref=$(git symbolic-ref HEAD 2>/dev/null || git name-rev --name-only --no-undefined --always HEAD)
		ref=${ref#refs/heads/}
		# if ! git diff-index --quiet HEAD 2>/dev/null; then
		#   ref="$ref %{$fg[cyan]%}*"
		# fi
		echo " %{$reset_color%}[%{$fg[red]%}$ref%{$reset_color%}]"
	fi
}

autoload -U colors && colors
autoload -U compinit promptinit zcalc zsh-mime-setup
compinit
promptinit
zsh-mime-setup

stty -ixon
setopt prompt_subst   # substitute params in prompt
setopt noflowcontrol  # Turn off terminal driver flow control (CTRL+S/CTRL+Q)
setopt APPEND_HISTORY 
setopt SHARE_HISTORY 
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_REDUCE_BLANKS
setopt HIST_VERIFY

## VARIABLES ##
ZSH=$HOME/.zsh
PLUGINS=$ZSH/plugins
ALIASES=$ZSH/aliases
HISTFILE=$HOME/.zsh_history
HISTSIZE=50000
SAVEHIST=10000
ZLS_COLORS=$LS_COLORS

## EXPORTS ##
export SHELL=/usr/bin/zsh
export EDITOR=/usr/bin/vim
export PAGER=/usr/bin/less
export GREP_OPTIONS='--color=auto'
export LESS='-R'

## ZSTYLE ##
# zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' verbose yes
zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'
zstyle ':completion:*:*:*:*:processes' command "ps -u `whoami` -o pid,user,comm -w -w"
zstyle ':completion:*:cd:*' tag-order local-directories directory-stack path-directories
zstyle ':completion:*:hosts' hosts $hosts
zstyle ':completion:*' users off
zstyle ':completion::complete:*' use-cache 1
zstyle ':completion::complete:*' cache-path $ZSH/cache/
zstyle ':completion:*:cd:*' tag-order local-directories directory-stack path-directories

## BINDKEYS ##
bindkey -v
bindkey '^P' up-line-or-search
bindkey '^N' down-line-or-search
bindkey -M vicmd "/" history-incremental-search-backward
bindkey -M vicmd "?" history-incremental-search-forward
bindkey -M vicmd "q" push-line
bindkey '^[[Z' reverse-menu-complete
bindkey '^?' backward-delete-char
bindkey '^[[3~' delete-char
bindkey '^[[1;5C' forward-word
bindkey '^[[1;5D' backward-word
bindkey '^S' insert-sudo

## ALIASES ##
alias cal="cal -3"
alias rss="newsbeuter -r"
alias diff="diff -yEbwB --suppress-common-lines"
alias g="git"
alias gd="git diff"
alias gf="git fetch"
alias gm="git merge"
alias gp="git push"
alias gc="git commit"
alias ga="git add"
alias gr="git rm"
alias gl="git log"
alias gs="git status"
if [[ -x =pacman ]]; then
	alias pacupg="sudo pacman -Syu"
	alias pacin="sudo pacman -S"
	alias pacre="sudo pacman -Rns"
	alias pacse="pacsearch"
elif [[ -x =aptitude ]]; then
	alias aptupg="sudo apt-get update && sudo apt-get upgrade"
	alias aptin="sudo apt-get install"
	alias aptre="sudo apt-get remove --purge"
	alias aptse="aptitude search"
fi
alias ls="ls --color=auto"
alias l="ls -lh"
alias ll="l -A"
