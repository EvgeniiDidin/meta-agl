FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI_append = "\
    file://0001-Change-socket-mode-add-rw-for-group.patch \
    "
EXTRA_OECONF_append = " --enable-ivi-shell"
