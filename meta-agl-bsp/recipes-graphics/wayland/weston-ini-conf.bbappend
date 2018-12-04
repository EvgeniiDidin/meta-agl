FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

PACKAGE_ARCH = "${MACHINE_ARCH}"

SRC_URI += "${@bb.utils.contains("DISTRO_FEATURES", "gst-record", "file://virtualoutput.cfg", "",d)}"

do_configure_append() {
    if ${@bb.utils.contains('DISTRO_FEATURES', 'gst-record', 'true', 'false', d)}; then
        echo virtual=1 >> ${WORKDIR}/core.cfg
    fi
}

