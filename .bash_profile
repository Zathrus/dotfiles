# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

# User specific environment and startup programs

export PATH=$HOME/local/bin:$PATH:$ORACLE_HOME/bin

export PS1='\[\e[0;36m\][\u@\h \W $?]\$ \[\e[m\]'

set -o vi

export LESS=-CeiM
export PAGER=`which less`

stty -ixon >/dev/null 2>/dev/null
