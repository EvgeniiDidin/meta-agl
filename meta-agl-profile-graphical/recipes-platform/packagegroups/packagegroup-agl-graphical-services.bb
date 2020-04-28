DESCRIPTION = "The minimal set of packages for Connectivity Subsystem"
LICENSE = "MIT"

inherit packagegroup

PROVIDES = "${PACKAGES}"
PACKAGES = "\
    packagegroup-agl-graphical-services \
    packagegroup-agl-graphical-services-test \
    packagegroup-agl-graphical-services-devel \
    "

ALLOW_EMPTY_${PN} = "1"

RDEPENDS_${PN} = "\
    ${@bb.utils.contains('DISTRO_FEATURES', 'pipewire', 'agl-service-mediaplayer', '', d)} \
    ${@bb.utils.contains('DISTRO_FEATURES', 'pipewire', 'agl-service-radio', '', d)} \
    "

RDEPENDS_${PN}-test = "\
    ${@' '.join([x + '-test' for x in str.split(d.getVar('RDEPENDS_${PN}'))])} \
    "

RDEPENDS_${PN}-devel = "\
    ${@' '.join([x + '-dbg' for x in str.split(d.getVar('RDEPENDS_${PN}'))])} \
    ${@' '.join([x + '-coverage' for x in str.split(d.getVar('RDEPENDS_${PN}'))])} \
    "
