###############
## OH-MY-ZSH ##
###############
# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# ZSH_THEME="dstufft"
# ZSH_THEME="fox"
# ZSH_THEME="gnzh"
# ZSH_THEME="kphoen"
# ZSH_THEME="mortalscumbag"
# ZSH_THEME="takashiyoshida"
# ZSH_THEME="frisk"
# ZSH_THEME="simonoff"
# ZSH_THEME="murilasso"
# ZSH_THEME="intheloop"
# ZSH_THEME="fino"
ZSH_THEME="bira"
# ZSH_THEME="blinks"

CASE_SENSITIVE="true"
DISABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"
plugins=(git archlinux cp gnu-utils)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
export PATH=$PATH:/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin:/opt/android-sdk/platform-tools:/opt/android-sdk/tools:/usr/bin/vendor_perl:/usr/bin/core_perl:.

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

fortune -a | cowsay -n
