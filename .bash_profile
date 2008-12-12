# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

# User specific environment and startup programs

export PATH=$HOME/local/bin:$PATH

export PS1='\[\e[0;36m\][\u@\h \W $?]\$ \[\e[m\]'

set -o vi

export LESS=-CeiM
export PAGER=$(which less)
export NETHACKOPTIONS=autodig,autopickup,pickup_types:$,autoquiver,nolegacy,nomail,pushweapon,rest_on_space,nosparkle,time,notombstone,nonews,nocheckspace,showexp,showscore

stty -ixon >/dev/null 2>/dev/null
