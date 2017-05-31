# Maximum memory allowed to be assigned
GPU_MEM = "255"

ENABLE_CMA = "1"
CMA_LWM = "16"
CMA_HWM = "32"

MULTI_PROVIDER_WHITELIST += "virtual/libgl virtual/egl virtual/libgles1 virtual/libgles2"

# The correct config for a Raspberry Pi 3 in 32bit mode
UBOOT_MACHINE = "rpi_3_32b_config"

KERNEL_IMAGETYPE = "uImage"

MACHINE_FEATURES += "vc4graphics"

# For libomxil
#LICENSE_FLAGS_WHITELIST = "commercial"

IMAGE_INSTALL_append = " kernel-modules linux-firmware "

# Psplash causes crash on first boot on RPi
IMAGE_FEATURES_remove = "splash"

# Build updatable image. Only takes effect when sota.bbclass is inherited
DISTRO_FEATURES_append = " sota"

# Add the custom rpi-sdimg output format
AGL_EXTRA_IMAGE_FSTYPES  = " rpi-sdimg.xz"

# Use the AGL default ext4.xz to generate the rpi-sdimg
SDIMG_ROOTFS_TYPE = "ext4.xz"
