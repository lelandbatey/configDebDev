#      __               __                           _____ __   
#     / /_  ____ ______/ /_        ____  _________  / __(_) /__ 
#    / __ \/ __ `/ ___/ __ \      / __ \/ ___/ __ \/ /_/ / / _ \
# _ / /_/ / /_/ (__  ) / / /     / /_/ / /  / /_/ / __/ / /  __/
#(_)_.___/\__,_/____/_/ /_/_____/ .___/_/   \____/_/ /_/_/\___/ 
#                        /_____/_/                              
# Leland Batey

# Include .bashrc
[[ -f ~/.bashrc ]] && . ~/.bashrc

if [ -d "$HOME/bin" ]; then 
    PATH=$PATH:$HOME/bin
fi

if [ -d "$HOME/bin" ]; then
    PATH=$PATH:$HOME/.cabal/bin
fi
