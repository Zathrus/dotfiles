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
    *)      LS_FLAGS=
            ;;
esac

alias gb='git branch'
alias gba='git branch -a -v'

alias la='ls -a'
alias ls="ls $LS_FLAGS -CF"

alias md='mkdir -p'
alias more=$(which less)
