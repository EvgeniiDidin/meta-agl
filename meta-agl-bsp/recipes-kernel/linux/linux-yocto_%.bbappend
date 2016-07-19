FILESEXTRAPATHS_prepend := "${THISDIR}/linux-yocto:"

# Extra configuration options for the QEMU kernel
SRC_URI += "file://fanotify.cfg \
            file://uinput.cfg \
            file://hid.cfg \
            "

# disk drivers for vmdk
SRC_URI_append_qemux86 = " file://vbox-vmware-sata.cfg "
SRC_URI_append_qemux86_64 = " file://vbox-vmware-sata.cfg "
