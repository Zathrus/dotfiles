# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

export PS1='\[\e[1;36m\][\u@\h \W $?]\$ \[\e[m\]'

set -o vi

bind '"\e.":yank-last-arg'

# User specific aliases and functions
HOST=$(uname -s | tr A-Z a-z)
case $HOST in
    linux)  LS_FLAGS=--color=tty
            ;;
    darwin) export CLICOLOR=1
            export LSCOLORS=gxExfxDxcxdhdhcbcBgcgd
            ;;
    *)      LS_FLAGS=
            ;;
esac

alias gb='git branch'
alias gba='git branch -a -v'

alias la='ls -a'
alias ls="ls $LS_FLAGS -CF"
alias ll='ls -l'

alias md='mkdir -p'
alias more=$(type -p less)

if [[ $(uname) == "Darwin" ]]; then
    alias vim="$(type -p mvim) -v"
elif [[ $DISPLAY == ":0" && -x /usr/bin/vimx ]]; then
    alias vim="$(type -p vimx)"
fi

# rerun the last command, but edit the list of files output in vim.
alias v='vim $(fc -s)'

function calc
{
    echo "scale=2;$*" | bc
}

# Port defaults to 80 unless passed on command line as 2nd parameter
function tcping {
    port=${2:-80}
    if [[ $( nc -z $1 $port ) ]]; then
        echo $1:$port is accessible
    else
        echo $1:$port is not accessible
    fi
}

shopt -s histappend
