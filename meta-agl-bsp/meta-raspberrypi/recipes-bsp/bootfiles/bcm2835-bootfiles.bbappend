RDEPENDS_${PN}_append_sota += " u-boot-otascript"

# uprev firmware

RPIFW_DATE = "20190517"
SRCREV = "e1900836948f6c6bdf4571da1b966a9085c95d37"
SRC_URI[md5sum] = "ba272fed3661f0c8d5e4c424d2617246"
SRC_URI[sha256sum] = "2a4c566e98b16575ebf295b795b40a5772f81282948e957bdc9733cf72fdcd39"

PV = "${RPIFW_DATE}"
