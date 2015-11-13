SUMMARY = "automotive message broker"
DESCRIPTION = "Automotive-message-broker abstracts the details of the network \
away from applications and provides a standard API for applications to easily \
get the required information"

HOMEPAGE = "https://github.com/otcshare/automotive-message-broker/wiki"

require automotive-message-broker_git.inc

CMAKE_QT5_CLASS = "${@bb.utils.contains('BBFILE_COLLECTIONS','qt5-layer','cmake_qt5','',d)}"
inherit cmake systemd ${CMAKE_QT5_CLASS}

DEPENDS = "glib-2.0 util-linux sqlite3 boost json-c libtool"
RDEPENDS_${PN} = "python-misc python-json"

PACKAGECONFIG ??= " use_gps \
    ${@bb.utils.contains('BBFILE_COLLECTIONS','qt5-layer','use_qt5','', d)} \
    "
PACKAGECONFIG[use_gps] = "-Dgpsd_plugins=On,,gpsd"
PACKAGECONFIG[use_qt5] = "-Dqtmainloop=On -Dqt_bindings=On,,qtbase qtdeclarative"

SYSTEMD_PACKAGES = "${PN}"
SYSTEMD_SERVICE_${PN} = "ambd.service"

# amb detects icecc in cmake and would override the
# compiler selection of yocto. This breaks the build
# if icecc is installed on the host.
# -> Disable the detection in cmake.
EXTRA_OECMAKE += " -Denable_icecc=OFF"

do_install_append() {
    mv ${D}/usr/include/amb/* ${D}/usr/include

    install -d ${D}${systemd_unitdir}/system/
    install -m 0644 ${WORKDIR}/ambd.service ${D}${systemd_unitdir}/system
}

FILES_${PN} += " ${systemd_unitdir}/ambd.service \
    ${@bb.utils.contains('BBFILE_COLLECTIONS','qt5-layer','${libdir}/qt5/qml/amb/','',d)} \
    "
FILES_${PN}-dbg += " \
    ${@bb.utils.contains('BBFILE_COLLECTIONS', 'qt5-layer', '${libdir}/qt5/qml/amb/.debug', '', d)} \
    "
