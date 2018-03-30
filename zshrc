PROMPT='
%{$fg[green]%}%n%{$reset_color%} in %{$fg[yellow]%}%~%{$reset_color%} at %{$fg[blue]%}%m$(git_prompt)
%{$fg[blue]%}%(!.#.>)%{$reset_color%} '

fpath=(~/.zsh/completion $fpath)

stty -ixon

## EXPORTS ##
export COLORFGBG="15;0"
export EDITOR="vim"
export HISTFILE=$HOME/.zshhistory
export HISTSIZE=50000
export KEYTIMEOUT=1
export LESS_TERMCAP_mb=$(printf "\e[1;31m")
export LESS_TERMCAP_md=$(printf "\e[1;34m")
export LESS_TERMCAP_me=$(printf "\e[0m")
export LESS_TERMCAP_se=$(printf "\e[0m")
export LESS_TERMCAP_so=$(printf "\e[1;40;33m")
export LESS_TERMCAP_ue=$(printf "\e[0m")
export LESS_TERMCAP_us=$(printf "\e[1;32m")
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.rvm/bin:$PATH"
export PATH="$HOME/.rvm/gems/$RUBY_VERSION/bin:$PATH"
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

## ZSTYLE ##
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' menu select
zstyle ':completion:*' verbose true

## BINDKEYS ##
bindkey -e '^[[1~' beginning-of-line
bindkey -e '^[[4~' end-of-line
bindkey -e '^[[3~' delete-char
bindkey -e '^n' down-line-or-search
bindkey -e '^s' insert-sudo
bindkey -e '^y' insert-man
bindkey -e '^p' up-line-or-search

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
alias e='$EDITOR'
alias g='git'
alias l='ls -lh'
alias ll='l -A'
alias ls='ls --color=auto'
alias pacin='sudo pacman -S'
alias pacman='pacman --color=auto'
alias pacre='sudo pacman -Rns'
alias pacro='pacman -Qtdq && sudo pacman -Rns `pacman -Qtdq`'
alias pacse='pacman -Ss'
alias pacupg='sudo pacman -Syu'
alias psg='ps -e | grep'

## FUNCTIONS ##
insert-word() {
  word="$1 "
  BUFFER="$word$BUFFER"
  CURSOR=$(expr $CURSOR + ${#word})
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

# GIT
git_full_branch_name() {
  git symbolic-ref HEAD 2>/dev/null || git name-rev --name-only --no-undefined --always HEAD
}

git_branch_name() {
  git_full_branch_name | sed -e 's|refs/heads/||'
}

is_git_directory() {
  git rev-parse --git-dir >/dev/null 2>&1
}

git_prompt() {
  is_git_directory && echo " %{$reset_color%}[%{$fg[green]%}$(git_branch_name)%{$reset_color%}]"
}

rm_tr_white () {
  find . -not \( -name .svn -prune -o -name .git -prune -o -name '*.a' \) -type f -print0 | xargs -0 sed -i -e "s/[[:space:]]*$//"
}

## NODEJS/NVM ##
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

## FZF ##
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
