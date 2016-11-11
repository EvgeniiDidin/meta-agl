MACHINE = "dra7xx-evm"

#-------------------------------------------------
## Graphics section ##
#-------------------------------------------------
PACKAGES_GFX_${MACHINE} = "omapdrm-pvr"

# Enable Gfx Pkgs
MACHINE_FEATURES_append = " sgx"
MULTI_PROVIDER_WHITELIST += "virtual/libgl virtual/egl virtual/libgles1 virtual/libgles2"

DEPENDS_remove = "virtual/libgl"

# Preferred providers
PREFERRED_PROVIDER_virtual/libgles1 = ""
PREFERRED_PROVIDER_virtual/libgles2 = "ti-sgx-ddk-um"
PREFERRED_PROVIDER_virtual/egl      = "ti-sgx-ddk-um"
PREFERRED_PROVIDER_virtual/mesa     = "mesa-gl"
PREFERRED_PROVIDER_libgbm           = "libgbm"

#Preferred versions
PREFERRED_VERSION_libgbm            = "10.0.0"

#-------------------------------------------------
## Multimedia section ##
#-------------------------------------------------

GSTREAMER_PLUGINS = " \
     gstreamer1.0-plugins-bad-meta \
     gstreamer1.0-plugins-ducati \
     gstreamer1.0-plugins-vpe \
"
PACKAGES_MULTIMEDIA   = " \
    ipumm-fw \
    pulseaudio-misc      \
    ${GSTREAMER_PLUGINS} \
"

PREFERRED_VERSION_ipumm-fw          = "3.00.08.02"

PREFERRED_PROVIDER_virtual/kernel  = "linux-ti-staging"
PREFERRED_VERSION_virtual/kernel  = "4.4"

# Distribution-specific runtime components
IMAGE_INSTALL_append = " \
     ${PACKAGES_GFX}     \
     ${PACKAGES_MULTIMEDIA}     \
     cmem \
"

## ATTENTION, this is needed right now to build meta-ti with AGL: ##
## due to meta-ti being based on YP 1.8 instead of YP 2.0
BBMASK  = "meta-ti/.*eudev"



IMAGE_CLASSES_append_sota = " image_types_uboot sdcard_image-dra7xx-evm-ota"
IMAGE_FSTYPES += "${@bb.utils.contains('DISTRO_FEATURES', 'agl-ota', 'dra7xx-evm-sdimg-ota  ', '', d)}"
