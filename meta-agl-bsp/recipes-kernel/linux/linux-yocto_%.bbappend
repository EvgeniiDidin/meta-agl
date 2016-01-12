FILESEXTRAPATHS_prepend := "${THISDIR}/linux-yocto:"

# Extra configuration options for the QEMU kernel
SRC_URI += "file://0001-fanotify-fix-notification-of-groups-with-inode-mount.patch \
            file://fanotify.cfg \
            file://uinput.cfg \
            "
