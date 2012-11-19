#      __               __                           _____ __   
#     / /_  ____ ______/ /_        ____  _________  / __(_) /__ 
#    / __ \/ __ `/ ___/ __ \      / __ \/ ___/ __ \/ /_/ / / _ \
# _ / /_/ / /_/ (__  ) / / /     / /_/ / /  / /_/ / __/ / /  __/
#(_)_.___/\__,_/____/_/ /_/_____/ .___/_/   \____/_/ /_/_/\___/ 
#                        /_____/_/                              
# Leland Batey

#### This is part of the default .profile for Ubuntu server, and is copied from that. ####
# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
        . "$HOME/.bashrc"
    fi
fi

# Include .bashrc
[[ -f ~/.bashrc ]] && . ~/.bashrc

if [ -d "$HOME/bin" ]; then 
    PATH=$PATH:$HOME/bin
fi

if [ -d "$HOME/bin" ]; then
    PATH=$PATH:$HOME/.cabal/bin
fi
