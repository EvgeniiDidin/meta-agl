DESCRIPTION = "The minimal set of packages for AGL core Connectivity Subsystem"
LICENSE = "MIT"

inherit packagegroup

PACKAGES = "\
    packagegroup-agl-core-services \
    "

ALLOW_EMPTY_${PN} = "1"

RDEPENDS_${PN} += "\
agl-service-data-persistence \
agl-service-network \
agl-service-platform-info \
    "
