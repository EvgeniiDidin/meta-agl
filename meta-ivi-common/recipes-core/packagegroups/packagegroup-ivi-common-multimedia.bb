SUMMARY = "The middlewares for AGL IVI profile"
DESCRIPTION = "A set of common packages required by Multimedia Subsystem"

LICENSE = "MIT"

inherit packagegroup

PACKAGES = "\
    packagegroup-ivi-common-multimedia \
    "

ALLOW_EMPTY_${PN} = "1"

RDEPENDS_${PN} += "\
    alsa-lib \
    alsa-utils \
    gstreamer1.0-meta-base \
    "
