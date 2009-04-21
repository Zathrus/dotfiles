# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

set -o vi

# User specific aliases and functions
alias la='ls -la'
alias md='mkdir -p'
alias mktag='ctags -R --fields=+aiKmnsSz --langmap=c:+.pc'
alias more=`which less`


# server aliases
alias vios='screen -T xterm -t vios telnet aixvios'
alias vm1='screen -T xterm -t vm1 telnet vm1'
alias vm2='screen -T xterm -t vm2 telnet vm2'
alias vm3='screen -T xterm -t vm3 telnet vm3'
alias vm4='screen -T xterm-color -t vm4 ssh bagman52@vm4'
alias vm4me='screen -T xterm-color -t vm4me ssh vm4'
alias vm5='screen -T xterm -t vm5 telnet vm5'
alias vm6='screen -T xterm -t vm6 telnet vm6'
alias vm7='screen -T xterm -t vm7 telnet vm7'
alias chloe='screen -T xterm -t chloe telnet chloe'
alias sun1='screen -T xterm -t sun1 telnet suntest1'
alias sun2='screen -T xterm -t sun2 telnet suntest2'
alias si='screen -T xterm -t si telnet bagmanager'
alias si1='screen -T xterm -t si1 telnet bagmanager1'
alias si2='screen -T xterm -t si2 telnet bagmanager2'

alias amst='screen -T xterm -t amstest ssh 57.31.37.5'
