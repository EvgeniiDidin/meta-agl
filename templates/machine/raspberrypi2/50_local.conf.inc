MACHINE = "raspberrypi2"

GPU_MEM = "128"

CORE_IMAGE_EXTRA_INSTALL += "wayland weston"

MULTI_PROVIDER_WHITELIST += "virtual/libgl virtual/egl virtual/libgles1 virtual/libgles2"
IMAGE_CLASSES += "sdcard_image-rpi-gdp"
IMAGE_FSTYPES += "tar.bz2 ext3 rpi-sdimg"
IMAGE_CLASSES_append_sota = " image_types_uboot sdcard_image-rpi-ota"
IMAGE_CLASSES_remove_sota = " sdcard_image-rpi-gdp"
IMAGE_FSTYPES += "${@bb.utils.contains('DISTRO_FEATURES', 'agl-ota', 'rpi-sdimg-ota', '', d)}"
IMAGE_FSTYPES_remove_sota = "rpi-sdimg"
IMAGE_FSTYPES_remove_sota = "rpi-sdimg"

KERNEL_DEVICETREE_append = " overlays/vc4-kms-v3d-overlay.dtb"
KERNEL_IMAGETYPE_sota = "uImage"
PREFERRED_VERSION_linux-raspberrypi = "4.4.%"
PREFERRED_VERSION_mesa = "11.%"

PREFERRED_PROVIDER_virtual/egl = "mesa"
PREFERRED_PROVIDER_virtual/libgles2 = "mesa"
PREFERRED_PROVIDER_virtual/libgl = "mesa"
PREFERRED_PROVIDER_virtual/mesa = "mesa"
PREFERRED_PROVIDER_jpeg = "jpeg"

UBOOT_MACHINE_sota = "rpi_3_32b_defconfig"
PREFERRED_PROVIDER_virtual/bootloader_sota = "u-boot"
# For libomxil
#LICENSE_FLAGS_WHITELIST = "commercial"

# Psplash causes crash on first boot on RPi
IMAGE_FEATURES_remove = "splash"
