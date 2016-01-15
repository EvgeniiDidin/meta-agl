FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI += " file://e2fsck.conf "

# enable networkd support
PACKAGECONFIG_append_pn-systemd = " networkd"

do_install_append() {
    # Install /etc/e2fsck.conf to avoid boot stuck by wrong clock time
    install -p -D ${WORKDIR}/e2fsck.conf ${D}/etc/e2fsck.conf
}

FILES_${PN} += " /etc/e2fsck.conf "
