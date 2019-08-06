FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"
SRC_URI_append="${@bb.utils.contains_any("MACHINE", "m3ulcb h3ulcb m3ulcb-nogfx", " "," file://0001-install-wayland.h.patch", d)}"
