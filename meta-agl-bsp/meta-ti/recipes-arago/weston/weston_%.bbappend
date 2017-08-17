# When configured for fbdev compositor, make it the default
PACKAGECONFIG[fbdev] = "--enable-fbdev-compositor WESTON_NATIVE_BACKEND="fbdev-backend.so",--disable-fbdev-compositor,udev mtdev"
PACKAGECONFIG[kms] = "--enable-drm-compositor,--disable-drm-compositor,drm udev libgbm mtdev"

PR_append = ".agl_arago_23"

FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

RDEPENDS_${PN} += "weston-conf"

####################### F I X M E  ##########################
# FIXME pyro
DISABLED_SRC_URI += " \
	file://0001-udev-seat-restrict-udev-enumeration-to-card0.patch \
	file://0001-Add-soc-performance-monitor-utilites.patch \
	file://0002-Weston-Allow-visual_id-to-be-0.patch \
	file://0003-Weston-Fix-virtual-keyboard-display-issue-for-QT5-ap.patch \
	file://0004-Weston-Fix-touch-screen-crash-issue.patch \
	file://0001-compositor-drm-fix-hotplug-weston-termination-proble.patch \
	file://0001-compositor-drm-support-RGB565-with-pixman-renderer.patch \
"
####################### F I X M E  ##########################


RDEPENDS_${PN}_remove = "weston-conf"
