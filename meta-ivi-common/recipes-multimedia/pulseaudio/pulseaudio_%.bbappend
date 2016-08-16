FILESEXTRAPATHS_append := ":${THISDIR}/${PN}"

inherit systemd

do_install_append() {
       # Install pulseaudio systemd service
       if ${@bb.utils.contains('DISTRO_FEATURES', 'systemd', 'true', 'false', d)}; then
              install -m 644 -p -D ${WORKDIR}/build/src/pulseaudio.service ${D}${systemd_user_unitdir}/pulseaudio.service
              install -m 644 -p -D ${WORKDIR}/pulseaudio-${PV}/src/daemon/systemd/user/pulseaudio.socket ${D}${systemd_user_unitdir}/pulseaudio.socket

              # Execute these manually on behalf of systemctl script (from systemd-systemctl-native.bb)
              # because it does not support systemd's user mode.
              mkdir -p ${D}/home/root/.config/systemd/user/sockets.target.wants/
              ln -sf ${systemd_user_unitdir}/pulseaudio.socket ${D}/home/root/.config/systemd/user/sockets.target.wants/pulseaudio.socket

              mkdir -p ${D}/home/root/.config/systemd/user/default.target.wants/
              ln -sf ${systemd_user_unitdir}/pulseaudio.service ${D}/home/root/.config/systemd/user/default.target.wants/pulseaudio.service
       fi
       mkdir -p ${D}/${bindir}
       install -m 755 -p -D ${WORKDIR}/build/src/.libs/pacat ${D}/${bindir}/
}

FILES_${PN} += " \
    ${@bb.utils.contains('DISTRO_FEATURES', 'systemd', '${systemd_user_unitdir}/pulseaudio.socket', '', d)} \
    ${@bb.utils.contains('DISTRO_FEATURES', 'systemd', '/home/root/.config/systemd/user/sockets.target.wants/pulseaudio.socket', '', d)} \
    ${@bb.utils.contains('DISTRO_FEATURES', 'systemd', '${systemd_user_unitdir}/pulseaudio.service', '', d)} \
    ${@bb.utils.contains('DISTRO_FEATURES', 'systemd', '/home/root/.config/systemd/user/default.target.wants/pulseaudio.service', '', d)} \
"
