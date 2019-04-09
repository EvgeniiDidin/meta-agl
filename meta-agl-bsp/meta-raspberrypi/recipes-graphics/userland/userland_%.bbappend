# FIXME: Temporary fix that can be removed once commit 752db52 gets backported
#        from master to thud branch of meta-raspberrypi
RDEPENDS_${PN}_remove = "libegl1"
RDEPENDS_${PN} += "${@bb.utils.contains("MACHINE_FEATURES", "vc4graphics", "libegl-mesa", "", d)}"
