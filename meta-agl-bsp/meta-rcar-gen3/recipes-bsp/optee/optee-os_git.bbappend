FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"
inherit pythonnative
DEPENDS += " python-pycrypto-native"

SRC_URI += " \
        file://0001-disable-libgcc-detection.patch \
"
