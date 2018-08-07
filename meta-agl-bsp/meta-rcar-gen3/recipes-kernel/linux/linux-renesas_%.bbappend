FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

require recipes-kernel/linux/linux-agl.inc

SRC_URI_append  = " file://namespace_fix.cfg \
    file://0001-NFC-pn533-don-t-send-USB-data-off-of-the-stack.patch \
    "
