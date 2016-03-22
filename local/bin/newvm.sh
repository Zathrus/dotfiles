#!/usr/bin/env bash

IMGDIR="/srv/vm/images/"
XMLDIR="/srv/vm/xml/"

# $1 = new name
newvm="$1"

# copy template image -- this already has the key injected or root pw set
cp "$IMGDIR/c7-key.qcow2" "$IMGDIR/$newvm.qcow2"

# run sed on xml
sed -e "s/VMNAME/$newvm/" "$XMLDIR/c7-base.xml" > "$XMLDIR/$newvm.xml"
# may need to gen UUID
# -e "s/UUID/$(uuidgen)/"
# may need to change mac
# -e "s/MAC/$(macgen.py)/"

# define VM
sudo virsh define "$XMLDIR/$newvm.xml"
