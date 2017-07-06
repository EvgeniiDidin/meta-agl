FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SRC_URI_append  = " file://namespace_fix.cfg \
	file://nbd.cfg \
	file://ramdisk.cfg \
	file://bluetooth.cfg \
	file://ath9k_htc.cfg \
	file://disable_ipv6.cfg \
	"
