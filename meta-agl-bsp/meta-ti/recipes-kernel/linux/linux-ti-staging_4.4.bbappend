FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SRC_URI_append = " file://ramblock_nbd.cfg"
KERNEL_CONFIG_FRAGMENTS_append = " ${WORKDIR}/ramblock_nbd.cfg"

SRC_URI_append = " file://smack.cfg"
SRC_URI_append = " file://smack-default-lsm.cfg"
KERNEL_CONFIG_FRAGMENTS_append = " ${WORKDIR}/smack.cfg ${WORKDIR}/smack-default-lsm.cfg"

# Enable support for TP-Link TL-W722N USB Wifi adapter
SRC_URI_append = " file://ath9k_htc.cfg"
KERNEL_CONFIG_FRAGMENTS_append = " ${WORKDIR}/ath9k_htc.cfg"

# Enable support for RTLSDR
SRC_URI_append = " file://rtl_sdr.cfg"
KERNEL_CONFIG_FRAGMENTS_append = " ${WORKDIR}/rtl_sdr.cfg"

# Enable support for Bluetooth HCI USB devices
SRC_URI_append = " file://btusb.cfg"
KERNEL_CONFIG_FRAGMENTS_append = " ${WORKDIR}/btusb.cfg"

SRCREV = "${AUTOREV}"

PV = "4.4.30+git${SRCPV}"

KERNEL_GIT_URI = "git://git.omapzoom.org/kernel/omap"
BRANCH = "p-ti-lsk-linux-4.4.y-next"
SRC_URI_append = " \
                "

KERNEL_DEVICETREE_dra7xx-evm_append = " dra7-evm-vision.dtb dra72-evm-vision.dtb am57xx-evm.dtb"
