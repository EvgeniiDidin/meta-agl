SUMMARY = "fdtoverlay from the device tree compiler"
HOMEPAGE = "https://devicetree.org/"
DESCRIPTION = "fdtoverlay is a tool to apply a number of overlays to a base blob."
SECTION = "bootloader"
LICENSE = "GPLv2 | BSD"
DEPENDS = "flex-native bison-native"

SRC_URI = "git://git.kernel.org/pub/scm/utils/dtc/dtc.git \
           file://make_install.patch \
           "
UPSTREAM_CHECK_GITTAGREGEX = "v(?P<pver>\d+(\.\d+)+)"

EXTRA_OEMAKE='NO_PYTHON=1 PREFIX="${prefix}" LIBDIR="${libdir}" DESTDIR="${D}"'

S = "${WORKDIR}/git"

do_compile () {
	oe_runmake fdtoverlay
}

do_install () {
	install -d ${D}/${bindir}
	install -m 0755 ${S}/fdtoverlay ${D}/${bindir}/fdtoverlay
}

FILES_${PN} = "${bindir}/fdtoverlay"
