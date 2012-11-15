if [ "$TERM" != "dumb" ]; then
    [ -e "$HOME/.dir_colors" ] && DIR_COLORS="$HOME/.dir_colors"
    [ -e "$DIR_COLORS" ] || DIR_COLORS=""
    eval "`dircolors -b $DIR_COLORS`"
    alias ls='ls --color=auto'
    #alias dir='ls --color=auto --format=vertical'
    #alias vdir='ls --color=auto --format=long'
fi

if [ -f ~/.dir_colors ]; then
    eval `dircolors ~/.dir_colors`
fi



alias la="ls -a" #lists all files
alias ll="ls -alh" #lists all files in long form, and in a more human readble format
alias netrestart="sudo rc.d restart network"

# These copied from Lane Aasen (https://github.com/aaasen/config/blob/master/home/.bashrc)
alias ls="ls --color=auto --group-directories-first"
alias la="ls -a" #all files
alias ll="ls -l" #long listing format
alias lx="ls -x" #grouped by file extension

