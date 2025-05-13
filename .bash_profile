# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi

# User specific environment and startup programs

test -f .profile && source .profile

export PS1='\[\e[1;36m\][\u@\h \W $?]\$ \[\e[m\]'


if [ -n "$SSH_TTY" -a ! -e ~/.noscreen ]; then
    exec screen -UxRR
elif [ -n "$SSH_TTY" -a ! -e ~/.notmux ]; then
    exec tmux new-session -A -s main
fi
