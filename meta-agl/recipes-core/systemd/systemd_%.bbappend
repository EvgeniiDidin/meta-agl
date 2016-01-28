FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI += "file://e2fsck.conf \
            file://wired.network \
           "

# enable networkd/resolved support
PACKAGECONFIG_append_pn-systemd = " networkd resolved"

do_install_append() {
    # Install /etc/e2fsck.conf to avoid boot stuck by wrong clock time
    install -m 644 -p -D ${WORKDIR}/e2fsck.conf ${D}${sysconfdir}/e2fsck.conf
    # Install DHCP configuration for Ethernet adapters
    install -m 644 ${WORKDIR}/wired.network ${D}${sysconfdir}/systemd/network
}

FILES_${PN} += "${sysconfdir}/e2fsck.conf "
