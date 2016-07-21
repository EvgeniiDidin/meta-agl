FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SRC_URI =+ "${SOURCEFORGE_MIRROR}/freetype/ft2demos-${PV}.tar.bz2;name=ft2demos \
           file://0001-Makefile-dont-build-gfx-demos.patch;patchdir=../ft2demos-${PV} \
          "
SRC_URI[ft2demos.md5sum] = "c6c209b37f10621d6ff100620b8292b4"
SRC_URI[ft2demos.sha256sum] = "f8f4bc2a2e76e0dbe61838e452c5a7daf1d4bd9dfa44691940bf308f776d32b6"

PACKAGES =+ "${PN}-demos"

do_compile_append () {
	oe_runmake -C ${WORKDIR}/ft2demos-${PV} TOP_DIR=${WORKDIR}/${BPN}-${PV}
}

do_install_append () {
	install -d -m 0755 ${D}/${bindir}
	for x in ftbench ftdump ftlint ftvalid ttdebug; do 
		install -m 0755 ${WORKDIR}/ft2demos-${PV}/bin/$x ${D}/${bindir}
	done
}

FILES_${PN}-demos = "\
   ${bindir}/ftbench \
   ${bindir}/ftdump \
   ${bindir}/ftlint \
   ${bindir}/ftvalid \
   ${bindir}/ttdebug \
"
