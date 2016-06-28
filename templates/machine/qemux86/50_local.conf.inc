MACHINE = "qemux86"

# Configurations to run on VirtualBox/VMWare
#
# To get wide screen than default, there are a selection of resolutions
# available:
#
#APPEND += "uvesafb.mode_option=1024x768-32"
APPEND += "uvesafb.mode_option=1280x1024-32"
#APPEND += "uvesafb.mode_option=1600x1200-32"
#
# To avoid corrupt boot screen by systemd message, you can use serial
# console separated from VGA console or disable all boot messages by
# kernel command line.
#
# Configuration for serial console
APPEND += "console=ttyS0,115200n8"
#
# All boot message will be off
APPEND += "quiet"
