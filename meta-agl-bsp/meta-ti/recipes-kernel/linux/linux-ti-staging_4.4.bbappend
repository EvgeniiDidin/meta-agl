FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SRC_URI_append = " file://ramblock_nbd.cfg"
SRC_URI_append = " file://smack.cfg"
SRC_URI_append = " file://smack-default-lsm.cfg"

KERNEL_CONFIG_FRAGMENTS_append = " ${WORKDIR}/ramblock_nbd.cfg ${WORKDIR}/smack.cfg ${WORKDIR}/smack-default-lsm.cfg"

SRCREV = "${AUTOREV}"

PV = "4.4.30+git${SRCPV}"

KERNEL_GIT_URI = "git://git.omapzoom.org/kernel/omap"
BRANCH = "p-ti-lsk-linux-4.4.y-next"
SRC_URI_append = " \
                "

KERNEL_DEVICETREE_dra7xx-evm_append = " dra7-evm-vision.dtb dra72-evm-vision.dtb am57xx-evm.dtb"
