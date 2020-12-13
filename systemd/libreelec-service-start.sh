#!/bin/bash

# chroot $ROOTFS /bin/bash /start_kodi.sh
exec unshare --kill-child=SIGTERM --mount-proc -p -f -R $ROOTFS /start_kodi.sh
