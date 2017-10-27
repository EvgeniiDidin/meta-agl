FILESEXTRAPATHS_prepend := "${THISDIR}/linux:"

# Extra configuration options for the AGL kernel
SRC_URI_append = " file://can-bus.cfg \
                   file://usb.cfg \
                   file://uvc.cfg \
                   file://joystick.cfg \
            "
