PROMPT='
%{$fg[green]%}%n%{$fg[blue]%}%{$reset_color%} in %{$fg[blue]%}%{$fg[red]%}%~ %{$reset_color%}at %{$fg[blue]%}%m$(git_prompt)$(vi_prompt)
%{$fg_bold[blue]%}%(!.#.>)%{$reset_color%} '

fpath=(~/.zsh/completion $fpath)

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
export HISTFILE=$HOME/.zshhistory
export HISTSIZE=50000
export KEYTIMEOUT=1
export PATH=$HOME/bin:$PATH
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
zstyle ':completion:*'                              matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*'                              menu select false
zstyle ':completion:*'                              special-dirs ..
zstyle ':completion:*'                              verbose false
zstyle ':completion:*:*:-subscript-:*'              tag-order indexes parameters
zstyle ':completion:*:*:zcompile:*'                 ignored-patterns '(*~|*.zwc)'
zstyle ':completion:*:-command-:*:'                 verbose false
zstyle ':completion:*:approximate:'                 max-errors 'reply=( $((($#PREFIX+$#SUFFIX)/3 )) numeric )'
zstyle ':completion:*:complete:-command-::commands' ignored-patterns '(aptitude-*|*\~)'
zstyle ':completion:*:correct:*'                    insert-unambiguous true
zstyle ':completion:*:correct:*'                    original true
zstyle ':completion:*:corrections'                  format $'%{\e[0;31m%}%d (errors: %e)%{\e[0m%}'
zstyle ':completion:*:default'                      list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:descriptions'                 format $'%{\e[0;31m%}completing %B%d%b%{\e[0m%}'
zstyle ':completion:*:expand:*'                     tag-order all-expansions
zstyle ':completion:*:history-words'                list false
zstyle ':completion:*:history-words'                menu true
zstyle ':completion:*:history-words'                remove-all-dups true
zstyle ':completion:*:history-words'                stop true
zstyle ':completion:*:manuals'                      separate-sections true
zstyle ':completion:*:matches'                      group true
zstyle ':completion:*:messages'                     format '%d'
zstyle ':completion:*:options'                      auto-description '%d'
zstyle ':completion:*:options'                      description true
zstyle ':completion:*:processes'                    command 'ps -au$USER'
zstyle ':completion:*:processes-names'              command 'ps c -u ${USER} -o command | uniq'
zstyle ':completion:*:warnings'                     format $'%{\e[0;31m%}No matches for:%{\e[0m%} %d'
zstyle ':completion::(^approximate*):*:functions'   ignored-patterns '_*'
zstyle ':completion:correct:'                       prompt 'correct to: %e'

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
bindkey -v '^R'      history-incremental-pattern-search-backward
bindkey -a '?'      history-incremental-pattern-search-forward
bindkey -v '^s'     insert-sudo
bindkey -v '^y'     insert-man
bindkey -v '^k'     kill-buffer
bindkey -v '^[[Z'   reverse-menu-complete
bindkey -v '^[[A'   up-line-or-history
bindkey -a 'p'      up-line-or-search
bindkey -v '^p'     up-line-or-search
bindkey -a 'k'      up-line-or-search

## ALIASES ##
alias aura='aura --color=auto'
alias aurain='sudo aura -Ax'
alias aurare='sudo aura -Rns'
alias aurase='aura -Aas'
alias auraupg='sudo aura -Aux'
alias cal='cal -3 -m'
alias cd1='cd ../'
alias cd2='cd ../../'
alias cd3='cd ../../../'
alias cd4='cd ../../../../'
alias cr='cd `git rev-parse --show-toplevel`'
alias e='$EDITOR'
alias g='git'
alias l='ls -lh'
alias ll='l -A'
alias ls='ls --color=auto'
alias mountc='mount | column -t'
alias pacin='sudo pacman -S'
alias pacman='pacman --color=auto'
alias pacre='sudo pacman -Rns'
alias pacro='pacman -Qtdq && sudo pacman -Rns `pacman -Qtdq`'
alias pacse='pacman -Ss'
alias pacupg='sudo pacman -Syu'
alias t='task'

## FUNCTIONS ##
insert-word() {
    word="$1 "
    BUFFER="$word$BUFFER"
    CURSOR=$(expr $CURSOR + $(expr length $word))
}
insert-man() { insert-word "man" }
zle -N insert-man
insert-sudo() { insert-word "sudo" }
zle -N insert-sudo

extract () {
    for f in $*; do
        if [ -f $f ] ; then
            case $f in
                *.tar.bz2) tar xvjf $f ;;
                *.tar.gz) tar xvzf $f ;;
                *.tar.xz) tar xf $f ;;
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

## NODEJS/NVM ##
export NODE_PATH=/usr/lib/node_modules
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

## RUBY/RVM ##
export PATH=$PATH:$HOME/.gem/ruby/2.3.0/bin/:$HOME/.gem/ruby/2.2.0/bin/:$HOME/.rvm/bin
