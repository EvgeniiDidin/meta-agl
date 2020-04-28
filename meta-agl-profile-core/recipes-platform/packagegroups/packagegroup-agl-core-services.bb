DESCRIPTION = "The minimal set of packages for AGL core Connectivity Subsystem"
LICENSE = "MIT"

inherit packagegroup

PROVIDES = "${PACKAGES}"
PACKAGES = "\
    packagegroup-agl-core-services \
    packagegroup-agl-core-services-test \
    packagegroup-agl-core-services-devel \
    "

RDEPENDS_${PN} += "\
    agl-service-data-persistence \
    agl-service-network \
    agl-service-platform-info \
    "

RDEPENDS_${PN}-test = "\
    ${@' '.join([x + '-test' for x in str.split(d.getVar('RDEPENDS_${PN}'))])} \
    afb-test \
    "

RDEPENDS_${PN}-devel = "\
    ${@' '.join([x + '-dbg' for x in str.split(d.getVar('RDEPENDS_${PN}'))])} \
    ${@' '.join([x + '-coverage' for x in str.split(d.getVar('RDEPENDS_${PN}'))])} \
    "
