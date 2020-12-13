#!/bin/bash

# Commands in chroot'ed bash
mount -t tmpfs tmpfs /tmp
# mount -t sysfs sysfs /sys
# Uncomment this line if you start KODI with chroot instead of unshare
# mount -t proc proc /proc

# After chroot
#export __GL_YIELD=USLEEP
#export DISPLAY=:0.0
#export WAYLAND_DISPLAY=wayland-0
#export SDL_MOUSE_RELATIVE=0
export HOME=/home/kodi
export KODI_TEMP=/home/kodi/.kodi/temp
export KODI_HOME=/usr/share/kodi/

# Prepare configs
mkdir -p /run/libreelec
/usr/lib/kodi/kodi-config

# Run KODI
exec /usr/lib/kodi/kodi.bin --standalone -fs
