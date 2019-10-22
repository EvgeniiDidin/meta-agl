FILESEXTRAPATHS_append := ":${THISDIR}/${PN}"

SRC_URI_append = "\
    file://0001-Allow-regular-users-to-launch-Weston_2.0.0.patch \
    file://use-XDG_RUNTIMESHARE_DIR.patch \
    file://0003-compositor-drm-introduce-drm_get_dmafd_from_view.patch \
    "
# Disabled until SPEC-2827 H3ULCB v3.0 + Kingfisher issue is debugged:
#   file://0002-compositor-add-output-type-to-weston_output.patch

EXTRA_OECONF_append = " --enable-sys-uid"
