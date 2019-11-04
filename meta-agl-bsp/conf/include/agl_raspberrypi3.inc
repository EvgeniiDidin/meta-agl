# Maximum memory allowed to be assigned
GPU_MEM = "128"

ENABLE_CMA = "1"
# Add CMA to the kernel arguments for SOTA
OSTREE_KERNEL_ARGS_sota_append = " cma=256M"
CMA_LWM = "16"
CMA_HWM = "32"

MULTI_PROVIDER_WHITELIST += "virtual/libgl virtual/egl virtual/libgles1 virtual/libgles2"

# The correct config for a Raspberry Pi 3 in 32bit mode
UBOOT_MACHINE = "rpi_3_32b_config"

KERNEL_IMAGETYPE = "uImage"

PREFERRED_VERSION_linux-raspberrypi = "4.19%"
RPI_KERNEL_DEVICETREE_remove_raspberrypi3 = "bcm2708-rpi-0-w.dtb"
RPI_KERNEL_DEVICETREE_OVERLAYS_remove_raspberrypi3 = "overlays/lirc-rpi.dtbo"
RPI_KERNEL_DEVICETREE_OVERLAYS_append_raspberrypi3 = " overlays/vc4-fkms-v3d.dtbo"

# Set appropriate version of Mesa for Raspberry Pi 3 and 4
PREFERRED_VERSION_mesa = "19.1%"

MACHINE_FEATURES += "vc4graphics"

# Switch to firmware KMS to support the official DSI touchscreen display
VC4DTBO = "vc4-fkms-v3d"

# For libomxil
#LICENSE_FLAGS_WHITELIST = "commercial"

IMAGE_INSTALL_append = " kernel-modules linux-firmware-rpidistro-bcm43430 linux-firmware-rpidistro-bcm43455 create-combined-dtb "

# Psplash causes crash on first boot on RPi
IMAGE_FEATURES_remove = "splash"

# Build updatable image. Only takes effect when sota.bbclass is inherited
DISTRO_FEATURES_append = " sota"

# Create WIC images to write to SD cards.
WKS_FILE = "sdimage-raspberrypi.wks"
AGL_EXTRA_IMAGE_FSTYPES = "wic.xz wic.bmap wic.xz.sha256sum"
IMAGE_BOOT_FILES = "bcm2835-bootfiles/* \
                 ${@make_dtb_boot_files(d)} \
                 ${@bb.utils.contains('KERNEL_IMAGETYPE', 'uImage', \
                    '${KERNEL_IMAGETYPE} u-boot.bin;${SDIMG_KERNELIMAGE} boot.scr', \
                    '${KERNEL_IMAGETYPE};${SDIMG_KERNELIMAGE}', d)} \
                 "
do_image_wic[depends] += " \
    bcm2835-bootfiles:do_deploy \
    ${@bb.utils.contains('KERNEL_IMAGETYPE', 'uImage', 'u-boot:do_deploy', '',d)} \
    "
