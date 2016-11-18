#inherit append-code-change
# When configured for fbdev compositor, make it the default
PACKAGECONFIG[fbdev] = "--enable-fbdev-compositor WESTON_NATIVE_BACKEND="fbdev-backend.so",--disable-fbdev-compositor,udev mtdev"
PACKAGECONFIG[kms] = "--enable-drm-compositor,--disable-drm-compositor,drm udev libgbm mtdev"

PR_append = ".agl_arago_16"

FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

RDEPENDS_${PN} += "weston-conf"

SRC_URI += " \
	file://0001-weston1.9.0-Enabling-DRM-backend-with-multiple-displ.patch \
	file://0002-Weston1.9.0-Allow-visual_id-to-be-0.patch \
	file://0003-Weston1.9.0-Fix-virtual-keyboard-display-issue-for-Q.patch \
	file://0004-Weston1.9.0-Fix-touch-screen-crash-issue.patch \
	file://0001-udev-seat-restrict-udev-enumeration-to-card0.patch \
	file://0001-Add-soc-performance-monitor-utilites.patch \
"

RDEPENDS_${PN}_remove = "weston-conf"

SRC_URI += " \
      file://0001-ivi-shell-fix-TODO-which-expects-only-one-screen-in-.patch \
      file://0002-ivi-shell-multi-screen-support-to-calcuration-of-a-m.patch \
      file://0003-ivi-shell-avoid-update_prop-on-invisible-surfaces.patch    \
      file://0004-ivi-shell-fix-layout_layer.view_list-is-not-initiliz.patch \
      file://0005-ivi-shell-convert-from-screen-to-global-coordinates.patch  \
      file://0006-ivi-shell-remove-a-code-which-expects-only-a-screen-.patch \
      file://0007-ivi-shell-layout-Export-surface-destroy-callback.patch     \
      file://0008-ivi-shell-Add-simple-IVI-shell-layout-controller.patch     \
      file://0001-ivi-shell-Add-autolaunch-and-launch-rules-functional.patch \
      file://0001-ivi-shell-layer-controller-ti-Improve-functionality.patch  \
      file://0001-ivi-shell-Add-screenshooter-option.patch                   \
      "
