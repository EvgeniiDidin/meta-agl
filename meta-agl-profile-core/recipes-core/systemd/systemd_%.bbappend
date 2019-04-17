FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI += "\
    file://e2fsck.conf \
    ${@bb.utils.contains('VIRTUAL-RUNTIME_net_manager','systemd','file://wired.network','',d)} \
    file://system.conf \
"

# enable networkd/resolved support
PACKAGECONFIG_append_pn-systemd = " \
   ${@bb.utils.contains('VIRTUAL-RUNTIME_net_manager','systemd','networkd resolved','',d)} \
"

do_install_append() {
    # Install /etc/e2fsck.conf to avoid boot stuck by wrong clock time
    install -m 644 -p -D ${WORKDIR}/e2fsck.conf ${D}${sysconfdir}/e2fsck.conf

    if ${@bb.utils.contains('VIRTUAL-RUNTIME_net_manager','systemd','true','false',d)}; then
       # Install DHCP configuration for Ethernet adapters
       install -m 644 ${WORKDIR}/wired.network ${D}${sysconfdir}/systemd/network
    fi
    install -m 644 -p -D ${WORKDIR}/system.conf ${D}${sysconfdir}/systemd/system.conf
}

FILES_${PN} += "${sysconfdir}/e2fsck.conf "

# SPEC-737: connmand also has a NTP client which races with systemd-timesyncd
PACKAGECONFIG_remove = "timesyncd"

# Enable systemd-coredump when agl-devel is set on
PACKAGECONFIG_append_agl-devel = " coredump"
