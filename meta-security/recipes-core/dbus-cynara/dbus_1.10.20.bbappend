FILESEXTRAPATHS_append := ":${THISDIR}/${PN}"

SRC_URI_append = "\
   file://0001-Integration-of-Cynara-asynchronous-security-checks.patch \
   file://0002-Disable-message-dispatching-when-send-rule-result-is.patch \
   file://0003-Handle-unavailability-of-policy-results-for-broadcas.patch \
   file://0004-Add-own-rule-result-unavailability-handling.patch \
   file://0005-Perform-Cynara-runtime-policy-checks-by-default.patch \
"

DEPENDS_append_class-target = " cynara"
EXTRA_OECONF_append_class-target = " --disable-selinux --enable-cynara"

