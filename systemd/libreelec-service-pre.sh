#!/bin/bash

ROOTFS=$(realpath $ROOTFS)

cp /etc/resolv.conf $ROOTFS/run/libreelec/
mount --bind /dev $ROOTFS/dev
mount --bind /run/dbus $ROOTFS/run/dbus
mount --bind /storage $ROOTFS/storage
