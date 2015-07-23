IMAGE_INSTALL = "packagegroup-core-boot-agl ${ROOTFS_PKGMANAGE_BOOTSTRAP} ${CORE_IMAGE_EXTRA_INSTALL}"

IMAGE_LINGUAS = " "

LICENSE = "MIT"

inherit core-image buildhistory

IMAGE_ROOTFS_SIZE ?= "8192"

IMAGE_FEATURES += "splash package-management ssh-server-dropbear"

BUILDHISTORY_COMMIT = "1"
