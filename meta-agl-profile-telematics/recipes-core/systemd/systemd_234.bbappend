FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SRC_URI_append = " \
    file://0001-networkd-link-link_configure-factor-out-link_configu.patch \
    file://0002-networkd-link-link_up_can-move-function-upwards.patch \
    file://0003-networkd-link-add-support-to-configure-CAN-interface.patch \
    file://canbus-can0.network \
"

do_install_append() {
    mkdir -p ${D}${base_libdir}/systemd/network
    install -m 0644 ${WORKDIR}/canbus-can0.network ${D}${base_libdir}/systemd/network/60-canbus-can0.network
}
