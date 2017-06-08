#GPU_MEM = "512"
# Increase GPU_MEM for AGL apps (navi/poi)
GPU_MEM = "640"

ENABLE_CMA = "1"
CMA_LWM = "16"
CMA_HWM = "32"

CORE_IMAGE_EXTRA_INSTALL += "wayland weston"

MULTI_PROVIDER_WHITELIST += "virtual/libgl virtual/egl virtual/libgles1 virtual/libgles2"

KERNEL_IMAGETYPE = "uImage"
KERNEL_DEVICETREE_append = " overlays/vc4-kms-v3d-overlay.dtb"
PREFERRED_VERSION_linux-raspberrypi = "4.4.%"
PREFERRED_VERSION_mesa = "12.%"

PREFERRED_PROVIDER_virtual/egl = "mesa"
PREFERRED_PROVIDER_virtual/libgles2 = "mesa"
PREFERRED_PROVIDER_virtual/libgl = "mesa"
PREFERRED_PROVIDER_virtual/mesa = "mesa"
PREFERRED_PROVIDER_jpeg = "jpeg"

MACHINE_FEATURES += "vc4graphics"

# For libomxil
#LICENSE_FLAGS_WHITELIST = "commercial"

IMAGE_INSTALL_append = " kernel-modules linux-firmware "

# Psplash causes crash on first boot on RPi
IMAGE_FEATURES_remove = "splash"

# Build updatable image. Only takes effect when sota.bbclass is inherited
DISTRO_FEATURES_append = " sota"

