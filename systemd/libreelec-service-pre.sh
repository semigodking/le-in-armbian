#!/bin/bash

ROOTFS=$(realpath $ROOTFS)

mount --bind /dev $ROOTFS/dev
mount --bind /storage $ROOTFS/storage
mount --bind /run/dbus $ROOTFS/run/dbus
cp /etc/resolv.conf $ROOTFS/run/libreelec/
exit 0
