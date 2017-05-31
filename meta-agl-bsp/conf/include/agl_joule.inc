INTEL_MACHINE_SUBTYPE = "broxton-m"
PREFERRED_VERSION_linux-yocto_intel-corei7-64 ?= "4.4%"

APPEND += "console=ttyS2,115200n8 video=efifb maxcpus=4 noxsave reboot=efi kmemleak=off"

IMAGE_INSTALL_append = " linux-firmware-iwlwifi-8000c linux-firmware-ibt-11-5"
IMAGE_INSTALL_append = " \
        libva \
        va-intel \
        gstreamer1.0-vaapi"
OSTREE_BOOTLOADER ?= "u-boot"

AGL_DEFAULT_IMAGE_FSTYPES := "wic hddimg"
INITRD_LIVE = "${DEPLOY_DIR_IMAGE}/${INITRD_IMAGE_LIVE}-${MACHINE}.ext4.gz"
NOISO = "1"
