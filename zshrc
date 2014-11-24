PROMPT='
%{$fg[green]%}%n%{$fg[blue]%}%{$reset_color%} in %{$fg[blue]%}%{$fg[red]%}%~ %{$reset_color%}at %{$fg[cyan]%}%m$(git_prompt)$(vi_prompt)
%{$fg_bold[cyan]%}%(!.#.»)%{$reset_color%} '

ZSH_FOLDER=$HOME/.zsh
if [[ -d $ZSH_FOLDER ]]; then
    for file in $(find $ZSH_FOLDER -name "*.plugin.zsh"); do
        source $file
    done
fi

stty -ixon

## EXPORTS ##
export COLORFGBG="15;0"
export EDITOR="vim"
export GREP_OPTIONS='--color=auto'
export HISTFILE=$HOME/.zshhistory
export HISTSIZE=50000
export KEYTIMEOUT=1
export LESS='-R'
export NEOVIM_LISTEN_ADDRESS="/tmp/neovim$$"
export PATH=$HOME/bin:$HOME/.gem/ruby/2.1.0/bin:$PATH
export SAVEHIST=10000
export ZLS_COLORS=$LS_COLORS

autoload -U colors && colors
autoload -U compinit && compinit -d $HOME/.zshcompdump

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
setopt INC_APPEND_HISTORY
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
bindkey -v '^[[1;5D' backward-word
bindkey -v '^[[1;5C' forward-word
bindkey -v '^[[1;5D' backward-word
bindkey -v '^[[7~'  beginning-of-line
bindkey -a '^[[7~'  beginning-of-line
bindkey -v '^m'     check-line
bindkey -a '^m'     check-line
bindkey -v '^[[3~'  delete-char
bindkey -a '^[[3~'  delete-char
bindkey -v '^[[B'   down-line-or-history
bindkey -a 'n'      down-line-or-search
bindkey -v '^n'     down-line-or-search
bindkey -a 'j'      down-line-or-search
bindkey -v '^[[8~'  end-of-line
bindkey -a '^[[8~'  end-of-line
bindkey -v '^f'     history-incremental-pattern-search-backward
bindkey -a '/'      history-incremental-pattern-search-backward
bindkey -a '?'      history-incremental-pattern-search-forward
bindkey -v '^s'     insert-sudo
bindkey -v '^k'     kill-buffer
bindkey -v '^[[Z'   reverse-menu-complete
bindkey -v '^[[A'   up-line-or-history
bindkey -a 'p'      up-line-or-search
bindkey -v '^p'     up-line-or-search
bindkey -a 'k'      up-line-or-search
bindkey -v '^[^W'   set-background-light
bindkey -a '^[^W'   set-background-light
bindkey -v '^[^B'   set-background-dark
bindkey -a '^[^B'   set-background-dark

## ALIASES ##
alias ack="ack --color"
alias cal="cal -3 -m"
alias cd=" cd"
alias cd1="cd ../"
alias cd2="cd ../../"
alias cd3="cd ../../../"
alias cd4="cd ../../../../"
alias diff="diff -yEbwB --suppress-common-lines"
alias g="git"
alias gwatch="while inotifywait -q -e access .git/; do clear; git lo 2>/dev/null | head; done"
alias l="ls -lh"
alias ll="l -A"
alias ls=" ls --color=auto"
alias mountc="mount | column -t"
alias dades_mount="mount $HOME/Raco/dades"
alias dades_umount="umount.davfs $HOME/Raco/dades"
alias assig_mount="mount $HOME/Raco/assig"
alias assig_umount="umount.davfs $HOME/Raco/assig"
alias pmount="udisksctl mount -b"
alias pumount="umount"
alias pacman="pacman --color=auto"
alias pacupg="sudo pacman -Syu"
alias pacin="sudo pacman -S"
alias pacre="sudo pacman -Rns"
alias pacro="pacman -Qtd > /dev/null && sudo pacman -Rns \$(pacman -Qtdq | sed -e ':a;N;\$!ba;s/\n/ /g')" # Erase orphaned packages
alias pacse="pacman -Ss"
alias scan='iwlist wlan0 scanning | grep "ESSID" | sed -e "s/\ *ESSID:\"\(.*\)\"/\1/"'
alias e="$EDITOR"
alias TODO="e $HOME/TODO"
alias vimrc="e $HOME/.vimrc"
alias zshrc="e $HOME/.zshrc"

## FUNCTIONS ##
insert-sudo() {
    sudo="sudo "
    BUFFER="$sudo$BUFFER"
    CURSOR=$(expr $CURSOR + $(expr length $sudo))
}
zle -N insert-sudo


function set-background-light() {
    COLORFGBG="0;15"
    echo -n "\033]10;#0F0F0F\007\033]11;#FFFFFF\007\033]12;#ff8939\007\033]4;0;#2B2B2B\007\033]4;8;#404040\007\033]4;1;#E84F4F\007\033]4;9;#D23D3D\007\033]4;2;#78964C\007\033]4;10;#A0CF5D\007\033]4;3;#E1AA5D\007\033]4;11;#F39D21\007\033]4;4;#7DC1CF\007\033]4;12;#4E9FB1\007\033]4;5;#9B64FB\007\033]4;13;#8542FF\007\033]4;6;#6D878D\007\033]4;14;#42717B\007\033]4;7;#dddddd\007\033]4;15;#dddddd\007"
}
zle -N set-background-light

function set-background-dark() {
    COLORFGBG="15;0"
    echo -n "\033]10;#DADADA\007\033]11;#111111\007\033]12;#ff8939\007\033]4;0;#2B2B2B\007\033]4;8;#404040\007\033]4;1;#E84F4F\007\033]4;9;#D23D3D\007\033]4;2;#B8D68C\007\033]4;10;#A0CF5D\007\033]4;3;#E1AA5D\007\033]4;11;#F39D21\007\033]4;4;#7DC1CF\007\033]4;12;#4E9FB1\007\033]4;5;#9B64FB\007\033]4;13;#8542FF\007\033]4;6;#6D878D\007\033]4;14;#42717B\007\033]4;7;#dddddd\007\033]4;15;#dddddd\007"
}
zle -N set-background-dark

extract () {
    for f in $*; do
        if [ -f $f ] ; then
            case $f in
                *.tar.bz2) tar xvjf $f ;;
                *.tar.gz) tar xvzf $f ;;
                *.bz2) bunzip2 $f ;;
                *.rar) unrar x $f ;;
                *.gz) gunzip $f ;;
                *.tar) tar xvf $f ;;
                *.tbz2) tar xvjf $f ;;
                *.tgz) tar xvzf $f ;;
                *.zip) unzip $f ;;
                *.Z) uncompress $f ;;
                *.7z) 7z x $f ;;
                *) echo "don't know how to extract '$f'..." ;;
            esac
        else
            echo "'$f' is not a valid file!"
        fi
    done
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

rm_tr_white () {
    find . -not \( -name .svn -prune -o -name .git -prune -o -name '*.a' \) -type f -print0 | xargs -0 sed -i -e "s/[[:space:]]*$//"
}
