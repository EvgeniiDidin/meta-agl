FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SRCREV = "${AUTOREV}"
BRANCH = "p-ti-u-boot-2016.05"

SRC_URI = "git://git.omapzoom.org/repo/u-boot.git;protocol=git;branch=${BRANCH}"
# This applies to the JACINTO 6 vayu board ... essentially it is dra7_evm.
SRC_URI_vayu     += "file://fix_builderror_gcc5.patch"
SRC_URI += " file://${UBOOT_ENV_BINARY}"

UBOOT_ENV = "uEnv"

do_deploy_append () {
    if [ "x${UBOOT_ENV}" != "x" ]
    then
        install ${WORKDIR}/${UBOOT_ENV_BINARY} ${DEPLOYDIR}/${UBOOT_ENV_IMAGE}
        ln -sf ${UBOOT_ENV_IMAGE} ${DEPLOYDIR}/${UBOOT_ENV_SYMLINK}
    fi
}

