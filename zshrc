PROMPT='
%{$fg[green]%}%n%{$fg[blue]%}%{$reset_color%} in %{$fg[blue]%}%{$fg[red]%}%~ %{$reset_color%}at %{$fg[cyan]%}%m$(git_prompt)$(vi_prompt)
%{$fg_bold[cyan]%}%(!.#.>)%{$reset_color%} '

stty -ixon

autoload -U colors && colors
autoload -U compinit && compinit

setopt APPEND_HISTORY
setopt AUTO_PUSHD
setopt EXTENDED_GLOB
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_REDUCE_BLANKS
setopt HIST_VERIFY
setopt NO_FLOW_CONTROL
setopt PROMPT_SUBST
setopt PUSHD_IGNORE_DUPS
setopt PUSHD_MINUS
setopt PUSHD_SILENT
setopt PUSHD_TOHOME
setopt VI

## VARIABLES ##
DIRSTACKFILE=~/.zsh_dirs
DIRSTACKSIZE=8
HISTFILE=$HOME/.zsh_history
HISTSIZE=50000
KEYTIMEOUT=1
SAVEHIST=10000
ZLS_COLORS=$LS_COLORS

## EXPORTS ##
export EDITOR=/usr/bin/vim
export GREP_OPTIONS='--color=always'
export LESS='-R'
export PAGER=/usr/bin/less
export PATH=~/bin/:~/.gem/ruby/2.0.0/bin:$PATH
export SHELL=/usr/bin/zsh

## ZSTYLE ##
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' users off
zstyle ':completion:*' verbose yes
zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*:*:*:*:processes' command "ps -u `whoami` -o pid,user,comm -w -w"
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'
zstyle ':completion:*:cd:*' tag-order local-directories directory-stack path-directories
zstyle ':completion:*:hosts' hosts $hosts

## BINDKEYS ##
bindkey '^F' history-incremental-search-backward
bindkey '^N' down-line-or-search
bindkey '^P' up-line-or-search
bindkey '^S' insert-sudo
bindkey '^[[2~' delete-char
bindkey '^[[3~' delete-char
bindkey '^[[7~' beginning-of-line
bindkey '^[[8~' end-of-line
bindkey '^[[Z' reverse-menu-complete
bindkey -M vicmd '/' history-incremental-search-backward

## ALIASES ##
alias cal="cal -3"
alias cd=" cd"
alias diff="diff -yEbwB --suppress-common-lines"
alias g="git"
alias ga="git add"
alias gap="git add -p"
alias gc="git commit"
alias gd="git diff"
alias gdc="git diff --cached"
alias gf="git fetch"
alias gl="git l"
alias gm="git merge"
alias gp="git push"
alias gr="git rm"
alias gs="git status"
alias l="ls -lh"
alias ll="l -A"
alias ls=" ls --color=auto"
alias pmount="udisks --mount"
alias pumount="umount"
alias rss="newsbeuter -r"
alias pacman="pacman --color=always"
alias pacupg="sudo pacman -Syu"
alias pacin="sudo pacman -S"
alias pacre="sudo pacman -Rns"
alias pacro="sudo pacman -Qtdq > /dev/null && sudo pacman -Rns \$(pacman -Qtdq | sed -e ':a;N;\$!ba;s/\n/ /g')" # Erase orphaned packages
alias pacse="pacman -Ss"

## SNIPPETS ##
if [[ -f $DIRSTACKFILE ]] && [[ $#dirstack -eq 0 ]]; then
    dirstack=( ${(f)"$(< $DIRSTACKFILE)"} )
    [[ -d $dirstack[1] ]] && cd $dirstack[1] && cd $OLDPWD
fi

## FUNCTIONS ##
insert-sudo() {
    zle beginning-of-line;
    zle -U "sudo ";
}
zle -N insert-sudo

# VI
zle-keymap-select() {
    zle reset-prompt
}
zle -N zle-keymap-select

vi_prompt() {
    INDICATOR="%{$reset_color%}[$fg[magenta]X%{$reset_color%}]"
    echo " ${${KEYMAP/vicmd/$INDICATOR}/(main|viins)/}"
}

# GIT
git_prompt() {
    if git rev-parse --git-dir >/dev/null 2>&1; then
        ref=$(git symbolic-ref HEAD 2>/dev/null || git name-rev --name-only --no-undefined --always HEAD)
        ref=${ref#refs/heads/}
        echo " %{$reset_color%}[%{$fg[yellow]%}$ref%{$reset_color%}]"
    fi
}
