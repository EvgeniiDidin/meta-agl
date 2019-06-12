DISTRO_FEATURES_append = " agl-medium-arm-compiler"

# This disables the Freescale/NXP Vivante GPU driver and enables
# etnaviv support.
MACHINEOVERRIDES .= ":use-mainline-bsp"

# Disable the meta-freescale weston-init bbappend as it conflicts
# with AGL's.
BBMASK = "meta-freescale/recipes-graphics/wayland/weston-init"

# Set CMA size large enough to work with AGL
UBOOT_EXTLINUX_KERNEL_ARGS_append = " cma=512M"

# Generate WIC image also
AGL_EXTRA_IMAGE_FSTYPES = "wic.xz wic.bmap wic.xz.sha256sum"
AGL_DEFAULT_INITRAMFS_FSTYPES := ""
