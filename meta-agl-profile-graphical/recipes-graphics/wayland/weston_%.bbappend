PACKAGECONFIG[notify] = "--enable-systemd-notify,--disable-systemd-notify,systemd"
PACKAGECONFIG_append = " notify"

RRECOMMENDS_${PN}_remove = "weston-conf"
