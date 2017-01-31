FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SRC_URI_append = " file://0001-fix-arm-trusted-firmware-build-for-gcc6.patch"
SRC_URI_append_h3ulcb = " file://0001-fix-build-for-gcc6-for-h3-init_dram.patch"

