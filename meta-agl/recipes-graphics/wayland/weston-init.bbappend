FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

WESTONTTY ??= "1"
WESTONUSER ??= "root"
WESTONARGS ?= "--idle-time=4294967"
WESTONLAUNCHARGS ??= "--tty /dev/tty${WESTONTTY} --user ${WESTONUSER}"

do_install_append() {
    sed -e 's,launcher="weston-launch.*--",launcher="weston-launch ${WESTONLAUNCHARGS} --",g' \
        -e 's,exec openvt $openvt_args --,exec ,g' \
        -i ${D}${bindir}/weston-start

    sed -e 's,User=root,User=${WESTONUSER},g' \
        -e 's,$OPTARGS,${WESTONARGS} $OPTARGS,g' \
        -i ${D}${systemd_system_unitdir}/weston.service

    sed -i "/\[Unit\]/aConflicts=getty@tty${WESTONTTY}.service" \
           ${D}${systemd_system_unitdir}/weston.service
}

