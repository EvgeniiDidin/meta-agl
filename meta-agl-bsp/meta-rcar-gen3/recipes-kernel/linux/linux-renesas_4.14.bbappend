FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SRC_URI_append = "\
       file://0001-give-up-on-gcc-ilog2-constant-optimizations.patch \
       "
