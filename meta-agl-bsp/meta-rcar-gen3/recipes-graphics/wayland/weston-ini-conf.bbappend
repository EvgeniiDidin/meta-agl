FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI += "${@bb.utils.contains("MACHINE_FEATURES", "multimedia", "file://v4l2-renderer.cfg", "",d)}"

do_configure() {
    echo repaint-window=34 >> ${WORKDIR}/core.cfg

    echo transition-duration=300 >> ${WORKDIR}/ivishell.cfg
    echo cursor-theme=default >> ${WORKDIR}/ivishell.cfg
}
