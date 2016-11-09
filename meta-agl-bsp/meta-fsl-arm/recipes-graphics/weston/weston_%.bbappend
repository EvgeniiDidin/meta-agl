FILESEXTRAPATHS_append := ":${THISDIR}/${PN}"

SRC_URI_append = "\
    file://weston.sh \
    "

do_install_append() {
    install -d ${D}/${sysconfdir}/profile.d
    install -m 0755 ${WORKDIR}/weston.sh ${D}/${sysconfdir}/profile.d/weston.sh
}
 
FILES_${PN} += " \
    ${sysconfdir}/profile.d/weston.sh \
    "
