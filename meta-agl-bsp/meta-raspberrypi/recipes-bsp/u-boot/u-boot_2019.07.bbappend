# Apply the same patches for rpi4 as u-boot recipe
require u-boot-rpi4-${PV}.inc

FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

# Update the patch for u-boot 2019.07
SRC_URI_remove_sota = "file://0001-board-raspberrypi-add-serial-and-revision-to-the-dev.patch"
SRC_URI_append_sota = "file://0001-board-raspberrypi-add-serial-and-revision-to-the-dev-2019.07.patch"

DEPENDS_append_rpi = " rpi-u-boot-scr"
