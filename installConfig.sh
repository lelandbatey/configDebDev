#!/bin/bash

# Short script to install the various config files
# Arguments are:
#  .basrc
#  .vim
#  <nothing>


if [ "$1" == .bashrc ]; then
  cp .bashrc ~/
elif [ "$1" == vim ]; then
  cp -r .vim ~/ &
  cp .vimrc ~/
elif [ -z "$1" ]; then
  cp .bashrc ~/
  cp -r .vim ~/
  cp .vimrc ~/
  cp .Xresources ~/
  cp .dir_colors ~/
fi
