#!/bin/bash

# Commands in chroot'ed bash
mount -t tmpfs tmpfs /tmp
# mount -t sysfs sysfs /sys
# mount -t proc proc /proc

# After chroot
#export __GL_YIELD=USLEEP
#export DISPLAY=:0.0
#export WAYLAND_DISPLAY=wayland-0
#export SDL_MOUSE_RELATIVE=0
export HOME=/storage
export KODI_TEMP=/storage/.kodi/temp
export KODI_HOME=/usr/share/kodi/

# Prepare configs
mkdir -p /run/libreelec
/usr/lib/kodi/kodi-config

# Run KODI
exec /usr/lib/kodi/kodi.bin --standalone -fs
RETVAL=$?
exit $RETVAL
