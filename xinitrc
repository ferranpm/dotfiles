#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

case $1 in
  i3)
    exec i3
    ;;
  xfce4)
    exec startxfce4
    ;;
  *)
    exec i3
    ;;
esac
