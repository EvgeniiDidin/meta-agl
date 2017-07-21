FILESEXTRAPATHS_prepend := "${THISDIR}/linux-yocto:"

# Extra configuration options for the QEMU kernel
SRC_URI += "file://fanotify.cfg \
            file://uinput.cfg \
            file://hid.cfg \
            file://drm.cfg \
            "

# Enable support for TP-Link TL-W722N USB Wifi adapter
SRC_URI += " file://ath9k_htc.cfg \
           "

# Enable support for RTLSDR
SRC_URI += " file://rtl_sdr.cfg \
           "

# disk drivers for vmdk
SRC_URI_append_qemux86 = " file://vbox-vmware-sata.cfg "
SRC_URI_append_qemux86-64 = " file://vbox-vmware-sata.cfg "
