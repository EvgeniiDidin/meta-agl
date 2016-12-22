FILESEXTRAPATHS_prepend := "${THISDIR}/linux:"

# Enable support for TP-Link TL-W722N USB Wifi adapter and RTL2832U DVB USB and USB Audio
# adapter.
SRC_URI += " file://disable_delay_printk.patch \
             file://cfg_mac_80211.cfg \
             file://ath9k_htc.cfg \
             file://rtl_sdr.cfg \
             file://usbaudio.cfg \
             file://ra2x00.cfg \
            "

KERNEL_CONFIG_FRAGMENTS_append = " ${WORKDIR}/ath9k_htc.cfg ${WORKDIR}/rtl_sdr.cfg"
