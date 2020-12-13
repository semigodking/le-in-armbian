#!/bin/bash

ROOTFS=$(realpath $ROOTFS)

umount -l $ROOTFS/run/dbus
umount -l $ROOTFS/dev
umount -l $ROOTFS/storage
