#Keep this as a reminder
#MACHINEOVERRIDES .= ":kingfisher"
#PACKAGE_EXTRA_ARCHS_append = " kingfisher"

PREFERRED_RPROVIDER_virtual/gpsd-conf ?= "gpsd-kingfisher-conf"

# Radio packages
IMAGE_INSTALL_append_rcar-gen3 += " \
    si-tools \
    si-init \
    linux-firmware-wl18xx \
    ti-bt \
    ti-bt-firmware \
"
