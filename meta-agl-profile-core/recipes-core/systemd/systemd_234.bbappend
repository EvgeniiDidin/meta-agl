FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI += "\
    file://0001-Switch-Smack-label-earlier.patch \
    file://0001-missing_syscall.patch \
"

