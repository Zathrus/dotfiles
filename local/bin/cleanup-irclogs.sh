#!/bin/bash

IRC_LOGS="$HOME/irclogs"
ARCHIVE_PATH="$IRC_LOGS/old"

function usage {
    printf "$0 directory year\n"
    printf "\tdirectory - server to cleanup under $IRC_LOGS\n"
    printf "\tyear - year to cleanup\n"
}

if [[ -z "$1" ]]; then
    usage
    exit 1
fi

if [[ -z "$2" ]]; then
    usage
    exit 2
fi

LOGDIR="$1"
YEAR="$2"

printf "Cleaning up $1 for $2\n"

if [[ ! -d "$IRC_LOGS/$LOGDIR" ]]; then
    printf "$IRC_LOGS/$LOGDIR is not a directory\n"
    exit 3
fi

# compress all directories
cd "$IRC_LOGS/$LOGDIR"
for d in *; do
    printf "Processing $d\n"
    if [[ -d $d ]]; then
        cd "$d"
        if [[ ! -d "$ARCHIVE_PATH/$LOGDIR/$d" ]]; then
            mkdir -p "$ARCHIVE_PATH/$LOGDIR/$d"
        fi

        # Check for files first
        if compgen -G "$YEAR*" > /dev/null; then
            tar cfj "$ARCHIVE_PATH/$LOGDIR/$d/$YEAR.tar.bz2" $YEAR* && rm -f $YEAR*
        fi

        # remove if empty now
        cd ..
        rmdir "$ARCHIVE_PATH/$LOGDIR/$d" 2>/dev/null
        find "$d" -maxdepth 0 -empty -exec rmdir {} \;
    fi
done

find "$IRC_LOGS/$LOGDIR" -maxdepth 0 -empty -exec rmdir {} \;
