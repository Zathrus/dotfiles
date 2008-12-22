# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

set -o vi

# User specific aliases and functions
alias la='ls -la'
alias md='mkdir -p'
alias more=$(which less)
