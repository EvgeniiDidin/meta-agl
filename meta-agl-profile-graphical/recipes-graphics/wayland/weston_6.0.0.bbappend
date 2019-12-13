FILESEXTRAPATHS_append := ":${THISDIR}/${PN}"

SRC_URI_append = "\
    file://0001-Allow-regular-users-to-launch-Weston_2.0.0.patch \
    file://use-XDG_RUNTIMESHARE_DIR.patch \
    file://0002-ivi-shell-Fix-crash-due-no-transmitter-screen.patch \
    file://0003-compositor-drm-introduce-drm_get_dmafd_from_view.patch \
    file://0001-config-parser-Export-get_full_path-and-destroy.patch \
    "
EXTRA_OECONF_append = " --enable-sys-uid"
