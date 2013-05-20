# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
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
# ZSH_THEME="bira"
ZSH_THEME="blinks"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
CASE_SENSITIVE="true"

# Comment this out to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how often before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want to disable command autocorrection
DISABLE_CORRECTION="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
COMPLETION_WAITING_DOTS="true"

# Uncomment following line if you want to disable marking untracked files under
# VCS as dirty. This makes repository status check for large repositories much,
# much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git archlinux cp gnu-utils)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
export PATH=$PATH:/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin:/opt/android-sdk/platform-tools:/opt/android-sdk/tools:/usr/bin/vendor_perl:/usr/bin/core_perl

unsetopt correct_all

alias l="ls -lh"
alias ll="l -A"
alias cal="cal -3"
alias rss="newsbeuter -r"
alias diff="diff -yEbwB --suppress-common-lines"
alias grep="grep --color=always"

fortune -a | cowsay -n
