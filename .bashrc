# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

set -o vi

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

alias md='mkdir -p'
alias more=$(which less)

function calc
{
    echo "scale=2;$*" | bc
}

function tcping {
    if [[ -z "$2" ]]; then
        port=80
    else
        port=$2
    fi
    if [[ $( nc -z $1 $port ) ]]; then
        echo $1:$port is accessible
    else
        echo $1:$port is not accessible
    fi
}
