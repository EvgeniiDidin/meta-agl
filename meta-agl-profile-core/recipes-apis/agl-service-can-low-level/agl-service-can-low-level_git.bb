SUMMARY     = "Low level CAN service"
DESCRIPTION = "AGL Service application for read and decode CAN messages"
HOMEPAGE    = "https://gerrit.automotivelinux.org/gerrit/#/admin/projects/apps/low-level-can-service"
SECTION     = "apps"

LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/Apache-2.0;md5=89aea4e17d99a7cacdbeed46a0096b10"

SRC_URI = "gitsm://gerrit.automotivelinux.org/gerrit/apps/agl-service-can-low-level;protocol=https;branch=${AGL_BRANCH}"
SRCREV = "7c5d80deacad2a1f6943dd0b77449c3f6e20fdfc"

PV = "5.0+git${SRCPV}"
S  = "${WORKDIR}/git"

RDEPENDS_${PN} = "dev-mapping"

inherit cmake aglwgt pkgconfig

