DESCRIPTION = "The minimal set of packages for Graphics Subsystem"
LICENSE = "MIT"

inherit packagegroup

PACKAGES = "\
    packagegroup-agl-core-graphics \
    "

ALLOW_EMPTY_${PN} = "1"

RDEPENDS_${PN} += "\
    ${@bb.utils.contains("DISTRO_FEATURES", "sysvinit", "weston-init", "", d)} \
    "
