inherit systemd

FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI += "file://ti-uim.service"

SYSTEMD_SERVICE_${PN} = "ti-uim.service"

do_install_append() {
    # We do not want the blacklist
    rm -f ${D}/${sysconfdir}/modprobe.d/ti_bt.conf

    install -d ${D}${systemd_unitdir}/system/
    install -m 0644 ${WORKDIR}/ti-uim.service ${D}${systemd_unitdir}/system
}
