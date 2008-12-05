# .bashrc

# User specific aliases and functions

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

export LESS=-CeiM
export PAGER=`which less`

alias md='mkdir -p'
alias more=`which less`

stty -ixon >/dev/null 2>/dev/null

export NETHACKOPTIONS=autodig,autopickup,pickup_types:$,autoquiver,nolegacy,nomail,pushweapon,rest_on_space,nosparkle,time,notombstone,nonews,nocheckspace,showexp,showscore
