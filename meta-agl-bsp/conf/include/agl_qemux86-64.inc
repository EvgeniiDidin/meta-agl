# Configurations to run on VirtualBox/VMWare
#
# To get wide screen than default, there are a selection of resolutions
# available:
#
#UVESA_MODE = "1024x768-32"
UVESA_MODE = "1280x1024-32"
#UVESA_MODE = "1600x1200-32"
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

# Build updatable image. Only takes effect when sota.bbclass is inherited
DISTRO_FEATURES_append = " sota"

# Image support
AGL_EXTRA_IMAGE_FSTYPES = "ext4 wic.vmdk wic.xz wic.bmap"
IMAGE_BOOT_FILES_sota = "u-boot-qemux86-64.rom"

# Root device
ROOT_VM = "root=PARTUUID=${DISK_SIGNATURE}-02"

# Force the virtio video device as 'vmware' doesn't always work
QB_OPT_APPEND_append = " -vga virtio"

# Use our own wks file
WKS_FILE="systemd-intel-corei7-64-bootdisk.wks"
