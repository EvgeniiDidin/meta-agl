FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

# smack patches for handling bluetooth
SRC_URI_append_smack = "\
       file://0001-Smack-File-receive-for-sockets.patch \
       file://0002-smack-fix-cache-of-access-labels.patch \
       file://0003-Smack-ignore-null-signal-in-smack_task_kill.patch \
       file://0004-Smack-Assign-smack_known_web-label-for-kernel-thread.patch \
"

# Extra configuration options
SRC_URI += "file://smack.cfg \
            file://smack-default-lsm.cfg \
            file://fanotify.cfg \
            file://uinput.cfg \
            file://hid.cfg "
KERNEL_CONFIG_FRAGMENTS_append = " ${WORKDIR}/smack.cfg ${WORKDIR}/smack-default-lsm.cfg ${WORKDIR}/fanotify.cfg ${WORKDIR}/uinput.cfg ${WORKDIR}/hid.cfg"

# Enable support for TP-Link TL-W722N USB Wifi adapter
SRC_URI += " file://ath9k_htc.cfg "
KERNEL_CONFIG_FRAGMENTS_append = " ${WORKDIR}/ath9k_htc.cfg"

# Enable support for RTLSDR
SRC_URI += " file://rtl_sdr.cfg "
KERNEL_CONFIG_FRAGMENTS_append = " ${WORKDIR}/rtl_sdr.cfg"
