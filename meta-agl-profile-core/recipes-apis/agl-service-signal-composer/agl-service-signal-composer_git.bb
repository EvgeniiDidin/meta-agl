SUMMARY     = "agl-service-signal-composer"
DESCRIPTION = "AGL High Level Signaling service to handle CAN, LIN, and others signaling sources"
HOMEPAGE    = "https://git.automotivelinux.org/apps/agl-service-signal-composer/"
SECTION     = "apps"

LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/Apache-2.0;md5=89aea4e17d99a7cacdbeed46a0096b10"

inherit cmake pkgconfig aglwgt ptest

DEPENDS += "lua lua-native"
RDEPENDS_${PN} += "lua"

SRC_URI = "gitsm://git.automotivelinux.org/apps/agl-service-signal-composer;protocol=https;branch=${AGL_BRANCH}"
SRCREV = "74c0e1f8e2a6dbc5b7485c3b06e12d4ad7f43c6b"

PV = "${AGLVERSION}"
S  = "${WORKDIR}/git"

