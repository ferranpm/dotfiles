#!/usr/bin/env bash
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
	for f in /etc/X11/xinit/xinitrc.d/* ; do
		[ -x "$f" ] && . "$f"
	done
	unset f
fi

export DEFAULTWM=startkde
export EDITOR=/usr/bin/vim
export PAGER=/usr/bin/less
export SHELL=/usr/bin/zsh
export WALLPAPER=~/Pictures/Wallpapers/1920x1080_FlyingWhalesPainting.png
export XRESOURCES=~/.Xresources
export RANGER_LOAD_DEFAULT_RC=FALSE

if [ -z $1 ]; then
	exec $DEFAULTWM
else
	exec $1
fi
