FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"
inherit pythonnative
DEPENDS += " python-pycrypto-native"

#Need for gcc 6.2
CFLAGS += " -fno-strict-aliasing -Wno-unused-variable -Wno-shift-negative-value"


