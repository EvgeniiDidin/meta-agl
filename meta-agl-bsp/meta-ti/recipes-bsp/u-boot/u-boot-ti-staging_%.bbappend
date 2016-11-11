FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

# This applies to the JACINTO 6 vayu board ... essentially it is dra7_evm.
SRC_URI_vayu     += "file://fix_builderror_gcc5.patch"

BRANCH = "p-ti-u-boot-2016.05"
SRC_URI = "git://git.omapzoom.org/repo/u-boot.git;protocol=git;branch=${BRANCH}"
SRCREV = "${AUTOREV}"

