FILESEXTRAPATHS_append := ":${THISDIR}/${PN}"

SRC_URI_append = "\
    file://0001-compositor-drm.c-Launch-without-input-devices.patch \
    file://weston.service \
    "

inherit systemd

SYSTEMD_PACKAGES = "${PN}"
SYSTEMD_SERVICE_${PN} = "weston.service"

do_install_append() {
    # Install systemd unit files
    if ${@bb.utils.contains('DISTRO_FEATURES', 'systemd', 'true', 'false', d)}; then
        install -m 644 -p -D ${WORKDIR}/weston.service ${D}${systemd_system_unitdir}/weston.service
    fi
}
