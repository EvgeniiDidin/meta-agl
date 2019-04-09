require ${COREBASE}/meta/recipes-core/dbus/dbus_1.12.10.bb

FILESEXTRAPATHS_prepend := "${COREBASE}/meta/recipes-core/dbus/dbus:${THISDIR}/dbus-cynara:"
S = "${WORKDIR}/dbus-${PV}"

SRC_URI_append = "\
   file://0001-Integration-of-Cynara-asynchronous-security-checks.patch \
   file://0002-Disable-message-dispatching-when-send-rule-result-is.patch \
   file://0003-Handle-unavailability-of-policy-results-for-broadcas.patch \
   file://0004-Add-own-rule-result-unavailability-handling.patch \
   file://0005-Perform-Cynara-runtime-policy-checks-by-default.patch \
"

DEPENDS += "cynara smack"
RDEPENDS_${PN} += "dbus"

EXTRA_OECONF += "--enable-cynara --disable-selinux"

inherit distro_features_check
REQUIRED_DISTRO_FEATURES += "smack"

# Only the main package gets created here, everything else remains in the
# normal dbus recipe.
do_install_append () {
    for i in ${@' '.join([d.getVar('D', True) + x for x in (' '.join([d.getVar('FILES_${PN}-' + p, True) or '' for p in ['lib', 'dev', 'staticdev', 'doc', 'locale', 'ptest']])).split()])}; do
        rm -rf $i
    done

    # Try to remove empty directories, starting with the
    # longest path (= deepest directory) first.
    # Find needs a valid current directory. Somehow the directory
    # we get called in is gone by the time that we get invoked.
    ( cd ${D}
      for i in `find . -type d | sort -r`; do
        rmdir $i || true
      done
    )
}

# Avoid warning about dbus and dbus-cynara providing dbus-x11.
RPROVIDES_${PN}_remove = "${OLDPKGNAME}"
