export PATH=$HOME/local/bin:/usr/local/bin:$PATH:/opt/instantclient_11_2

export LESS=-eFiMRX
export PAGER=$(type -P less)

export INPUTRC=~/.inputrc

export ANT_OPTS="-Xms1536m -Xmx1536m -XX:PermSize=512m -XX:MaxPermSize=512m -Xss4096k"
export DYLD_LIBRARY_PATH=/opt/instantclient_11_2

stty -ixon >/dev/null 2>/dev/null
