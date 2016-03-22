DESCRIPTION = "Network Protocol Independent Performance Evaluator"
LICENSE = "GPL-1.0"
URL = "http://bitspjoule.org/netpipe"

# PV from recipe filename
SRC_URI  = "http://bitspjoule.org/netpipe/code/NetPIPE-${PV}.tar.gz"
# change makefile to support env variables of bitbake
SRC_URI += "file://netpipe-makefile.patch"

SRC_URI[md5sum] = "653071f785404bb68f8aaeff89fb1f33"
SRC_URI[sha256sum] = "13dac884ff52951636f651c421f5ff4a853218a95aa28a4a852402ee385a2ab8"

LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/GPL-1.0;md5=e9e36a9de734199567a4d769498f743d"

# bitbake expects ${PN}-${PV} which would be netpipe-3.7.2 but the tarball has:
S = "${WORKDIR}/NetPIPE-${PV}"

# added after 'make' as argument
EXTRA_OEMAKE = "tcp tcp6 memcpy"

do_install () {
    install -d ${D}${bindir}
    install -m 0755 NPtcp ${D}${bindir}
    install -m 0755 NPtcp6 ${D}${bindir}
    install -m 0755 NPmemcpy ${D}${bindir}
}
