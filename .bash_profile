# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi

# User specific environment and startup programs

test -f .profile && source .profile

export PS1='\[\e[1;36m\][\u@\h \W $?]\$ \[\e[m\]'
export INPUTRC=~/.inputrc

if [ -n "$SSH_TTY" ]; then
    exec screen -xRR
fi
