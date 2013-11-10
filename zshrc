PROMPT='
%{$fg[green]%}%n%{$fg[blue]%}%{$reset_color%} in %{$fg[blue]%}%{$fg[red]%}%~ %{$reset_color%}at %{$fg[cyan]%}%m$(git_prompt)$(vi_prompt)
%{$fg_bold[cyan]%}%(!.#.>)%{$reset_color%} '

autoload -U colors && colors
autoload -U compinit
compinit

stty -ixon
setopt append_history 
setopt extended_glob
setopt hist_ignore_all_dups
setopt hist_ignore_dups
setopt hist_reduce_blanks
setopt hist_verify
setopt noflowcontrol  # Turn off terminal driver flow control (CTRL+S/CTRL+Q)
setopt prompt_subst   # substitute params in prompt

## VARIABLES ##
HISTFILE=$HOME/.zsh_history
ZLS_COLORS=$LS_COLORS
HISTSIZE=50000
SAVEHIST=10000
KEYTIMEOUT=1

## EXPORTS ##
export PATH=~/bin/:~/.gem/ruby/2.0.0/bin:$PATH
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
alias pmount="udisks --mount"
alias pumount="umount"
alias rss="newsbeuter -r"
alias pacman="pacman --color=always"
alias pacupg="sudo pacman -Syu"
alias pacin="sudo pacman -S"
alias pacre="sudo pacman -Rns"
alias pacro="sudo pacman -Qtdq > /dev/null && sudo pacman -Rns \$(pacman -Qtdq | sed -e ':a;N;\$!ba;s/\n/ /g')" # Erase orphaned packages
alias pacse="pacman -Ss"

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
