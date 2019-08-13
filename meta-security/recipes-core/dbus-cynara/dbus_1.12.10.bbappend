FILESEXTRAPATHS_prepend := "${THISDIR}/dbus-cynara:"

SRC_URI_append_class-target = "\
   file://0001-Integration-of-Cynara-asynchronous-security-checks.patch \
   file://0002-Disable-message-dispatching-when-send-rule-result-is.patch \
   file://0003-Handle-unavailability-of-policy-results-for-broadcas.patch \
   file://0004-Add-own-rule-result-unavailability-handling.patch \
   file://0005-Perform-Cynara-runtime-policy-checks-by-default.patch \
"

DEPENDS_append_class-target = " cynara smack"
EXTRA_OECONF_append_class-target = " ${@bb.utils.contains('DISTRO_FEATURES','smack','--enable-cynara --disable-selinux','',d)}"

