RDEPENDS_${PN}_append_sota += " u-boot-otascript"

RPIFW_DATE_raspberrypi4 = "20190709"
SRCREV_raspberrypi4 = "356f5c2880a3c7e8774025aa6fc934a617553e7b"
RPIFW_SRC_URI_raspberrypi4 = "https://github.com/raspberrypi/firmware/archive/${SRCREV}.tar.gz"
RPIFW_S_raspberrypi_4 = "${WORKDIR}/firmware-${SRCREV}"

SRC_URI_raspberrypi4 = "${RPIFW_SRC_URI}"
SRC_URI[md5sum] = "${@ '5962784e7963f0116cd1519e47749b25' if d.getVar('MACHINE_ARCH') == 'raspberrypi4' else '5ccdb5447cbdd3ee0158a514f7b76cb9'}"
SRC_URI[sha256sum] = "${@ '6e07d98e4229ba7a1970a4c475fc6b8631823d200d3b8734a508e7ff5ea4c120' if d.getVar('MACHINE_ARCH') == 'raspberrypi4' else '9a34ccc4a51695a33206cc6c8534f615ba5a30fcbce5fa3add400ecc6b80ad8a'}"

PV_raspberrypi4 = "${RPIFW_DATE}"
