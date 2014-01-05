PROMPT='
%{$fg[green]%}%n%{$fg[blue]%}%{$reset_color%} in %{$fg[blue]%}%{$fg[red]%}%~ %{$reset_color%}at %{$fg[cyan]%}%m$(git_prompt)$(vi_prompt)
%{$fg_bold[cyan]%}%(!.#.>)%{$reset_color%} '

stty -ixon

## EXPORTS ##
export GREP_OPTIONS='--color=always'
export HISTFILE=$HOME/.zhistory
export HISTSIZE=50000
export KEYTIMEOUT=1
export LESS='-R'
export PATH=.:~/bin:$PATH
export SAVEHIST=10000
export ZLS_COLORS=$LS_COLORS
export PAGER="/bin/sh -c \"                         \
    col -b -x | vim -R                              \
    -c 'set ft=man noma nomod nolist nonu nornu'    \
    -c 'noremap q :q<CR>'                           \
    -c 'noremap d <C-D>'                            \
    -c 'noremap <SPACE> <C-D>'                      \
    -c 'noremap u <C-U>'                            \
    -c 'noremap b <C-U>'                            \
    -\""

autoload -U colors && colors
autoload -U compinit && compinit

## OPTS ##
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
alias gdt="git difftool"
alias gdc="git diff --cached"
alias gdtc="git difftool --cached"
alias gf="git fetch"
alias gl="git l"
alias gm="git merge"
alias gp="git push"
alias gr="git rm"
alias gs="git status"
alias l="ls -lh"
alias ll="l -A"
alias ls=" ls --color=auto"
alias dades_mount="mount ~/Raco/dades"
alias dades_umount="umount.davfs ~/Raco/dades"
alias assig_mount="mount ~/Raco/assig"
alias assig_umount="umount.davfs ~/Raco/assig"
alias pmount="udisks --mount"
alias pumount="umount"
alias pacman="pacman --color=always"
alias pacupg="sudo pacman -Syu"
alias pacin="sudo pacman -S"
alias pacre="sudo pacman -Rns"
alias pacro="pacman -Qtd > /dev/null && sudo pacman -Rns \$(pacman -Qtdq | sed -e ':a;N;\$!ba;s/\n/ /g')" # Erase orphaned packages
alias pacse="pacman -Ss"
alias vimrc="vim ~/.vimrc"
alias zshrc="vim ~/.zshrc"

## FUNCTIONS ##
insert-sudo() {
    sudo="sudo "
    BUFFER="$sudo$BUFFER"
    CURSOR=$(expr $CURSOR + $(expr length $sudo))
}
zle -N insert-sudo

extract () {
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2)
                tar xvjf $1
                ;;
            *.tar.gz)
                tar xvzf $1
                ;;
            *.bz2)
                bunzip2 $1
                ;;
            *.rar)
                unrar x $1
                ;;
            *.gz)
                gunzip $1
                ;;
            *.tar)
                tar xvf $1
                ;;
            *.tbz2)
                tar xvjf $1
                ;;
            *.tgz)
                tar xvzf $1
                ;;
            *.zip)
                unzip $1
                ;;
            *.Z)
                uncompress $1
                ;;
            *.7z)
                7z x $1
                ;;
            *)
                echo "don't know how to extract '$1'..." ;;
        esac
    else
        echo "'$1' is not a valid file!"
    fi
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
