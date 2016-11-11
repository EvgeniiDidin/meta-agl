#inherit append-code-change

FILESEXTRAPATHS_prepend := "${THISDIR}/patches/:"

SRC_URI_append = " \
    file://add-dependency-of-pthreads.patch \
"
