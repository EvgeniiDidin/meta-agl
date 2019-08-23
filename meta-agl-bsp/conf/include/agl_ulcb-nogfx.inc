DISTRO_FEATURES_append = " sota"

OSTREE_KERNEL = "Image"
IMAGE_BOOT_FILES_sota = "renesas-ota-bootfiles/* Image-${DTB_SUFFIX}.dtb"
OSTREE_BOOTLOADER ?= "u-boot"

WKS_FILE = "singlepart-noloader.wks"
AGL_EXTRA_IMAGE_FSTYPES = "wic.xz wic.bmap wic.xz.sha256sum"

RENESAS_DATADIR = "/usr"

# Mask graphic Pkgs
BBMASK += "gles-user-module|kernel-module-gles|wayland-kms|libgbm"
# Mask MMP recipes
BBMASK += "kernel-module-uvcs-drv|omx-user-module"
