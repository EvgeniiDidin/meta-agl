MACHINE = "raspberrypi3"

#GPU_MEM = "512"
# Increase GPU_MEM for AGL apps (navi/poi)
GPU_MEM = "640"

ENABLE_CMA = "1"
CMA_LWM = "16"
CMA_HWM = "32"

CORE_IMAGE_EXTRA_INSTALL += "wayland weston"

MULTI_PROVIDER_WHITELIST += "virtual/libgl virtual/egl virtual/libgles1 virtual/libgles2"

KERNEL_DEVICETREE_append = " overlays/vc4-kms-v3d-overlay.dtb"
KERNEL_IMAGETYPE_sota = "uImage"
PREFERRED_VERSION_linux-raspberrypi = "4.4.%"
PREFERRED_VERSION_mesa = "12.%"

PREFERRED_PROVIDER_virtual/egl = "mesa"
PREFERRED_PROVIDER_virtual/libgles2 = "mesa"
PREFERRED_PROVIDER_virtual/libgl = "mesa"
PREFERRED_PROVIDER_virtual/mesa = "mesa"
PREFERRED_PROVIDER_jpeg = "jpeg"

MACHINE_FEATURES += "vc4graphics"

### Image classes, fstypes and (S)OTA

# normal image class is sdcard_image-rpi-gdp, for sota it is image_types_uboot & sdcard_image-rpi-ota
IMAGE_CLASSES += "${@bb.utils.contains('DISTRO_FEATURES', 'agl-ota', 'image_types_uboot sdcard_image-rpi-ota', 'sdcard_image-rpi-gdp', d)}"

# normal image is rpi-sdimg, for sota it is rpi-sdimg-ota
#IMAGE_FSTYPES += "${@bb.utils.contains('DISTRO_FEATURES', 'agl-ota', 'rpi-sdimg-ota', 'rpi-sdimg', d)}"
### both rpi-sdimg and rpi-sdimg-ota broken
IMAGE_FSTYPES += "ext4.xz ext4.bmap tar.xz"

KERNEL_IMAGETYPE_sota = "uImage"
PREFERRED_PROVIDER_virtual/bootloader_sota = "u-boot"
UBOOT_MACHINE_sota = "rpi_3_32b_defconfig"

# For libomxil
#LICENSE_FLAGS_WHITELIST = "commercial"

IMAGE_INSTALL_append = " kernel-modules linux-firmware "

# Psplash causes crash on first boot on RPi
IMAGE_FEATURES_remove = "splash"
