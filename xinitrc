#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

Wallpaper=~/Pictures/Wallpapers/beksinski_bones.jpg
Xresources=~/.Xresources
DefaultWM=i3

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
	for f in /etc/X11/xinit/xinitrc.d/* ; do
		[ -x "$f" ] && . "$f"
	done
	unset f
fi

# Set Wallpaper
feh --bg-scale $Wallpaper

# Set Xresources
xrdb $Xresources

urxvtd -q -o -f

if [ -z $1 ]; then
	exec $DefaultWM
else
	exec $1
fi
