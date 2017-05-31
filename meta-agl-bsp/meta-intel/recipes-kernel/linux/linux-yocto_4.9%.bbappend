FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

# adding most supported USB Bluetooth, Wifi, and Ethernet devices
SRC_URI_append = " file://usb-devices.cfg"
KERNEL_CONFIG_FRAGMENTS_append = " ${WORKDIR}/usb-devices.cfg"

# adding support for other graphic cards to work on more PC HW
SRC_URI_append = " file://extra-graphic-devices.cfg"
KERNEL_CONFIG_FRAGMENTS_append = " ${WORKDIR}/extra-graphic-devices.cfg"
