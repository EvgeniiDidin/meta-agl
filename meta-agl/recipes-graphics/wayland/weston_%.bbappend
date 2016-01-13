FILESEXTRAPATHS_append := ":${THISDIR}/${PN}"

SRC_URI_append = "\
    file://weston.service \
    file://weston.ini \
    "

inherit systemd

SYSTEMD_PACKAGES = "${PN}"
SYSTEMD_SERVICE_${PN} = "weston.service"

do_install_append() {
    # Install systemd unit files
    if ${@bb.utils.contains('DISTRO_FEATURES', 'systemd', 'true', 'false', d)}; then
        install -p -D ${WORKDIR}/weston.service ${D}${systemd_system_unitdir}/weston.service
    fi

    WESTON_INI_CONFIG=${sysconfdir}/xdg/weston
    install -d ${D}${WESTON_INI_CONFIG}
    install -m 0644 ${WORKDIR}/weston.ini ${D}${WESTON_INI_CONFIG}/weston.ini
}

FILES_${PN} += " \
    ${sysconfdir}/xdg/weston/weston.ini \
    "
