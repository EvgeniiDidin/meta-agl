DESCRIPTION = "The minimal set of packages required by AGL"
LICENSE = "MIT"

inherit packagegroup

PACKAGES = "\
    packagegroup-agl-image-minimal \
    profile-agl-minimal \
    "

ALLOW_EMPTY_${PN} = "1"

RDEPENDS_${PN} += "\
    packagegroup-agl-core-boot \
    "


RDEPENDS_${PN} += "\
    packagegroup-agl-core-connectivity \
    packagegroup-agl-core-navigation \
    packagegroup-agl-core-multimedia \
    packagegroup-agl-core-os-commonlibs \
    packagegroup-agl-core-services \
    packagegroup-agl-core-security \
    "

RDEPENDS_profile-agl-minimal = "${PN}"
