FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI_append_ulcb = " \
    file://0001-arm64-dts-renesas-preserve-drm-HDMI-connector-naming.patch \
    file://disable_most.cfg \
"

SRC_URI_remove_ulcb = " \
    file://0113-arm64-dts-ulcb-kf-increase-SDIO-frequency-for-WLAN-c.patch \
"
