PROMPT='
%n in %~ at %m ${vcs_info_msg_0_}
%(!.#.>) %b'

stty -ixon

## EXPORTS ##
export COLORFGBG="15;0"
export EDITOR="nvim"
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
export PATH=$HOME/.local/bin:$PATH
export SAVEHIST=10000
export ZLS_COLORS=$LS_COLORS

autoload -U colors && colors

## OPTS ##
setopt APPEND_HISTORY
setopt AUTO_CD
setopt AUTO_PUSHD
setopt EXTENDED_GLOB
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_REDUCE_BLANKS
setopt HIST_SAVE_NO_DUPS
setopt HIST_VERIFY
setopt INC_APPEND_HISTORY
setopt NO_FLOW_CONTROL
setopt PROMPT_SUBST
setopt PUSHD_IGNORE_DUPS
setopt PUSHD_MINUS
setopt PUSHD_SILENT
setopt PUSHD_TOHOME

# VCS info ##
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' formats       'on %b'
zstyle ':vcs_info:*' actionformats 'on %b (%a)'

autoload -Uz vcs_info
precmd () {
  vcs_info
}

## BINDKEYS ##
bindkey -e '^[[3~' delete-char
bindkey -e '^s' insert-sudo
bindkey -e '^y' insert-man
bindkey -e '^p' up-line-or-search
bindkey -e '^n' down-line-or-search
bindkey -e '^[[1;5C' forward-word
bindkey -e '^[[1;5D' backward-word

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
alias dk='docker'
alias dkc='docker compose'
alias e='$EDITOR'
alias g='git'
alias github='open $(git_remote_http_url)/tree/$(git_branch_name)'
alias kcl='kubectl'
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
alias tf='terraform'

## FUNCTIONS ##
insert-word() {
  word="$1 "
  [[ $BUFFER =~ "^$word" ]] && return
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
git_issue() {
  git_branch_name | cut -d - -f 1-2 | tr '[:lower:]' '[:upper:]'
}

git_branch_name() {
  git_full_branch_name | sed -e 's|refs/heads/||'
}

git_full_branch_name() {
  git symbolic-ref HEAD 2>/dev/null || git name-rev --name-only --no-undefined --always HEAD
}

git_remote_http_url() {
  git remote -v | head -n1 | awk '{ sub(":", "/", $2); sub("git@", "https://", $2); sub("\.git$", "", $2); print $2 }'
}

rm_tr_white () {
  find . -not \( -name .svn -prune -o -name .git -prune -o -name '*.a' \) -type f -print0 | xargs -0 sed -i -e "s/[[:space:]]*$//"
}

test_and_source() { [ -f $1 ] && source $1 }

test_and_source "$HOME/.zsh/$(uname).zsh"
test_and_source "$HOME/.zsh/local.zsh"

# The following lines were added by compinstall

zstyle ':completion:*' completer _oldlist _expand _complete _ignored _match _prefix
zstyle ':completion:*' completions 1
zstyle ':completion:*' glob 1
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' matcher-list '' '' '' ''
zstyle ':completion:*' menu select
zstyle ':completion:*' squeeze-slashes true
zstyle ':completion:*' substitute 1
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true
zstyle :compinstall filename '/Users/fpelayo/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
