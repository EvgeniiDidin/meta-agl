SUMMARY = "AGL Login manager"

LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COREBASE}/meta/COPYING.MIT;md5=3da9cfbcb788c80a0384361b4de20420"

inherit agl-graphical

SRC_URI += " \
    file://user-config.service \
    file://user-config.path \
    file://agl-user-session.pamd \
    file://agl-user-session@.service \
"

LOGIN_USER ??="agl-driver agl-passenger"

do_install_append() {

    install -d ${D}${sysconfdir}/pam.d/
    install -m 0644 ${WORKDIR}/agl-user-session.pamd ${D}${sysconfdir}/pam.d/agl-user-session

    install -d ${D}${systemd_user_unitdir}
    install -d ${D}${systemd_user_unitdir}/default.target.wants
    install -m 0644 ${WORKDIR}/user-config.service ${D}${systemd_user_unitdir}
    install -m 0644 ${WORKDIR}/user-config.path ${D}${systemd_user_unitdir}

    sed -e 's,@DISPLAY_XDG_RUNTIME_DIR@,${DISPLAY_XDG_RUNTIME_DIR},g' \
        -i ${D}${systemd_user_unitdir}/user-config.service
    sed -e 's,@DISPLAY_XDG_RUNTIME_DIR@,${DISPLAY_XDG_RUNTIME_DIR},g' \
        -i ${D}${systemd_user_unitdir}/user-config.path

    ln -sf ${systemd_user_unitdir}/user-config.path ${D}${systemd_user_unitdir}/default.target.wants

    install -d ${D}${systemd_unitdir}/system/
    install -d ${D}${systemd_unitdir}/system/multi-user.target.wants/
    install -m 0644 ${WORKDIR}/agl-user-session@.service ${D}${systemd_unitdir}/system/

    for AGL_USER in ${LOGIN_USER};do
        ln -sf ${systemd_system_unitdir}/agl-user-session@.service ${D}${systemd_unitdir}/system/multi-user.target.wants/agl-user-session@${AGL_USER}.service;
    done
}

FILES_${PN} += "${sysconfdir}/pam.d/agl-user-session"
FILES_${PN} += "${systemd_user_unitdir}/*"
FILES_${PN} += "${libdir}/systemd/user/default.target.wants/*"
FILES_${PN} += "${systemd_unitdir}/system/agl-user-session@.service"
FILES_${PN} += "${systemd_unitdir}/system/multi-user.target.wants/*"
