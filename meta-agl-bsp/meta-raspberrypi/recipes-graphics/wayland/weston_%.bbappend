FILESEXTRAPATHS_append := ":${THISDIR}/${PN}"

SRC_URI_append = "\
    file://weston-raspberrypi.ini \
    "

do_install_append() {
    WESTON_INI_CONFIG=${sysconfdir}/xdg/weston
    install -d ${D}${WESTON_INI_CONFIG}
    install -m 0644 ${WORKDIR}/weston-raspberrypi.ini ${D}${WESTON_INI_CONFIG}/weston.ini
}

FILES_${PN} += " \
    ${sysconfdir}/xdg/weston/weston.ini \
    "
