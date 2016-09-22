FILESEXTRAPATHS_append := ":${THISDIR}/${PN}"

SRC_URI_append = "\
    file://weston-raspberrypi.ini \
    file://weston.sh \
    "

do_install_append() {
    WESTON_INI_CONFIG=${sysconfdir}/xdg/weston
    install -d ${D}${WESTON_INI_CONFIG}
    install -m 0644 ${WORKDIR}/weston-raspberrypi.ini ${D}${WESTON_INI_CONFIG}/weston.ini

    install -d ${D}/${sysconfdir}/profile.d
    install -m 0755 ${WORKDIR}/weston.sh ${D}/${sysconfdir}/profile.d/weston.sh
}

FILES_${PN} += " \
    ${sysconfdir}/xdg/weston/weston.ini \
    ${sysconfdir}/profile.d/weston.sh \
    "
