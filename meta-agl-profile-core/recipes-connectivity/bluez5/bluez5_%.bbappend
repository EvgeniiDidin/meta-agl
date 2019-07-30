FILESEXTRAPATHS_prepend := "${THISDIR}/${BPN}:"
SRC_URI_append = " \
    file://bluetooth.conf \
    file://tmpdir.conf \
    file://0001-obex-report-notification-status-on-incoming-message.patch \
"

FILES_${PN} += "${systemd_user_unitdir}/obex.service.d/tmpdir.conf"

do_install_append() {
    install -m 0644 ${WORKDIR}/bluetooth.conf ${D}${sysconfdir}/dbus-1/system.d/bluetooth.conf

    if ${@bb.utils.contains('DISTRO_FEATURES', 'systemd', 'true', 'false', d)}; then
        mkdir -p ${D}${systemd_user_unitdir}/obex.service.d
        install -m 0644 ${WORKDIR}/tmpdir.conf ${D}${systemd_user_unitdir}/obex.service.d/tmpdir.conf
        mkdir -p ${D}/etc/systemd/user
        ln -sf ${systemd_user_unitdir}/obex.service ${D}/etc/systemd/user/dbus-org.bluez.obex.service
    fi
}
