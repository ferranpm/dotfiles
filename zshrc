PROMPT='
%{$fg[green]%}%n%{$fg[blue]%}@%{$fg[cyan]%}%m%{$fg[blue]%}:%{$fg[yellow]%}%~$(git_prompt)$(vi_prompt)
%{$fg_bold[cyan]%}>%{$reset_color%} '

autoload -U colors && colors
autoload -U compinit && compinit

setopt prompt_subst   # substitute params in prompt
setopt noflowcontrol  # Turn off terminal driver flow control (CTRL+S/CTRL+Q)
stty -ixon

## VARIABLES ##
ZSH=$HOME/.zsh
PLUGINS=$ZSH/plugins
ALIASES=$ZSH/aliases
HISTFILE=$HOME/.zsh_history
HISTSIZE=50000
SAVEHIST=10000
ZLS_COLORS=$LS_COLORS

## EXPORTS ##
export SHELL=/usr/bin/zsh
export EDITOR=/usr/bin/vim
export PAGER=/usr/bin/less
export GREP_OPTIONS='--color=auto'
export LESS='-R'

## ZSTYLE ##
source $ZSH/zstyles.zsh

## BINDKEYS ##
source $ZSH/bindkeys.zsh

## ALIASES ##
source $ALIASES/ls.zsh
source $ALIASES/git.zsh
source $ALIASES/pacman.zsh
source $ALIASES/misc.zsh

## PLUGINS ##
source $PLUGINS/vi-mode.zsh
source $PLUGINS/git-prompt.zsh
