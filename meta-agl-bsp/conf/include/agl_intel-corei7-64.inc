# Enable Libvaapi for HW accelerated video support
#
IMAGE_INSTALL_append = " \
        libva \
        intel-vaapi-driver \
        gstreamer1.0-vaapi"

INITRD_LIVE = "${DEPLOY_DIR_IMAGE}/${INITRD_IMAGE_LIVE}-${MACHINE}.ext4.gz"

# Modify this file under meta-agl-bsp/meta-intel/wic to change the
# kernel command line, including to change the screen resolution.
WKS_FILE = "systemd-intel-corei7-64-bootdisk.wks"

PREFERRED_VERSION_linux-intel ?= "4.19%"
PREFERRED_VERSION_linux-intel-rt ?= "4.19%"

SERIAL_CONSOLES_remove = "115200;ttyS2"

#
# To avoid corrupt boot screen by systemd message, you can use serial
# console separated from VGA console or disable all boot messages by
# kernel command line.
#
# Configuration for serial console
QB_KERNEL_CMDLINE_APPEND_append = " console=ttyS0,115200n8"
#
# All boot message will be off
QB_KERNEL_CMDLINE_APPEND_append = " quiet"
#
# Force the virtio video device as 'vmware' doesn't always work
QB_OPT_APPEND_append = " -vga virtio"
