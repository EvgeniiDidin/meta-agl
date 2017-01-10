FILESEXTRAPATHS_append := ":${THISDIR}/files"

SRC_URI_append = "\
    file://check_SYS_getrandom.patch \
    "


# backport from https://patchwork.openembedded.org/patch/133002/
