FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SRC_URI += " \
    file://0001-fix-arm-trusted-firmware-build-for-gcc6.patch \
    file://0001-fix-build-for-gcc6-for-h3-init_dram.patch \
    "
