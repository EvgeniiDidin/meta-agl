SUMMARY = "Configuration file for Weston IVI-Shell"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COREBASE}/LICENSE;md5=4d92cd373abda3937c2bc47fbc49d690"

FILESEXTRAPATHS_prepend := ":${THISDIR}/weston-ivi-shell:"

SRC_URI = "file://weston.ini.ivi-shell"

do_install() {
       install -d ${D}${sysconfdir}/xdg/weston
       install -m644 ${WORKDIR}/weston.ini.ivi-shell ${D}${sysconfdir}/xdg/weston/weston.ini
}

RDEPENDS_${PN} = "weston"
