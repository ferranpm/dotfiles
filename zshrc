PROMPT='
%{$fg[green]%}%n%{$fg[blue]%}%{$reset_color%} in %{$fg[blue]%}%{$fg[red]%}%~ %{$reset_color%}at %{$fg[cyan]%}%m$(git_prompt)$(vi_prompt)
%{$fg_bold[cyan]%}%(!.#.>)%{$reset_color%} '

export GREP_OPTIONS='--color=always'
export HISTFILE=$HOME/.zhistory
export HISTSIZE=50000
export KEYTIMEOUT=1
export LESS='-R'
export PATH=~/bin/:~/.gem/ruby/2.0.0/bin:$PATH
export SAVEHIST=10000
export ZLS_COLORS=$LS_COLORS

stty -ixon

autoload -U colors && colors
autoload -U compinit && compinit

setopt APPEND_HISTORY
setopt AUTO_CD
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

## ZSTYLE ##
zstyle ':completion:*' list-colors ""
zstyle ':completion:*' menu "select"
zstyle ':completion:*' verbose "yes"
zstyle ':completion:*:*:kill:*:processes' command "ps -u `whoami` -o pid,comm"

## BINDKEYS ##
bindkey -v '^f' history-incremental-pattern-search-backward
bindkey -a '/' history-incremental-pattern-search-backward
bindkey -a '?' history-incremental-pattern-search-forward
bindkey -a 'n' down-line-or-search
bindkey -a 'p' up-line-or-search
bindkey -v '^[[3~' delete-char
bindkey -a '^[[3~' delete-char
bindkey -v '^[[7~' beginning-of-line
bindkey -a '^[[7~' beginning-of-line
bindkey -v '^[[8~' end-of-line
bindkey -a '^[[8~' end-of-line
bindkey -v '^[[Z' reverse-menu-complete
bindkey -v '^k' kill-buffer
bindkey -v '^m' check-line
bindkey -a '^m' check-line
bindkey -v '^n' down-line-or-search
bindkey -a 'j' down-line-or-search
bindkey -v '^p' up-line-or-search
bindkey -a 'k' up-line-or-search
bindkey -v '^s' insert-sudo

## ALIASES ##
alias ack="ack --color"
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
alias mdades="mount ~/Raco/dades"
alias udades="umount.davfs ~/Raco/dades"
alias massig="mount ~/Raco/assig"
alias uassig="umount.davfs ~/Raco/assig"
alias pmount="udisks --mount"
alias pumount="umount"
alias pacman="pacman --color=always"
alias pacupg="sudo pacman -Syu"
alias pacin="sudo pacman -S"
alias pacre="sudo pacman -Rns"
alias pacro="pacman -Qtd > /dev/null && sudo pacman -Rns \$(pacman -Qtdq | sed -e ':a;N;\$!ba;s/\n/ /g')" # Erase orphaned packages
alias pacse="pacman -Ss"

## FUNCTIONS ##
insert-sudo() {
    sudo="sudo "
    BUFFER="$sudo$BUFFER"
    CURSOR=$(expr $CURSOR + $(expr length $sudo))
}
zle -N insert-sudo

extract() {
    file=$1
    filename=$(basename "$file")
    extension="${filename##*.}"
    echo "extracting: $extension"
    case $extension in
        'zip')
            unzip $file
            ;;
        'gz')
            tar -xzvf $file
            ;;
    esac
}

check-line() {
    if [ "$BUFFER" = "" ]; then
        return
    fi
    zle accept-line
}
zle -N check-line

# VI
zle-keymap-select() {
    zle reset-prompt
}
zle -N zle-keymap-select

vi_prompt() {
    INDICATOR=" %{$reset_color%}[$fg[magenta]X%{$reset_color%}]"
    if [ "$KEYMAP" = "vicmd" ]; then
        echo $INDICATOR
    fi
}

# GIT
git_prompt() {
    if git rev-parse --git-dir >/dev/null 2>&1; then
        ref=$(git symbolic-ref HEAD 2>/dev/null || git name-rev --name-only --no-undefined --always HEAD)
        ref=${ref#refs/heads/}
        echo " %{$reset_color%}[%{$fg[yellow]%}$ref%{$reset_color%}]"
    fi
}
