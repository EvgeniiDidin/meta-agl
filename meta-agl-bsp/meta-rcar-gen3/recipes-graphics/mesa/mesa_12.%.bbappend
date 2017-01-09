require include/gles-control.inc

include mesa-wayland.inc

FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"
SRC_URI += "${@base_conditional('USE_GLES_WAYLAND', '1', \
    'file://0001-Mesa-include-the-stat.h-for-fixing-compile-errors.patch', '', d)}"
