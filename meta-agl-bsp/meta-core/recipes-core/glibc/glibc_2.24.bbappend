FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

# include fix for CVE-2017-1000366
SRC_URI_append = " file://CVE-2017-1000366.backport.patch"