FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SRC_URI =+ "${SOURCEFORGE_MIRROR}/freetype/ft2demos-${PV}.tar.bz2;name=ft2demos \
           file://0001-Makefile-dont-build-gfx-demos.patch;patchdir=../ft2demos-${PV} \
           file://0001-ft2demos-Makefile-Do-not-hardcode-libtool-path.patch;patchdir=../ft2demos-${PV} \
          "
SRC_URI[ft2demos.md5sum] = "178827156d90e07bce8f354c9565d84b"
SRC_URI[ft2demos.sha256sum] = "806eb6363ee5963174a6740f9b7893377912165899c2c1f6372c422aab818c6a"

PACKAGES =+ "${PN}-demos"

B = "${S}"

do_compile_append () {

	oe_runmake -C ${WORKDIR}/ft2demos-${PV} TOP_DIR=${WORKDIR}/${BPN}-${PV}/
}

do_install_append () {
	install -d -m 0755 ${D}/${bindir}
	for x in ftbench ftdump ftlint ftvalid ttdebug; do 
		install -m 0755 ${WORKDIR}/ft2demos-${PV}/bin/.libs/$x ${D}/${bindir}
	done
}

FILES_${PN}-demos = "\
   ${bindir}/ftbench \
   ${bindir}/ftdump \
   ${bindir}/ftlint \
   ${bindir}/ftvalid \
   ${bindir}/ttdebug \
"

# enable pixmap/libpng support to allow color emojis
PACKAGECONFIG_append = " pixmap"
