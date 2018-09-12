SOC_FAMILY = "r8a7796"

# Mask graphic Pkgs
BBMASK += "gles-user-module|kernel-module-gles|wayland-kms|libgbm"
# Mask MMP recipes
BBMASK += "kernel-module-uvcs-drv|omx-user-module"


DISTRO_FEATURES_append = " sota"
OSTREE_KERNEL = "Image"
IMAGE_BOOT_FILES_sota = "m3ulcb-ota-bootfiles/* Image-r8a7796-m3ulcb.dtb"
OSTREE_BOOTLOADER ?= "u-boot"

WKS_FILE = "singlepart-noloader.wks"
AGL_EXTRA_IMAGE_FSTYPES = "wic.xz wic.bmap wic.xz.sha256sum"
