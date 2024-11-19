#!/bin/sh

# Path of DEBIAN rootfs
DEBIANPATH="/data/local/tmp/chrootDebian"
USERNAME=${1:-root}
# Fix setuid issue
busybox mount -o remount,dev,suid /data

busybox mount --bind /dev $DEBIANPATH/dev
busybox mount --bind /sys $DEBIANPATH/sys
busybox mount --bind /proc $DEBIANPATH/proc
busybox mount -t devpts devpts $DEBIANPATH/dev/pts

# /dev/shm for Electron apps
if [ ! -d "$DEBIANPATH/dev/shm" ]; then
    mkdir -p "$DEBIANPATH/dev/shm"
    echo "Directory created: $DEBIANPATH/dev/shm"
else
    echo "Directory already exists: $DEBIANPATH/dev/shm"
fi

busybox mount -t tmpfs -o size=256M tmpfs $DEBIANPATH/dev/shm

# Mount sdcard
if [ ! -d "$DEBIANPATH/sdcard" ]; then
    mkdir -p "$DEBIANPATH/sdcard"
    echo "Directory created: $DEBIANPATH/sdcard"
else
    echo "Directory already exists: $DEBIANPATH/sdcard"
fi

busybox mount --bind /sdcard $DEBIANPATH/sdcard
# chroot into DEBIAN
#busybox chroot $DEBIANPATH /bin/su - root
#busybox chroot $DEBIANPATH /bin/su - root -c 'export XDG_RUNTIME_DIR=${TMPDIR} && export PULSE_SERVER=tcp:127.0.0.1:4713 && sudo service dbus start && su - droidmaster -c "env DISPLAY=:0 startxfce4"'
busybox chroot $DEBIANPATH /bin/su - $USERNAME -c 'export DISPLAY=:0 && export PULSE_SERVER=127.0.0.1 && dbus-launch --exit-with-session startxfce4'