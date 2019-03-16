DESCRIPTION = "AGL low level user database binding"
HOMEPAGE = "https://git.automotivelinux.org/apps/agl-service-data-persistence/"
SECTION = "base"

LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://LICENSE;md5=8089a3c40cff9caffd1b9ba5aa3dfd67"

SRC_URI = "git://gerrit.automotivelinux.org/gerrit/apps/agl-service-data-persistence;protocol=https;branch=${AGL_BRANCH}"
SRCREV  = "${AGL_APP_REVISION}"

inherit cmake aglwgt pkgconfig

PV = "1.0+git${SRCPV}"
S = "${WORKDIR}/git"

DEPENDS += " af-binder json-c gdbm "

