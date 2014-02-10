#      __               __                           _____ __   
#     / /_  ____ ______/ /_        ____  _________  / __(_) /__ 
#    / __ \/ __ `/ ___/ __ \      / __ \/ ___/ __ \/ /_/ / / _ \
# _ / /_/ / /_/ (__  ) / / /     / /_/ / /  / /_/ / __/ / /  __/
#(_)_.___/\__,_/____/_/ /_/_____/ .___/_/   \____/_/ /_/_/\___/ 
#                        /_____/_/                              
# Leland Batey
# All original code written by Leland Batey is licensed under the GPLv3. All copied code is licensed under their own respective license.


#### This is part of the default .profile for Ubuntu server, and is copied from that. ####
# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
        . "$HOME/.bashrc"
    fi
    if [ -f "$HOME/.local/bin/bashmarks.sh" ]; then
        . "$HOME/.local/bin/bashmarks.sh"
    fi
fi

if [ -d "$HOME/bin" ]; then 
    PATH=$PATH:$HOME/bin
fi

if [ -d "$HOME/.cabal/bin" ]; then
    PATH=$PATH:$HOME/.cabal/bin
fi

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
