#!/usr/bin/env bash

pkill xcape
pkill xmodmap

xmodmap -e "remove Lock      = Caps_Lock"
xmodmap -e "remove Control   = Control_L"
xmodmap -e "keysym Control_L = Caps_Lock"
xmodmap -e "keysym Caps_Lock = Control_L"
xmodmap -e "add Lock         = Caps_Lock"
xmodmap -e "add Control      = Control_L"

xcape
