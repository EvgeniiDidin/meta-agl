FILESEXTRAPATHS_append := ":${THISDIR}/${PN}"

SRC_URI_append = "\
    file://0001-Allow-regular-users-to-launch-Weston_2.0.0.patch \
    file://0001-compositor-drm.c-Launch-without-input-devices.patch \
    "

EXTRA_OECONF_append = " --enable-sys-uid"
