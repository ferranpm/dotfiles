PATH=$PATH:/c/Program\ Files\ \(x86\)/Git/bin
if [[ "$(uname -s)" == *MINGW* ]]; then
    HOME="/c/Users/Ferran"
fi

source $HOME/dotfiles/git-prompt.sh
PS1='[\u@\h \w]$(__git_ps1 " (%s)")\n\$ '

set -o vi

## ALIASES ##
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
