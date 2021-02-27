#!/bin/bash

ROOTFS=$(realpath $ROOTFS)

umount -l $ROOTFS/dev
umount -l $ROOTFS/run/dbus
umount $ROOTFS/mnt/storage
