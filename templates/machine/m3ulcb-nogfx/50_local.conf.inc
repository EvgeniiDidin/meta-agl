MACHINE = "m3ulcb"
SOC_FAMILY = "r8a7796"

IMAGE_INSTALL_append = " \
	weston-bin \
"

# Mask graphic Pkgs
BBMASK = "gles-user-module|kernel-module-gles|wayland-kms|libgbm"
# Mask MMP recipes
BBMASK .= "|kernel-module-uvcs|omx-user-module"

