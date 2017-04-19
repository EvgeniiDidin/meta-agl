FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI += "file://e2fsck.conf \
            file://automount-rules \
            file://mount.sh \
            ${@bb.utils.contains('VIRTUAL-RUNTIME_net_manager','systemd','file://wired.network','',d)} \
           "

# enable networkd/resolved support
PACKAGECONFIG_append_pn-systemd = " \
   ${@bb.utils.contains('VIRTUAL-RUNTIME_net_manager','systemd','networkd resolved','',d)} \
"

do_install_append() {
    # Install /etc/e2fsck.conf to avoid boot stuck by wrong clock time
    install -m 644 -p -D ${WORKDIR}/e2fsck.conf ${D}${sysconfdir}/e2fsck.conf

    if ${@bb.utils.contains('DISTRO_FEATURES', 'automount', 'true', 'false', d)}; then
        install -m 644 -p -D ${WORKDIR}/automount-rules ${D}${sysconfdir}/udev/rules.d/10-automount.rules
        install -m 755 -p -D ${WORKDIR}/mount.sh ${D}${sysconfdir}/udev/scripts/mount.sh
    fi

    if ${@bb.utils.contains('VIRTUAL-RUNTIME_net_manager','systemd','true','false',d)}; then
       # Install DHCP configuration for Ethernet adapters
       install -m 644 ${WORKDIR}/wired.network ${D}${sysconfdir}/systemd/network
    fi
}

FILES_${PN} += "${sysconfdir}/e2fsck.conf "
