#!/bin/bash

# chroot $ROOTFS /bin/bash /start_kodi.sh
# In case '-R' option is not available in your system, replace '-R' with 'chroot'.
# exec unshare --kill-child=SIGTERM -upfi --mount-proc chroot $ROOTFS /start_kodi.sh
exec unshare --kill-child=SIGTERM -upfi --mount-proc -R $ROOTFS /start_kodi.sh
