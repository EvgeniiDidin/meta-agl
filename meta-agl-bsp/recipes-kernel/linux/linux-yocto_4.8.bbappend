FILESEXTRAPATHS_prepend := "${THISDIR}/linux-yocto:"

# Backported fix for CVE-2017-1000364
SRC_URI_append = " file://4.8-0001-SEC-Backport-Fix-CVE-2017-1000364-through-backport.patch "
