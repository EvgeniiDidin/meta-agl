FILESEXTRAPATHS_prepend := "${THISDIR}/linux:"

# Extra configuration options for the AGL kernel
SRC_URI_append = " file://can-bus.cfg \
            "
