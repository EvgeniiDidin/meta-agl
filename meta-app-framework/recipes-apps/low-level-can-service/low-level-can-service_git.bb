SUMMARY     = "Low level CAN service"
DESCRIPTION = "AGL Service application for read and decode CAN messages"
HOMEPAGE    = "https://gerrit.automotivelinux.org/gerrit/#/admin/projects/apps/low-level-can-service"
SECTION     = "apps"

LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/Apache-2.0;md5=89aea4e17d99a7cacdbeed46a0096b10"

SRC_URI = "gitsm://gerrit.automotivelinux.org/gerrit/apps/low-level-can-service;protocol=https;branch=${AGL_BRANCH}"
SRCREV = "9bc0d4c2e996276d0a51bf1d695fb44192f872eb"

PV = "4.0+git${SRCPV}"
S  = "${WORKDIR}/git"

inherit cmake aglwgt pkgconfig

