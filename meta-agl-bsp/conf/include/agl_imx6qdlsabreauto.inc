DISTRO_FEATURES_append = " agl-medium-arm-compiler"

# Caution: Hand-merge needed when original recipes are updated
#
# Here we only have selected lines from the following (and
# their included) files
#
# fslc-wayland.conf
# fsl-image-multimedia-full.bb
#

# fix build error
SECURITY_CFLAGS_pn-devil = "${SECURITY_NO_PIE_CFLAGS}"

# since krogoth, u-boot-fslc does not seem to handle imx6qsabreauto correctly
PREFERRED_PROVIDER_u-boot = "u-boot-imx"
PREFERRED_PROVIDER_virtual/bootloader = "u-boot-imx"
PREFERRED_PROVIDER_u-boot-mxsboot-native = "u-boot-imx"

#PREFERRED_VERSION_weston_mx6_forcevariable = "2.0.0"
