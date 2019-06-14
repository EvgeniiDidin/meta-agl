SUMMARY = "AFB helpers library"
DESCRIPTION = "AFB helpers library to ease JSON object manipulation and binding interaction"

LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/Apache-2.0;md5=89aea4e17d99a7cacdbeed46a0096b10"

SRC_URI = "git://gerrit.automotivelinux.org/gerrit/src/libafb-helpers;protocol=https;branch=${AGL_BRANCH}"
SRCREV = "547374849a76225b1a6a0dd8bb84ae27a601f19d"

PV = "${AGLVERSION}"
S  = "${WORKDIR}/git"

DEPENDS_append = " af-binder jq"

