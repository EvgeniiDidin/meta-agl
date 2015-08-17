SUMMARY = "The middlewares for AGL IVI profile"
DESCRIPTION = "A set of packagegroups which contain common packages required by AGL Distribution"
LICENSE = "MIT"

inherit packagegroup

PACKAGES = "\
    packagegroup-ivi-common \
    "

ALLOW_EMPTY_${PN} = "1"

RDEPENDS_${PN} += "\
    packagegroup-ivi-common-automotive \
    packagegroup-ivi-common-connectivity \
    packagegroup-ivi-common-graphics \
    packagegroup-ivi-common-multimedia \
    packagegroup-ivi-common-navi-lbs \
    packagegroup-ivi-common-os-commonlibs \
    packagegroup-ivi-common-speech-services \
    packagegroup-ivi-common-security \
    packagegroup-ivi-common-kernel \
    "
