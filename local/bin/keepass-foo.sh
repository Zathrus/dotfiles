#!/bin/bash

if [[ ! -n $(pidof dropbox) ]]; then
    #echo "Dropbox is not running, starting now..."
    nohup /home/tsorense/.dropbox-dist/dropboxd > /dev/null &2>1 &
fi

if [[ -n $(pidof keepassx) ]]; then
    #echo "KeePassX is already running, bringing window to focus now..."
    kp_xwid=$(wmctrl -lp | grep KeePassX | egrep -v '(Chrome|Firefox)' | awk '{print $1}')
    if [[ -z $kp_xwid ]]; then
        echo "No X window ID found. This happens if KeePassX is set to minimize to the system tray. Please change your settings."
        exit
    fi
    wmctrl -i -a $kp_xwid
else
    #echo "KeePassX is not running, starting now..."
    nohup keepassx > /dev/null &2>1 &
fi
