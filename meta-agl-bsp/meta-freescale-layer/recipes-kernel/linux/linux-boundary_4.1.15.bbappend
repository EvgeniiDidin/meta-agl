FILESEXTRAPATHS_prepend := "${THISDIR}/linux-boundary-4.1.15:"
SRC_URI = "git://github.com/boundarydevices/linux-imx6.git;branch=${SRCBRANCH} \
           file://defconfig \
"
