FILESEXTRAPATHS_prepend := "${THISDIR}/files:"
SRC_URI_append = "file://ofono.conf"

do_install_append() {
    install -m 0644 ${WORKDIR}/ofono.conf ${D}${sysconfdir}/dbus-1/system.d/ofono.conf
}
