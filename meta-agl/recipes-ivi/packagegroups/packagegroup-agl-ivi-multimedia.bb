SUMMARY = "The middlewares for AGL IVI profile"
DESCRIPTION = "The set of packages required by Multimedia Subsystem"
LICENSE = "MIT"

inherit packagegroup

PACKAGES = "\
    packagegroup-agl-ivi-multimedia \
    "

ALLOW_EMPTY_${PN} = "1"

RDEPENDS_${PN} += "\
    "
