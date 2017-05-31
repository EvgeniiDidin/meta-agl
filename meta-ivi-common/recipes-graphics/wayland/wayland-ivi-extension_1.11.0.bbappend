FILESEXTRAPATHS_prepend := ":${THISDIR}/wayland-ivi-extension:"

SRC_URI_append_wandboard = " file://wandboard_fix_build.patch"

# workaround paralellism issue:
PARALLEL_MAKE = ""
