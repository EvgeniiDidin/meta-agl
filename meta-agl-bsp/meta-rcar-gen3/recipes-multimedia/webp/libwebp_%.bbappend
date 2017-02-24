FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

# Add W/A patch for linaro gcc.
# This patch disabled neon. (undefined #WEBP_USE_NEON)

SRC_URI_append = " file://disabled_arm_neon_for_0.5.1.diff"
#Remove patch for 0.5.0
SRC_URI_remove = " file://disabled_arm_neon.diff"
