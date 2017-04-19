FILESEXTRAPATHS_append := ":${THISDIR}/${PN}"

SRC_URI_append = "\
    file://0001-compositor-drm.c-Launch-without-input-devices.patch \
    file://0001-Allow-regular-users-to-launch-Weston.patch \
    "

EXTRA_OECONF_append = " --enable-sys-uid"
