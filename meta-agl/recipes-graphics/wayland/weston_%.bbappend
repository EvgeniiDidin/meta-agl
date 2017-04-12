FILESEXTRAPATHS_append := ":${THISDIR}/${PN}"

SRC_URI_append = "\
    file://0001-compositor-drm.c-Launch-without-input-devices.patch \
    "

