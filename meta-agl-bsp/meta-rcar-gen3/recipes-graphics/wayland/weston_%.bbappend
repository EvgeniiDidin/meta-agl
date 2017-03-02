FILESEXTRAPATHS_append := ":${THISDIR}/${PN}"

SRC_URI_append = "\
    file://weston-rcar.ini \
    "

do_install_append() {
    WESTON_INI_CONFIG=${sysconfdir}/xdg/weston
    install -d ${D}${WESTON_INI_CONFIG}
    install -m 0644 ${WORKDIR}/weston-rcar.ini ${D}${WESTON_INI_CONFIG}/weston.ini
}

FILES_${PN}_append_rcar-gen3 = " \
    ${libexecdir}/weston-screenshooter \
    ${libexecdir}/weston-ivi-shell-user-interface \
    ${libexecdir}/weston-keyboard \
    ${libexecdir}/weston-simple-im \
    ${libexecdir}/weston-desktop-shell \
"

FILES_${PN}_append = " \
    ${sysconfdir}/xdg/weston/weston.ini \
    "
