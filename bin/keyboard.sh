#!/usr/bin/env bash

killall xcape
killall xmodmap

xmodmap -e "remove Lock    = Caps_Lock"
xmodmap -e "remove Control = Control_L"

xmodmap -e "keycode 9  = Caps_Lock"
xmodmap -e "keycode 66 = Control_L"
xmodmap -e "keycode 37 = Escape"

xmodmap -e "add Lock    = Caps_Lock"
xmodmap -e "add Control = Control_L"

xcape -e "Control_L=Escape"
