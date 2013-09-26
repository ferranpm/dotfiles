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

urxvtd -q -o -f

case $1 in
  i3)
    exec i3
    ;;
  *)
    exec startxfce4
    ;;
esac
