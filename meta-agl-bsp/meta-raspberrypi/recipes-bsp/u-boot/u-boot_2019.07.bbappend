FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SRC_URI_raspberrypi4 = "git://github.com/balena-os/u-boot;branch=ag/rpi4"
SRCREV_raspberrypi4 = "62b6e39a53c56a9085aeab1b47b5cc6020fcdb6f"
SRC_URI_raspberrypi4-64 = "git://github.com/balena-os/u-boot;branch=ag/rpi4"
SRCREV_raspberrypi4-64 = "62b6e39a53c56a9085aeab1b47b5cc6020fcdb6f"

# Update the patch for u-boot 2019.07
SRC_URI_remove_sota = "file://0001-board-raspberrypi-add-serial-and-revision-to-the-dev.patch"
SRC_URI_append_sota = "file://0001-board-raspberrypi-add-serial-and-revision-to-the-dev-2019.07.patch"
