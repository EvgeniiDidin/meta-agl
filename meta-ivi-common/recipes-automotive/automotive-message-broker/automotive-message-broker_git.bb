SUMMARY = "automotive message broker"
DESCRIPTION = "Automotive-message-broker abstracts the details of the network \
away from applications and provides a standard API for applications to easily \
get the required information"

HOMEPAGE = "https://github.com/otcshare/automotive-message-broker/wiki"
LICENSE = "LGPL-2.1"
LIC_FILES_CHKSUM = "file://COPYING;md5=b42382de5d854b9bb598acf2e8827de3"

inherit cmake systemd

#DEPENDS = "glib-2.0 util-linux sqlite3 qtbase boost json-c libtool gpsd"
DEPENDS = "glib-2.0 util-linux sqlite3 boost json-c libtool gpsd"
RDEPENDS_${PN} = "python-misc python-json"

PV = "0.14+git${SRCPV}"

SRC_URI = "git://github.com/CogentEmbedded/automotive-message-broker.git;protocol=https;branch=master"
SRCREV = "58569fac42bb8b6e1ad208caef5db8a51befc87f"

# The paches from 0001 to 0009 are from difference between
# hash:58569fac42bb8b6e1ad208caef5db8a51befc87f(main branch) and
# hash:8f761e02172544212915c82b7e8dd8d4dd1281a6(dev_0.14_2)
SRC_URI += " \
    file://0001-Improve-backward-compatibility-with-old-linaro-gcc.patch \
    file://0002-Fix-library-versioning.patch \
    file://0003-AmbSignalMapper-fix-can-interface-specification.patch \
    file://0004-cansocketbcm-Fix-reading-of-frames-in-case-of-RX_TIM.patch \
    file://0005-ambctl-remove-unnecessary-dependency-on-glib-introsp.patch \
    file://0006-cangen-Implement-basic-handling-of-RX_TIMEOUT.patch \
    file://0007-WORKAROUND-Allow-amb-qt-binding-to-work-in-case-of-m.patch \
    file://0008-Add-simple-Qt-QML-example.patch \
    file://0009-Add-Pressure-property-to-BrakeOperation.patch \
    file://0001-Fix-build-issues-while-bitbake-without-meta-qt5-laye.patch \
    file://ambd.service \
    "

SYSTEMD_PACKAGES = "${PN}"
SYSTEMD_SERVICE_${PN} = "ambd.service"

S = "${WORKDIR}/git"

# amb detects icecc in cmake and would override the
# compiler selection of yocto. This breaks the build
# if icecc is installed on the host.
# -> Disable the detection in cmake.
EXTRA_OECMAKE += " -Denable_icecc=OFF -Dgpsd_plugin=ON"

do_install_append() {
    mv ${D}/usr/include/amb/* ${D}/usr/include

    install -d ${D}${systemd_unitdir}/system/
    install -m 0644 ${WORKDIR}/ambd.service ${D}${systemd_unitdir}/system
}

FILES_${PN} += "${systemd_unitdir}/ambd.service"
