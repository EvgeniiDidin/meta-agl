FILESEXTRAPATHS_append := ":${THISDIR}/${PN}"

# NOTE:
#    file://0003-compositor-drm-introduce-drm_get_dmafd_from_view.patch
#    has been removed until someone more familiar with weston internals
#    and waltham can take a look and update it.
SRC_URI_append = "\
    file://0001-Allow-regular-users-to-launch-Weston_7.0.0.patch \
    file://use-XDG_RUNTIMESHARE_DIR.patch \
    file://0002-ivi-shell-Fix-crash-due-no-transmitter-screen.patch \
    file://0001-config-parser-Export-get_full_path-and-destroy.patch \
    "

EXTRA_OEMESON_append = " -Denable-user-start=true"
