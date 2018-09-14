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
SRCREV = "fbdf29b8af47f567f472a459842d262e8abf5b9c"

PV = "${AGLVERSION}"
S  = "${WORKDIR}/git"

