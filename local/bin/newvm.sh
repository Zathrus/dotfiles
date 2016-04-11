#!/usr/bin/env bash

IMGDIR="/srv/vm/images"
XMLDIR="/srv/vm/xml"

# $1 = new name
newvm="$1"

# copy template image -- this already has the keys injected; root pw is
# disabled:
virt-clone -o c7-template -n "${newvm}" --auto-clone

# use desc field for ansible groups
virsh desc "${newvm}" '{"groups": ["minecraft"]}'

# set the hostname; makes things easier to do now
virt-customize --hostname "${newvm}" -d "${newvm}"

# define VM
virsh start "${newvm}"
