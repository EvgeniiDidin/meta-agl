SUMMARY = "An AGL small image just capable of allowing a device to boot."

IMAGE_INSTALL = "packagegroup-core-boot-agl ${ROOTFS_PKGMANAGE_BOOTSTRAP} ${CORE_IMAGE_EXTRA_INSTALL}"

IMAGE_LINGUAS = " "

LICENSE = "MIT"

inherit core-image

IMAGE_ROOTFS_SIZE ?= "8192"

IMAGE_INSTALL_append = "\
    packagegroup-agl-core \
    "
