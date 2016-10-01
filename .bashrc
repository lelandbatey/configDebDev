#       __               __
#      / /_  ____ ______/ /_  __________
#     / __ \/ __ `/ ___/ __ \/ ___/ ___/
#  _ / /_/ / /_/ (__  ) / / / /  / /__
# (_)_.___/\__,_/____/_/ /_/_/   \___/
#
# Leland Batey

# Setting flags for different versions of Unix. Since I could use this on OS
# X, Cygwin, Ubuntu, Fedora, Freebsd, or more, we need to account for the
# different ways to enable behaviours.
NIXTYPE="$(uname)"

# Default COLORFLAG. Set's as this for unknown systems.
COLORFLAG="--color=auto"
case "$NIXTYPE" in
    "Darwin" )
        COLORFLAG="-G"
        ;;

    "Linux" )
        COLORFLAG="--color=auto --group-directories-first"
        ;;

    "CYGWIN"* )
        COLORFLAG="--color=auto --group-directories-first"
        ;;
esac


# The below is a very ancient holdover from the classic TTY days. It used to be
# that you could pause the presentation of characters on a TTY by using a
# control key (Ctrl-S) so that the person using it could read things before they
# moved off the screen.
# Now though, that's wholely unnecessary, since you can scroll up in your
# terminal :). So, this little flag disables the very annoying behaviour of
# Ctrl-S freezing the terminal, requiring Ctrl-Q to unfreeze. So yay for things
# being more modern!
if [[ $- == *i* ]]; then
    stty -ixon
    bind '"\C-b":backward-kill-word'
fi

# Append to the history file instead of over-writing it. Normally, the history
# file is read into memory by the shell, then overwritten when the shell exits.
# This can lead to a loss of history with multiple terminals open. Instead, this
# ensures the history will be appended-to, stopping loss of history.
shopt -s histappend

# Sets the term variable to be 256colors if the terminal would otherwise just
# call itself xterm. Done since MinTTY defaults to a TERM of 'xterm', which
# causes screen not to work with 256 colors.
case "$TERM" in
    xterm) export TERM="$TERM-256color";;
esac


if [ "$TERM" != "dumb" ]; then
    alias ls="ls $COLORFLAG"
fi

if [[ -f ~/.dir_colors && -n "$(which dircolors)" ]]; then
    eval `dircolors ~/.dir_colors`
fi

# If the appropriate bash_completion file exists, then source it!
if [ -f /etc/bash_completion ]; then
 . /etc/bash_completion
fi

# Source bashmarks
if [ -f "$HOME/.local/bin/bashmarks.sh" ]; then
    . "$HOME/.local/bin/bashmarks.sh"
fi

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

## SSH KEYS ##
# The below handles ssh keys. It's inside a massive if block that checks if we
# are in an interactive vs non-interactive shell. This is important, since
# otherwise it breaks SFTP.
if [[ $- == *i* ]]
then
    if [ ! -S ~/.ssh/ssh_auth_sock ]; then
        eval "$(ssh-agent -s)"
        echo "ssh auth socket: $SSH_AUTH_SOCK"
        ln -sf "$SSH_AUTH_SOCK" ~/.ssh/ssh_auth_sock
    fi
    export SSH_AUTH_SOCK=~/.ssh/ssh_auth_sock
    ssh-add -l | grep "The agent has no identities" && ssh-add
fi

# These copied from Lane Aasen (https://github.com/aaasen/config/blob/master/home/.bashrc)
#alias ls="ls --color=auto --group-directories-first"
alias la="ls -a" #all files
# Removed for better alternative below  alias ll="ls -l" #long listing format
# Lists all files in verbose form with human readable numbers/permissions.
alias lk="ls -alh"

# Lists files in long form, and in a more human readble format. Additionally,
# the capital L makes `ls` regard symlinks as normal directories so they'd get
# grouped first as well. Does not display files ending in the extension "*.pyc"
# (compiled python files)
alias ll="ls -lhL --ignore=\"*.pyc\""

# The following aliases do not work on OS X.
# Grouped by file extension.
alias lx="ls -x"
# Lists only folders
alias ld="ls -d */"
# Lists in nice human readble form, sorts directories first, then groups files with similar formats together.
alias lo="ll --sort=extension"

alias netrestart="sudo service networking restart"

alias lguf="git ls-files --other --exclude-standard" # Lists all untracked files in a repository (alias name is a bit verbose)'
alias grpax="ps aux | grep" # Shortcut for searching for running processes
alias lesn="less -N" # Less now shows line numbers on the left hand side.
alias gca="git commit -am" # Makes commits faster!

# Automatically "pull" all github repos in the current users home directory
alias gpa="find ~/ -name .git -type d | sed 's,/*[^/]\+/*$,,' | xargs -L1 bash -c 'cd \$1 && git pull; echo -ne \ : \$1 \\\n' _"

alias gshow="git show --color --pretty=format:%b" # Pretty-printing of a commit in git

alias vnv="source ~/bin/venv-3/bin/activate"
alias vnv2="source ~/bin/venv/bin/activate"

function lag(){ # Stands for "list all gits" and it just lists all the git repos in current dir
    find $PWD -name ".git" -type d | sed 's,/*[^/]\+/*$,,'
}

# Function for quickly making latex-pdfs via Pandoc easier.
function mkPd(){
    echo $2 "what" $1
    pandoc --webtex -s -o $2 $1
}

# Function for splitting a string on a delimiter using python.
function pSplit(){
    #echo -e "1: $1\n2: $2"
    python -c "from __future__ import print_function
for x in \"\"\"$1\"\"\".split(\"$2\"): print(x);"
}

function mp(){
    x="$1"
    rawfile="${x%.*}" # Gets all items before first period
    outfile=""
    extension=".html"

    if [[ -z "$2" ]]; then
        outfile="$rawfile$extension"
    else
        outfile="$rawfile.$2"
    fi
    pandoc -s -o "$outfile" "$1"
}


# Unlimited bash history size
#unset HISTSIZE
#unset HISTFILESIZE
export HISTSIZE=50000000
export HISTFILESIZE=50000000

# Defining colors for prompt
bold='\e[1;39m'
orange='\e[38;5;208m'
red='\e[0;31m'
green='\e[0;32m'
bright_green='\e[1;32m'
yellow='\e[1;33m'
blue='\e[1;34m'
cyan='\e[0;36m'
purple='\e[0;35m'
reset='\e[0m'

# Functions in bash don't seem to really "return" anything. The only way to get
# a message out of them is to have them print data, then to capture that data
# via command substitution. That is what we do here.
function get_repo_name {
    repo=$(basename $(git rev-parse --show-toplevel 2> /dev/null) 2> /dev/null) || return
    echo "("$repo")"
}
function get_git_branch {
    ref=$(git symbolic-ref HEAD 2> /dev/null) || return
    echo ""
    echo "("${ref#refs/heads/}")"
}

user="\[$cyan\]\u\[$reset\]"
host="\[$purple\]\h\[$reset\]"
path="\[$green\]\w\[$reset\]"
cur_branch="\[$bright_green\]\$(get_git_branch)\[$reset\]"
cur_repo="\[$red\]\$(get_repo_name)\[$reset\]"
line_join="\[$yellow\]@\[$reset\]"
export PS1="$user$line_join$host\n$path $cur_branch $cur_repo\n$ "


if hash rvm 2>/dev/null; then
    # Add RVM to PATH for scripting
    PATH=$PATH:$HOME/.rvm/bin
fi

# Does rbenv specific setup
if [ -d "$HOME/.rbenv/" ]; then
    export PATH="$HOME/.rbenv/bin:$PATH"
    eval "$(rbenv init -)"
fi

# Does go specific setup
if [ -d "$HOME/bin/go/" ]; then
    export GOROOT="$HOME/bin/go"
    export PATH="$PATH:$GOROOT/bin"
    export GOPATH="/home/leland/projects/go-projects"
    export PATH="$PATH:${GOPATH//://bin:}/bin"
fi

# Does rust specific setup
if [ -d "$HOME/.cargo/bin/" ]; then
    export PATH="$PATH:$HOME/.cargo/bin/"
fi


# Adds android things to path if appropriate
if [[ -d "$HOME/bin/android-sdk-linux/" ]]; then
    export ANDROID_HOME="$HOME/bin/android-sdk-linux/"
    export PATH=$PATH:$ANDROID_HOME/tools
    export PATH=$PATH:$ANDROID_HOME/platform-tools
fi

# Sources nvm if it's installed.
if [ -d "$HOME/.nvm/" ]; then
    source "$HOME/.nvm/nvm.sh"
fi

# If terminal launched inside X, the DISPLAY variable will already be set.
# However, if launched without X (such as in CYGWIN) then DISPLAY will not be
# set. In these cases, we set it to a sane default.
if [ -z "$DISPLAY" ]; then
    DISPLAY=":0.0"
fi

export ANDROID_HOME="$HOME/Android/Sdk/"
export PATH=$PATH:$ANDROID_HOME/build-tools/23.0.1/
export PATH=$PATH:$ANDROID_HOME/platform-tools
export PATH=$PATH:$ANDROID_HOME/tools


