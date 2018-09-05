FILESEXTRAPATHS_prepend := "${THISDIR}/u-boot:"

SRC_URI_append = " \
    file://0001-fixup-build-with-gcc7.patch \
"

# Config names have changed in mainline u-boot since 2015.04,
#  here we want to use the old ones.
UBOOT_MACHINE = "${BOARD_NAME}_defconfig"

# Also override the override
UBOOT_MACHINE_sota = "${BOARD_NAME}_defconfig"

do_deploy_prepend() {
    ln -sf ${B}/${UBOOT_SREC} ${S}/${UBOOT_SREC}
}
