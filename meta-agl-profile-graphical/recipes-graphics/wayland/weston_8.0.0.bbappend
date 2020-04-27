FILESEXTRAPATHS_append := ":${THISDIR}/${PN}"

# NOTE:
#    file://0003-compositor-drm-introduce-drm_get_dmafd_from_view.patch
#    has been removed until someone more familiar with weston internals
#    and waltham can take a look and update it.
SRC_URI_append = "\
    file://0001-Allow-regular-users-to-launch-Weston_7.0.0.patch \
    file://use-XDG_RUNTIMESHARE_DIR.patch \
    file://0002-ivi-shell-Fix-crash-due-no-transmitter-screen.patch \
    file://0001-libweston-Expose-weston_output_damage-in-libweston.patch \
    file://0004-unconditionally-include-mman.h.patch \
    file://0005-add-memfd-create-option.patch \
    "

EXTRA_OEMESON_append = " -Denable-user-start=true -Dmemfd-create=false"
