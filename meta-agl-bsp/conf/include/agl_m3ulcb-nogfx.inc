require conf/include/agl_ulcb-nogfx.inc
SOC_FAMILY = "r8a7796"

# Mask graphic Pkgs
BBMASK += "gles-user-module|kernel-module-gles|wayland-kms|libgbm"
# Mask MMP recipes
BBMASK += "kernel-module-uvcs-drv|omx-user-module"
