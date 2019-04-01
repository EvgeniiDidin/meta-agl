KERNEL_IMAGETYPE = "uImage"
//PREFERRED_VERSION_gcc	= "arc-7.1.1"
WKS_FILE = "sdimage-hsdk.wks"
AGL_EXTRA_IMAGE_FSTYPES = "wic.xz"
IMAGE_BOOT_FILES = "uImage uboot.env"
IMAGE_INSTALL_append = " kernel-modules"

GCCVERSION ?= "gcc-arc-8.2.1"
BINUVERSION ?= "arc-2.31"
GLIBCVERSION ?= "arc-2018-09"

