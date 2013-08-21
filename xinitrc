#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

case $1 in
  xfce4)
    exec startxfce4
    ;;
  *)
    exec i3
    ;;
esac
