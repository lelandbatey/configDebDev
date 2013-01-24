#!/bin/bash

# Short script to install the various config files
# Arguments are:
#  .basrc
#  .vim
#  <nothing>


CMDS[1]="cp \"$1\" ~/"
CMDS[2]="cp -r .vim ~/ & cp .vimrc ~/"
CMDS[3]=$(cp .bashrc ~/
cp -r .vim ~/
cp .vimrc ~/
cp .Xresources ~/
cp .dir_colors ~/
cp .bash_profile ~/
cp .xinitrc ~/
cp -r .xmonad ~/
cp .xmobarrc ~/)
CMDS[4]=$(cp .bashrc ~/
cp -r .vim ~/
cp .dir_colors ~/
cp .bash_colors ~/)


printf "${CMDS[3]}"
# Because the actual value of CMDS[3] is evaluated as a command (notice the "$()" in it's invocation), I don't know a way to echo that value
echo "$1"

if [ -n "$1" ] && [ ! "$1" == vim ]; then
  cp "$1" ~/
elif [ "$1" == vim ]; then
  cp -r .vim ~/ &
  cp .vimrc ~/
elif [ "$1" == noX ]; then
  ${CMDS[4]}
elif [ -z "$1" ]; then
  ${CMDS[3]}
fi
