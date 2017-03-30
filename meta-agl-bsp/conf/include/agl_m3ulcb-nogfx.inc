SOC_FAMILY = "r8a7796"

IMAGE_INSTALL_append = " \
	weston-bin \
"

# Mask graphic Pkgs
BBMASK = "gles-user-module|kernel-module-gles|wayland-kms|libgbm"
# Mask MMP recipes
BBMASK .= "|kernel-module-uvcs-drv|omx-user-module"

BBMASK .= "|meta-renesas-rcar-gen3/meta-rcar-gen3/recipes-forward-port/"

OSTREE_KERNEL = "Image"
IMAGE_BOOT_FILES_sota = "m3ulcb-ota-bootfiles/* Image-r8a7796-m3ulcb.dtb"
OSTREE_BOOTLOADER ?= "u-boot"
