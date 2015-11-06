SUMMARY = "automotive message broker"
DESCRIPTION = "Automotive-message-broker abstracts the details of the network \
away from applications and provides a standard API for applications to easily \
get the required information"

HOMEPAGE = "https://github.com/otcshare/automotive-message-broker/wiki"
LICENSE = "LGPL-2.1"
LIC_FILES_CHKSUM = "file://COPYING;md5=b42382de5d854b9bb598acf2e8827de3"

inherit cmake systemd

PV = "0.12+git${SRCPV}"

# The 'gpsd' leads to a conflict between bluez4 and bluez5 because
# meta-openembedded/meta-oe/recipes-navigation/gpsd/gpsd_3.10.bb is able to
# select  bluez4 only instead AGL Distro choose bluez5 at changeset 4141.
# <https://gerrit.automotivelinux.org/gerrit/#/c/4141/>
#
# As temporary treatment, removing 'gpsd' from DEPENDS will let bitbake to build correctly.
#
#DEPENDS = "glib-2.0 util-linux sqlite3 qtbase boost json-c libtool gpsd"
DEPENDS = "glib-2.0 util-linux sqlite3 boost json-c libtool"

SRC_URI = "git://github.com/otcshare/automotive-message-broker.git"
SRCREV = "ac3fe53327a13afc571efe079a31a0472ea285a3"

SRC_URI += "file://amb_allow_sessionbus.patch \
            file://ambd.service \
            "

SYSTEMD_PACKAGES = "${PN}"
SYSTEMD_SERVICE_${PN} = "ambd.service"

S = "${WORKDIR}/git"

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

FILES_${PN} += "${systemd_unitdir}/ambd.service"
