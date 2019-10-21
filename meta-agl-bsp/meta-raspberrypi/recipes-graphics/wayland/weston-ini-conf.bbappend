FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI += "file://dsi.cfg"

# Reduce the screen resolution to HD Ready (720p)
SRC_URI_remove = "file://hdmi-a-1-270.cfg"
SRC_URI_append = " file://hdmi-a-1-270-720p.cfg"
