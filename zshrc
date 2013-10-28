PROMPT='
%{$fg[green]%}%n%{$fg[blue]%}%{$reset_color%} in %{$fg[blue]%}%{$fg[red]%}%~ %{$reset_color%}at %{$fg[cyan]%}%m$(git_prompt)$(vi_prompt)
%{$fg_bold[cyan]%}%(!.#.>)%{$reset_color%} '

autoload -U colors && colors
autoload -U compinit
compinit

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
HISTFILE=$HOME/.zsh_history
ZLS_COLORS=$LS_COLORS
HISTSIZE=50000
SAVEHIST=10000
KEYTIMEOUT=1

## EXPORTS ##
export PATH=~/bin/:$PATH
export SHELL=/usr/bin/zsh
export EDITOR=/usr/bin/vim
export PAGER=/usr/bin/less
export GREP_OPTIONS='--color=always'
export LESS='-R'

## ZSTYLE ##
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' verbose yes
zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'
zstyle ':completion:*:*:*:*:processes' command "ps -u `whoami` -o pid,user,comm -w -w"
zstyle ':completion:*:cd:*' tag-order local-directories directory-stack path-directories
zstyle ':completion:*:hosts' hosts $hosts
zstyle ':completion:*' users off
zstyle ':completion:*:cd:*' tag-order local-directories directory-stack path-directories

## BINDKEYS ##
bindkey -v
bindkey -M vicmd '/' history-incremental-search-backward
bindkey '^F' history-incremental-search-backward
bindkey '^N' down-line-or-search
bindkey '^P' up-line-or-search
bindkey '^S' insert-sudo
bindkey '^[[2~' delete-char
bindkey '^[[3~' delete-char
bindkey '^[[7~' beginning-of-line
bindkey '^[[8~' end-of-line
bindkey '^[[Z' reverse-menu-complete

## ALIASES ##
alias cal="cal -3"
alias diff="diff -yEbwB --suppress-common-lines"
alias g="git"
alias ga="git add"
alias gc="git commit"
alias gd="git diff"
alias gf="git fetch"
alias gl="git l"
alias gm="git merge"
alias gp="git push"
alias gr="git rm"
alias gs="git status"
alias l="ls -lh"
alias ll="l -A"
alias ls="ls --color=auto"
alias rss="newsbeuter -r"
alias vimpc="mpd ; vimpc"
if [[ -x /usr/bin/pacman ]]; then
	alias pacman="pacman --color=always"
	alias pacupg="sudo pacman -Syu"
	alias pacin="sudo pacman -S"
	alias pacre="sudo pacman -Rns"
	alias pacro="sudo pacman -Qtdq > /dev/null && sudo pacman -Rns \$(pacman -Qtdq | sed -e ':a;N;\$!ba;s/\n/ /g')" # Erase orphaned packages
	alias pacse="pacman -Ss"
elif [[ -x /usr/bin/aptitude ]]; then
	alias aptupg="sudo apt-get update && sudo apt-get upgrade"
	alias aptin="sudo apt-get install"
	alias aptre="sudo apt-get remove --purge"
	alias aptse="aptitude search"
fi

## FUNCTIONS ##
function insert-sudo() {
	zle beginning-of-line;
	zle -U "sudo ";
}
zle -N insert-sudo

# VI
function zle-line-init zle-line-finish zle-keymap-select() {
	zle reset-prompt
	zle -R
}
zle -N zle-line-init
zle -N zle-line-finish
zle -N zle-keymap-select

function vi_prompt() {
	INDICATOR="%{$reset_color%}[$fg[magenta]X%{$reset_color%}]"
	echo " ${${KEYMAP/vicmd/$INDICATOR}/(main|viins)/}"
}

# GIT
function git_prompt() {
	if git rev-parse --git-dir >/dev/null 2>&1; then
		ref=$(git symbolic-ref HEAD 2>/dev/null || git name-rev --name-only --no-undefined --always HEAD)
		ref=${ref#refs/heads/}
		# if ! git diff-index --quiet HEAD 2>/dev/null; then
		#   ref="$ref %{$fg[cyan]%}*"
		# fi
		echo " %{$reset_color%}[%{$fg[yellow]%}$ref%{$reset_color%}]"
	fi
}
