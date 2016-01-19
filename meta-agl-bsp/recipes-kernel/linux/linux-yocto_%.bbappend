FILESEXTRAPATHS_prepend := "${THISDIR}/linux-yocto:"

# Extra configuration options for the QEMU kernel
SRC_URI += "file://fanotify.cfg \
            file://uinput.cfg \
            file://hid.cfg \
            "
