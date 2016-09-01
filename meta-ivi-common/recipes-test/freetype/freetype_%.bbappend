FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SRC_URI =+ "${SOURCEFORGE_MIRROR}/freetype/ft2demos-${PV}.tar.bz2;name=ft2demos \
           file://0001-Makefile-dont-build-gfx-demos.patch;patchdir=../ft2demos-${PV} \
          "
SRC_URI[ft2demos.md5sum] = "f7c6102f29834a80456264fe4edd81d1"
SRC_URI[ft2demos.sha256sum] = "b076ac52465e912d035f111ede78b88bf3dd186f91a56a54ff83ffdf862e84e4"

PACKAGES =+ "${PN}-demos"

do_compile_append () {
	oe_runmake -C ${WORKDIR}/ft2demos-${PV} TOP_DIR=${WORKDIR}/${BPN}-${PV}
}

do_install_append_checkforkrogoth () {
	install -d -m 0755 ${D}/${bindir}
	for x in ftbench ftdump ftlint ftvalid ttdebug; do 
		install -m 0755 ${WORKDIR}/ft2demos-${PV}/bin/$x ${D}/${bindir}
	done
}

FILES_${PN}-demos_checkforkrogoth = "\
   ${bindir}/ftbench \
   ${bindir}/ftdump \
   ${bindir}/ftlint \
   ${bindir}/ftvalid \
   ${bindir}/ttdebug \
"
