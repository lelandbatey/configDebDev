#!/bin/bash



## Taken from Lane Aasen's Github on configs ##
#set up terminus (and other) fonts
xset +fp /usr/share/fonts/local
xset fp rehash

#prepare xmonad
xrdb -merge ~/.Xresources

# For now DWM will be launched
#dwm
xmonad &
xmobar
