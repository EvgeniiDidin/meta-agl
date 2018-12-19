SUMMARY     = "Low level CAN generator"
DESCRIPTION = "Generator used to customize low level CAN service with customs signals"
SECTION     = "devel"

LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/Apache-2.0;md5=89aea4e17d99a7cacdbeed46a0096b10"

inherit cmake pkgconfig
BBCLASSEXTEND = "nativesdk"
DEPENDS = " cmake-apps-module"

SRC_URI = "gitsm://gerrit.automotivelinux.org/gerrit/src/low-level-can-generator;protocol=https;branch=${AGL_BRANCH}"
SRCREV = "b7d44a2d155a1199c25b783b915fd8ba3ce42a69"

PV = "${AGLVERSION}"
S  = "${WORKDIR}/git"

