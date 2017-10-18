FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

# Disable LVDS
SRC_URI += "file://lvds-off.cfg"
