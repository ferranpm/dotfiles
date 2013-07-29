###############
## OH-MY-ZSH ##
###############
ZSH=$HOME/.oh-my-zsh
ZSH_THEME="blinks"
CASE_SENSITIVE="true"
DISABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"
plugins=(git archlinux cp gnu-utils vi-mode)

source $ZSH/oh-my-zsh.sh

export PATH=$PATH:/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin:/opt/android-sdk/platform-tools:/opt/android-sdk/tools:/usr/bin/vendor_perl:/usr/bin/core_perl:~/.gem/ruby/2.0.0/bin:.
export PYTHONSTARTUP=$HOME/.pythonrc
export SHELL=/usr/bin/zsh
export EDITOR=/usr/bin/vim

unsetopt correct_all

# Turn off terminal driver flow control (CTRL+S/CTRL+Q)
setopt noflowcontrol
stty -ixon -ixoff

alias l="ls -lh"
alias ll="l -A"
alias cal="cal -3"
alias rss="newsbeuter -r"
alias diff="diff -yEbwB --suppress-common-lines"
alias grep="grep --color=always"
