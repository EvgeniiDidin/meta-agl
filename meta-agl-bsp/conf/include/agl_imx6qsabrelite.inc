IMAGE_INSTALL_append = " \
    packagegroup-fsl-tools-gpu \
    packagegroup-fsl-gstreamer1.0 \
    packagegroup-imx-tools-audio \
    weston weston-init weston-examples \
"

# fsl-image-multimedia-full.bb

IMAGE_INSTALL_append = " \
    packagegroup-fsl-gstreamer1.0-full \
"

# fix build error

SECURITY_CFLAGS_pn-devil = "${SECURITY_NO_PIE_CFLAGS}"

PREFERRED_PROVIDER_virtual/kernel = "linux-boundary"

PREFERRED_PROVIDER_u-boot = "u-boot-boundary"
PREFERRED_PROVIDER_virtual/bootloader = "u-boot-boundary"
PREFERRED_PROVIDER_u-boot-mxsboot-native = "u-boot-boundary"
MACHINE_ESSENTIAL_EXTRA_RDEPENDS += " u-boot-boundary"

UBOOT_MACHINE = "nitrogen6q_config"
SPL_BINARY = ""
UBOOT_SUFFIX_SDCARD = "imx"
IMAGE_BOOTLOADER = "u-boot"

# force generate sdcard image also
AGL_DEFAULT_IMAGE_FSTYPES := "sdcard.xz"
AGL_DEFAULT_INITRAMFS_FSTYPES := ""

PREFERRED_VERSION_weston_mx6_forcevariable = "2.0.0"
