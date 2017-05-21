FILESEXTRAPATHS_prepend := "${THISDIR}/linux:"

# Enable support for TP-Link TL-W722N USB Wifi adapter and RTL2832U DVB USB and USB Audio
# adapter.
SRC_URI += " file://disable_delay_printk.patch \
             file://cfg_mac_80211.cfg \
             file://ath9k_htc.cfg \
             file://rtl_sdr.cfg \
             file://usbaudio.cfg \
             file://ra2x00.cfg \
             file://0001-media-r820t-do-not-double-free-fe-tuner_priv-in-r820.patch \
             file://0002-media-r820t-remove-redundant-initializations-in-r820.patch \
             file://0003-media-r820t-avoid-potential-memcpy-buffer-overflow-i.patch \
             file://hciattach.cfg \
             file://pppd-rcar.cfg \
            "

KERNEL_CONFIG_FRAGMENTS_append = " ${WORKDIR}/ath9k_htc.cfg ${WORKDIR}/rtl_sdr.cfg"

SRC_URI_append_agl-porter-hibernate = " file://hibernation/0001-Add-Hibernation-kernel-base-code.patch \
                                        file://hibernation/0002-Add-Hibernation-arch-code-Only-R-CAR-M2W.patch \
                                        file://hibernation/0003-Add-sata-hibernation-code.patch \
                                        file://hibernation/0004-Add-firmware-hibernation-code.patch \
                                        file://hibernation/0005-Add-rcar-dma-hibernation-code.patch \
                                        file://hibernation/0006-Add-rcar-du-hibernation-code.patch \
                                        file://hibernation/0007-Add-rcar-i2c-hibernation-code.patch \
                                        file://hibernation/0008-Add-rcar-mmc-hibernation-code.patch \
                                        file://hibernation/0009-Add-hibernation-store-area.patch \
                                        file://hibernation/0010-Add-rcar-eth-hibernation-code.patch \
                                        file://hibernation/0011-Add-rcar-pci-hibernation-code.patch \
                                        file://hibernation/0012-Add-rcar-gpio-hibernation-code.patch \
                                        file://hibernation/0013-Add-rcar-spi-hibernation-code.patch \
                                        file://hibernation/0014-Add-rcar-sci-hibernation-code.patch \ 
                                        file://hibernation/0015-Add-rcar-usbphy-hibernation-code.patch \
                                        file://hibernation/hibernation.cfg \
                                       "

KERNEL_CONFIG_FRAGMENTS_append_agl-porter-hibernate += " ${WORKDIR}/hibernation/hibernation.cfg"
