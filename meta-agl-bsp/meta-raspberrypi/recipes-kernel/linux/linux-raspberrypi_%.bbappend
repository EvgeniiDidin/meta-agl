FILESEXTRAPATHS_prepend := "${THISDIR}/${BPN}:"

require recipes-kernel/linux/linux-agl.inc
require recipes-kernel/linux/linux-agl-4.14.inc

# NOTE: Kprobes need to be disabled until linux-raspberrypi gets updated
#       to newer than 4.14.104 to avoid lttng-modules failing to build.
SRC_URI_append = "\
    ${@oe.utils.conditional('USE_FAYTECH_MONITOR', '1', 'file://0002-faytech-fix-rpi.patch', '', d)} \
    file://disable_kprobes.cfg \
"

CMDLINE_DEBUG = ""
CMDLINE_append = " usbhid.mousepoll=0"

# Add options to allow CMA to operate
CMDLINE_append = ' ${@oe.utils.conditional("ENABLE_CMA", "1", "coherent_pool=6M smsc95xx.turbo_mode=N", "", d)}'

KERNEL_MODULE_AUTOLOAD += "snd-bcm2835"
KERNEL_MODULE_AUTOLOAD += "hid-multitouch"

RDEPENDS_${PN} += "kernel-module-snd-bcm2835"
PACKAGES += "kernel-module-snd-bcm2835"

# Enable support for usb video class for usb camera devices
KERNEL_CONFIG_FRAGMENTS_append = " ${WORKDIR}/uvc.cfg"

# Enable support for joystick devices
KERNEL_CONFIG_FRAGMENTS_append = " ${WORKDIR}/joystick.cfg"

# Enable support for Pi foundation touchscreen
SRC_URI_append = " file://raspberrypi-panel.cfg"
KERNEL_CONFIG_FRAGMENTS_append = " ${WORKDIR}/raspberrypi-panel.cfg"

# Enable bt hci uart
SRC_URI_append = " file://raspberrypi-hciuart.cfg"
KERNEL_CONFIG_FRAGMENTS_append = " ${WORKDIR}/raspberrypi-hciuart.cfg"
