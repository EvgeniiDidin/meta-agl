FILESEXTRAPATHS_append := ":${THISDIR}/${PN}"

# QT_MODULE_BRANCH = "5.4"

# TODO:
#  These patches for IVI-SHELL are tempolary disabled because of issues. And new
#  patches are proposed.
#
#    file://0020-Add-IVI-Shell-protocol-file-version-patch-v6.patch \
#    file://0021-Implement-initial-IVI-Shell-support.patch \
#    file://0001-protocol-update-3rd-party-ivi-application-protocol.patch \
#    file://0002-qwaylandwindow-add-support-for-IVI-Surface-ID-proper.patch \
#
#  The xdg-shell merged into upstream, so we don't need these patch anymore.
#  But xdg-shell doesn't work well in current AGL Distro because of
#  mismatch of protocol versions between server(weston) and client(Qt Apps).
#
#    file://0016-xdg-shell-Add-xdg-shell-protocol-file-version-1.4.0.patch \
#    file://0017-xdg-shell-Add-minimize-feature-to-QWindow-using-wayl.patch \
#    file://0019-xdg-shell-upgrade-to-support-current-version-weston-.patch \
#

SRC_URI_append = "\
    file://0010-Added-manifest-file-according-to-smack-3-domain-mode.patch \
    "

DEFAULT_WM_SHELL = "${@bb.utils.contains('DISTRO_FEATURES', 'agl-compositor', 'xdg-shell', 'ivi-shell', d)}"
AFM_CONF_DIR = "${D}${sysconfdir}/afm/unit.env.d"
QT_SHELL_FILE = "${AFM_CONF_DIR}/qt-shell"

do_install_append_class-target() {
	mkdir -p ${AFM_CONF_DIR}
	echo "QT_WAYLAND_SHELL_INTEGRATION=${DEFAULT_WM_SHELL}" > ${QT_SHELL_FILE}
	echo "QT_WAYLAND_RESIZE_AFTER_SWAP=1" >> ${QT_SHELL_FILE}
}
