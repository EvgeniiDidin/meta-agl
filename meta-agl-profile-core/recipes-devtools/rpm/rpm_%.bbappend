FILESEXTRAPATHS_append := ":${THISDIR}/files"

SRC_URI_append = "\
    file://0001-Factor-out-and-unify-setting-CLOEXEC.patch \
    file://0002-Optimize-rpmSetCloseOnExec.patch \
    file://0003-rpmSetCloseOnExec-use-getrlimit.patch \
"
