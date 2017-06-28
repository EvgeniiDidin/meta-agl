FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

# smack patches for handling bluetooth
SRC_URI_append_smack = "\
       file://0004-Smack-Assign-smack_known_web-label-for-kernel-thread.patch \
"

# Fix CVE-2017-1000364 by backporting the patches from upstream for 4.9
SRC_URI_append = "\
       file://0001-mm-larger-stack-guard-gap-between-vmas.patch \
       file://0002-Allow-stack-to-grow-up-to-address-space-limit.patch \
       file://0003-mm-fix-new-crash-in-unmapped_area_topdown.patch \
"

# Extra configuration options
SRC_URI += "file://fanotify.cfg \
            file://uinput.cfg \
            file://hid.cfg "
KERNEL_CONFIG_FRAGMENTS_append = " ${WORKDIR}/fanotify.cfg ${WORKDIR}/uinput.cfg ${WORKDIR}/hid.cfg"

# Enable support for TP-Link TL-W722N USB Wifi adapter
SRC_URI += " file://ath9k_htc.cfg "
KERNEL_CONFIG_FRAGMENTS_append = " ${WORKDIR}/ath9k_htc.cfg"

# Enable support for RTLSDR
SRC_URI += " file://rtl_sdr.cfg "
KERNEL_CONFIG_FRAGMENTS_append = " ${WORKDIR}/rtl_sdr.cfg"

# Enable support for smack
KERNEL_CONFIG_FRAGMENTS_append_smack = "\
       ${WORKDIR}/audit.cfg \
       ${WORKDIR}/smack.cfg \
       ${WORKDIR}/smack-default-lsm.cfg \
"

# file comes out of  meta-agl-bsp/recipes-kernel/linux/linux_%.bbappend
KERNEL_CONFIG_FRAGMENTS_append = " ${WORKDIR}/can-bus.cfg"
