FILESEXTRAPATHS_prepend := "${THISDIR}/files:"
#
# adding most supported CAN devices
SRC_URI_append = " file://can-bus.cfg"
KERNEL_CONFIG_FRAGMENTS_append = " ${WORKDIR}/can-bus.cfg"

# adding most supported USB Bluetooth, Wifiand Ehternet devices
SRC_URI_append = " file://usb-devices.cfg"

# adding support for other graphic cards to work on more PC HW
KERNEL_CONFIG_FRAGMENTS_append = " ${WORKDIR}/usb-devices.cfg"
SRC_URI_append = " file://extra-graphic-devices.cfg"
KERNEL_CONFIG_FRAGMENTS_append = " ${WORKDIR}/extra-graphic-devices.cfg"
