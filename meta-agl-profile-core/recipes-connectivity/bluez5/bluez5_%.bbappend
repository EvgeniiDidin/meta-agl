FILESEXTRAPATHS_prepend := "${THISDIR}/${BPN}:"
SRC_URI_append = " file://bluetooth.conf"

APPLY_v522 = "${@str('no' if '${PV}' != '5.22' else 'yes')}"

SRC_URI_append = "\
    file://0001_fix_compile_issue_when_using_in_c++.patch;apply=${APPLY_v522} \
"


do_install_append() {
    install -m 0644 ${WORKDIR}/bluetooth.conf ${D}${sysconfdir}/dbus-1/system.d/bluetooth.conf

    if ${@bb.utils.contains('DISTRO_FEATURES', 'systemd', 'true', 'false', d)}; then
        mkdir -p ${D}/etc/systemd/user
        ln -sf ${systemd_user_unitdir}/obex.service ${D}/etc/systemd/user/dbus-org.bluez.obex.service
    fi
}
