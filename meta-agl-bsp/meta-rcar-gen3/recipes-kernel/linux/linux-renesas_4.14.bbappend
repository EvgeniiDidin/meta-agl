FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SRC_URI_append = "\
       file://0001-give-up-on-gcc-ilog2-constant-optimizations.patch \
       "

#Already present in 4.14
SRC_URI_remove =  "file://0004-Smack-Assign-smack_known_web-label-for-kernel-thread.patch"
