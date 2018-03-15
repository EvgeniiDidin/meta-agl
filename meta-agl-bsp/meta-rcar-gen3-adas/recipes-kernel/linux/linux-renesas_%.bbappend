FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI_append = " \
    file://0001-arm64-dts-renesas-preserve-drm-HDMI-connector-naming.patch \
"
