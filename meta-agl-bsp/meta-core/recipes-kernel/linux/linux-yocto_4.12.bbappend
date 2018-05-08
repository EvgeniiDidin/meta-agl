FILESEXTRAPATHS_prepend := "${THISDIR}/linux-yocto:"

SRC_URI_append = " file://0001-NFC-pn533-don-t-send-USB-data-off-of-the-stack.patch"
