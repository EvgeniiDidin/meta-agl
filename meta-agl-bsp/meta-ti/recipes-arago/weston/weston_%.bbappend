#inherit append-code-change
# When configured for fbdev compositor, make it the default
PACKAGECONFIG[fbdev] = "--enable-fbdev-compositor WESTON_NATIVE_BACKEND="fbdev-backend.so",--disable-fbdev-compositor,udev mtdev"
PACKAGECONFIG[kms] = "--enable-drm-compositor,--disable-drm-compositor,drm udev libgbm mtdev"

PR_append = ".agl_arago_16"

FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

RDEPENDS_${PN} += "weston-conf"

SRC_URI += " \
	file://0001-udev-seat-restrict-udev-enumeration-to-card0.patch \
	file://0001-Add-soc-performance-monitor-utilites.patch \
"

RDEPENDS_${PN}_remove = "weston-conf"
