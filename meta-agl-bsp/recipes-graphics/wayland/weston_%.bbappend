FILESEXTRAPATHS_append := ":${THISDIR}/${PN}"

RDEPENDS_${PN}_append_qemux86 = " mesa-megadriver"
RDEPENDS_${PN}_append_qemux86-64 = " mesa-megadriver"
RDEPENDS_${PN}_append_intel-corei7-64 = " mesa-megadriver"

SRC_URI_append = "\
    file://weston-qemu-drm.ini \
    "

do_install_append() {
    WESTON_CONFIG_DIR=${sysconfdir}/xdg/weston
    install -d ${D}${WESTON_CONFIG_DIR}
    install -m 0644 ${WORKDIR}/weston-qemu-drm.ini ${D}${WESTON_CONFIG_DIR}/weston.ini
}

FILES_${PN} += " \
    ${sysconfdir}/xdg/weston/weston.ini \
    "
