FILESEXTRAPATHS_prepend := "${THISDIR}/linux-yocto:"

# Extra configuration options for the QEMU kernel
SRC_URI += "file://hciattach.cfg \
            "
