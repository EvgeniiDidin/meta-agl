FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

inherit agl-graphical


WESTONSTART ??= "${@bb.utils.contains("DISTRO_FEATURES", "agl-compositor", "/usr/bin/agl-compositor", "/usr/bin/weston",d)} ${WESTONARGS}"
WESTONSTART_append = " ${@bb.utils.contains("IMAGE_FEATURES", "debug-tweaks", " --log=${DISPLAY_XDG_RUNTIME_DIR}/weston.log", "",d)}"

DROPIN_NAME = "weston-init"

WIFILES = " \
    file://weston.conf.in \
    file://tmpfiles.conf.in \
    file://zz-dri.rules.in \
    file://zz-input.rules \
    file://zz-tty.rules.in \
"

WIFILES_append_imx = " \
    file://zz-dri-imx.rules.in \
"

SRC_URI_append = " ${WIFILES}"

do_install_append() {

    # files
    files=$(echo ${WIFILES} | sed s,file://,,g)

    # process ".in" files
    for f in ${files}; do
        g=${f%.in}
        if [ "${f}" != "${g}" ]; then
            sed -e "s,@WESTONUSER@,${WESTONUSER},g" \
                -e "s,@WESTONGROUP@,${WESTONGROUP},g" \
                -e "s,@XDG_RUNTIME_DIR@,${DISPLAY_XDG_RUNTIME_DIR},g" \
                -e "s,@WESTONTTY@,${WESTONTTY},g" \
                -e "s,@WESTONSTART@,${WESTONSTART},g" \
                    ${WORKDIR}/${f} > ${WORKDIR}/${g}
        fi
    done

    # removes any unexpected entry from weston.service
    for x in Group User ExecStart PAMName; do
        sed -i "/^ *$x *=/d" ${D}${systemd_system_unitdir}/weston.service
    done

    # install weston drop-in
    install -d ${D}${systemd_system_unitdir}/weston.service.d
    install -m644 ${WORKDIR}/weston.conf ${D}/${systemd_system_unitdir}/weston.service.d/${DROPIN_NAME}.conf

    # install tmpfiles drop-in
    install -d ${D}${libdir}/tmpfiles.d
    install -m644 ${WORKDIR}/tmpfiles.conf ${D}${libdir}/tmpfiles.d/${DROPIN_NAME}.conf

    # install udev rules
    install -d ${D}${sysconfdir}/udev/rules.d
    for f in ${files}; do
        g=${f%.in}
        h=${g%.rules}
        if [ "${g}" != "${h}" ]; then
            install -m644 ${WORKDIR}/${g} ${D}${sysconfdir}/udev/rules.d
        fi
    done
}

FILES_${PN} += " \
    ${libdir}/tmpfiles.d/*.conf \
    ${systemd_system_unitdir}/weston.service.d/${DROPIN_NAME}.conf \
"


