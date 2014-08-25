# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi

# User specific environment and startup programs

test -f .profile && source .profile

export PS1='\[\e[1;36m\][\u@\h \W $?]\$ \[\e[m\]'


if [ -n "$SSH_TTY" ]; then
    exec screen -xRR
fi

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
