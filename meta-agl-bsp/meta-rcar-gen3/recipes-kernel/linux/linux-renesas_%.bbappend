FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

require recipes-kernel/linux/linux-agl.inc

SRC_URI_append  = " file://namespace_fix.cfg \
    file://0001-NFC-pn533-don-t-send-USB-data-off-of-the-stack.patch \
    "

# Add ADSP patch to enable and add sound hardware abstraction
SRC_URI_append = " \
    file://0004-ADSP-enable-and-add-sound-hardware-abstraction.patch \
"
