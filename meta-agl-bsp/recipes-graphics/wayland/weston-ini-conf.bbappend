FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

PACKAGE_ARCH = "${MACHINE_ARCH}"

SRC_URI += "${@bb.utils.contains("DISTRO_FEATURES", "weston-remoting", "file://remote-output.cfg", "",d)}"

#do_configure_append() {
#    if ${@bb.utils.contains('DISTRO_FEATURES', 'weston-remoting', 'true', 'false', d)}; then
#        echo virtual=1 >> ${WORKDIR}/core.cfg
#    fi
#}

