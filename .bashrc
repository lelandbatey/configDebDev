#       __               __             
#      / /_  ____ ______/ /_  __________
#     / __ \/ __ `/ ___/ __ \/ ___/ ___/
#  _ / /_/ / /_/ (__  ) / / / /  / /__  
# (_)_.___/\__,_/____/_/ /_/_/   \___/  
# 
# Leland Batey

# The below is a very ancient holdover from the classic TTY days. It used to be
# that you could pause the presentation of characters on a TTY by using a
# control key (Ctrl-S) so that the person using it could read things before they
# moved off the screen.
# Now though, that's wholely unnecessary, since you can scroll up in your
# terminal :). So, this little flag disables the very annoying behaviour of
# Ctrl-S freezing the terminal, requiring Ctrl-Q to unfreeze. So yay for things
# being more modern!
stty -ixon

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

# If the appropriate bash_completion file exists, then source it!
if [ -f /etc/bash_completion ]; then
 . /etc/bash_completion
fi

# Source bashmarks
if [ -f "$HOME/.local/bin/bashmarks.sh" ]; then
    . "$HOME/.local/bin/bashmarks.sh"
fi

## SSH KEYS ##
# The below handles ssh keys. It's inside a massive if block that checks if we are in an interactive vs non-interactive shell.
# This is important, since otherwise it breaks SFTP.
if [[ $- == *i* ]]
then
    ### RVM Startup! ###
    # By default RVM puts this next line into the .bash_profile line. However, 
    # this is a STUPID IDEA because .bash_profile is only exectuted for "login"
    # shells. By default, most shells opened once you've actually logged in are
    # NOT login shells. So URXVT, Gnome Terminal, etc are all non-login shells 
    # by default. However, they are interactive shells, which should be the
    # distinction. But, because the Ruby community seems to only ever do
    # anything on OS X and they don't care at all about how stuff works, they
    # plopped this down in .bash_profile and said that the way to fix this is
    # to change your terminal emulator to log in as a login shell.
    # Which is just INCREDIBLY stupid. They need to get their crap together.
    # Douchebags.
    [[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

    ### Starts ssh-agent and loads all ssh keys as needed ###
    # This excellent script was copied from http://rocksolidwebdesign.com/notes-and-fixes/ubuntu-server-ssh-agent/
    # Check to see if SSH Agent is already running
    agent_pid="$(ps -ef | grep "ssh-agent" | grep -v "grep" | awk '{print($2)}')"
     
    # If the agent is not running (pid is zero length string)
    if [[ -z "$agent_pid" ]]; then
        # Start up SSH Agent
     
        # this seems to be the proper method as opposed to `exec ssh-agent bash`
        eval "$(ssh-agent)"
     
        # if you have a passphrase on your key file you may or may
        # not want to add it when logging in, so comment this out
        # if asking for the passphrase annoys you
        ssh-add
     
    # If the agent is running (pid is non zero)
    else
        # Connect to the currently running ssh-agent
     
        # this doesn't work because for some reason the ppid is 1 both when
        # starting from ~/.profile and when executing as `ssh-agent bash`
        #agent_ppid="$(ps -ef | grep "ssh-agent" | grep -v "grep" | awk '{print($3)}')"
        agent_ppid="$(($agent_pid - 1))"
     
        # and the actual auth socket file name is simply numerically one less than
        # the actual process id, regardless of what `ps -ef` reports as the ppid
        agent_sock="$(find /tmp -path "*ssh*" -type s -iname "agent.$agent_ppid")"
     
        echo "Agent pid $agent_pid"
        export SSH_AGENT_PID="$agent_pid"
     
        echo "Agent sock $agent_sock"
        export SSH_AUTH_SOCK="$agent_sock"
        ssh-add
    fi
fi

# These copied from Lane Aasen (https://github.com/aaasen/config/blob/master/home/.bashrc)
alias ls="ls --color=auto --group-directories-first"
alias la="ls -a" #all files
# Removed for better alternative below  alias ll="ls -l" #long listing format
alias lx="ls -x" #grouped by file extension

alias ld="ls -d */" # Lists only folders
alias la="ls -a" #lists all files
alias ll="ls -Llh" #lists files in long form, and in a more human readble format
alias lo="ll --sort=extension" #Lists in nice human readble form, sorts directories first, then groups files with similar formats together.
alias lk="ls -alh" #listals all files in verbose form with human readable numbers/permissions.
alias netrestart="sudo service networking restart"

alias lguf="git ls-files --other --exclude-standard" # Lists all untracked files in a repository (alias name is a bit verbose)'
alias grpax="ps aux | grep" # Shortcut for searching for running processes
alias less="less -N" # Less now shows line numbers on the left hand side.
alias gca="git commit -am" # Makes commits faster!
#alias gpa="find ~/ -name ".git" -type d | sed 's,/*[^/]\+/*$,,' | xargs -L1 bash -c 'cd "\$1" && git pull' _" # Automatically "pull" all github repos in the current users home directory
alias gpa="find ~/ -name .git -type d | sed 's,/*[^/]\+/*$,,' | xargs -L1 bash -c 'cd \$1 && git pull; echo -ne \ : \$1 \\\n' _" # Automatically "pull" all github repos in the current users home directory
alias gshow="git show --color --pretty=format:%b" # Pretty-printing of a commit in git

alias vnv="source ~/bin/venv/bin/activate"

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

#Increases the size of the .bash_history file to 5000 lines
HISTSIZE=50000
export PS1='\[\e[0;36m\]${debian_chroot:+($debian_chroot)}\u\[\e[1;33m\]@\[\e[0;35m\]\h:\[\e[0;32m\]\n\w\[\e[0m\] \n$ '


PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
