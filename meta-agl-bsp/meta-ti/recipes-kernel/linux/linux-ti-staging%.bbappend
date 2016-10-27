FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SRC_URI_append = " file://ramblock_nbd.cfg"
SRC_URI_append = " file://smack.cfg"
SRC_URI_append = " file://smack-default-lsm.cfg"

KERNEL_CONFIG_FRAGMENTS_append = " ${WORKDIR}/ramblock_nbd.cfg ${WORKDIR}/smack.cfg ${WORKDIR}/smack-default-lsm.cfg"
