#!/bin/sh
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

export DEFAULTWM=i3
export EDITOR=/usr/bin/vim
export PAGER=/usr/bin/less
export SHELL=/usr/bin/zsh
export WALLPAPER=~/Pictures/Wallpapers/beksinski_bones.png
export XRESOURCES=~/.Xresources

setxkbmap us
xmodmap ~/dotfiles/Return

feh --bg-scale $WALLPAPER &
firefox &
mpd &
urxvtd -q -o -f &
xbindkeys &
xrdb $XRESOURCES &
xscreensaver -no-splash &

if [ -z $1 ]; then
	exec $DEFAULTWM
else
	exec $1
fi
