# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific aliases and functions
alias la='ls -la'
alias md='mkdir -p'
alias mktag='ctags -R --fields=+aiKmnsSz --langmap=c:+.pc'
alias more=`which less`
