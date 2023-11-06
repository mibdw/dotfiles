#!/bin/sh
autorandr --load clam &
picom --config ~/.config/picom/picom.conf &
nitrogen --force-setter=xinerama --head=0 --set-zoom-fill --random &
nitrogen --force-setter=xinerama --head=1 --set-zoom-fill --random &
unclutter &
dunst &
~/suckless/dwmblocks/dwmblocks
