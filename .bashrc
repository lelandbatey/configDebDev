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

# Start ssh-agent, then run ssh-add so that all rsa keys are loaded for use
#exec ssh-agent bash &
#ssh-add &

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

# These copied from Lane Aasen (https://github.com/aaasen/config/blob/master/home/.bashrc)
alias ls="ls --color=auto --group-directories-first"
alias la="ls -a" #all files
# Removed for better alternative below  alias ll="ls -l" #long listing format
alias lx="ls -x" #grouped by file extension

alias ld="ls -d */" # Lists only folders
alias la="ls -a" #lists all files
alias ll="ls -alh" #lists all files in long form, and in a more human readble format
alias netrestart="sudo rc.d restart network"

alias lguf="git ls-files --other --exclude-standard" # Lists all untracked files in a repository (alias name is a bit verbose)'
alias grpax="ps aux | grep" # Shortcut for searching for running processes
