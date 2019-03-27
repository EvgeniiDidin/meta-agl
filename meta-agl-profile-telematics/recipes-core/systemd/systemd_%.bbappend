FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SRC_URI_append = "file://canbus-can.network"

do_install_append() {
    mkdir -p ${D}${base_libdir}/systemd/network
    install -m 0644 ${WORKDIR}/canbus-can.network ${D}${base_libdir}/systemd/network/60-canbus-can.network
}
