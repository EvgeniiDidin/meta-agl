SUMMARY = "Reference Wayland compositor for AGL"
DESCRIPTION = "The AGL compositor is a reference Wayland server for Automotive \
Grade Linux, using libweston as a base to provide a graphical environment for \
the automotive environment."

HOMEPAGE = "https://gerrit.automotivelinux.org/gerrit/q/project:src%252Fagl-compositor"
SECTION = "x11"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://COPYING;md5=fac6abe0003c4d142ff8fa1f18316df0"

DEPENDS = "wayland wayland-protocols wayland-native weston"

SRC_URI = "git://gerrit.automotivelinux.org/gerrit/src/agl-compositor.git;protocol=https;branch=${AGL_BRANCH}"
SRCREV = "1956bd3bfb0c85e3eb3413dd465a1a2fb1ae78bb"

PV = "0.0.10+git${SRCPV}"
S = "${WORKDIR}/git"

inherit meson pkgconfig python3native

FILES_${PN} = "${bindir}/agl-compositor ${datadir}/${PN}/protocols/agl-shell.xml ${datadir}/${PN}/protocols/agl-shell-desktop.xml"
