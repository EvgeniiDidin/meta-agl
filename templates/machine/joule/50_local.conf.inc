MACHINE = "intel-corei7-64"
INTEL_MACHINE_SUBTYPE = "broxton-m"
PREFERRED_VERSION_linux-yocto_intel-corei7-64 ?= "4.4%"

APPEND += "console=ttyS2,115200n8 video=efifb maxcpus=4 noxsave reboot=efi kmemleak=off"

IMAGE_INSTALL_append = " linux-firmware-iwlwifi-8000c linux-firmware-ibt-11-5"
IMAGE_INSTALL_append = " \
        libva \
        va-intel \
        gstreamer-vaapi-1.0 "
