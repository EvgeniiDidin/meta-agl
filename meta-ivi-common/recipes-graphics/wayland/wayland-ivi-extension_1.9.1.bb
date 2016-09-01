SUMMARY = "Wayland IVI Extension"
DESCRIPTION = "GENIVI Layer Management API based on Wayland IVI Extension"
HOMEPAGE = "http://projects.genivi.org/wayland-ivi-extension"
BUGTRACKER = "http://bugs.genivi.org/enter_bug.cgi?product=Wayland%20IVI%20Extension"
LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://LICENSE;md5=176cedb32f48dd58f07e0c1c717b3ea4"

DEPENDS = "weston"

SRC_URI = "git://github.com/GENIVI/${PN}.git;protocol=https \
          "
SRC_URI_append_wandboard = "file://wandboard_fix_build.patch"

SRCREV = "44598504503eea5ac7f94c88477a5a78bda01f30"

S = "${WORKDIR}/git"

inherit cmake
#jsmoeller: rm autotools from inherit ... there can only be one

PACKAGECONFIG ??= "ilm_input"
PACKAGECONFIG[ivi-share] = "-DIVI_SHARE=ON,-DIVI_SHARE=OFF,libgbm libdrm"
PACKAGECONFIG[ilm_input] = "-DWITH_ILM_INPUT=1,-DWITH_ILM_INPUT=0"

FILES_${PN} += "${libdir}/weston/*"
FILES_${PN}-dbg += "${libdir}/weston/.debug/*"
