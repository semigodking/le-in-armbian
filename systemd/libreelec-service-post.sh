#!/bin/bash

ROOTFS=$(realpath $ROOTFS)

umount -l $ROOTFS/dev
umount -l $ROOTFS/run/dbus
umount -l $ROOTFS/mnt/storage
