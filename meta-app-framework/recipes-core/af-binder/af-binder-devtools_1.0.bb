SUMMARY = "App Framework Host Utilities (generators, parsers)"
DESCRIPTION = "The AGL App Framework Host Utilities are used to compile applications"
HOMEPAGE = "https://gerrit.automotivelinux.org/gerrit/#/admin/projects/src/app-framework-host-utilities"

LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://LICENSE-2.0.txt;md5=3b83ef96387f14655fc854ddc3c6bd57"

DEPENDS = "json-c"

SRC_URI = "git://gerrit.automotivelinux.org/gerrit/src/app-framework-host-utilities;protocol=https;branch=${AGL_BRANCH}"

SRCREV = "${AGL_DEFAULT_REVISION}"
PV = "${AGL_BRANCH}+git${SRCPV}"

S = "${WORKDIR}/git"

inherit cmake pkgconfig

BBCLASSEXTEND += "native nativesdk"
