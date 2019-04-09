DESCRIPTION = "Cynara service with client libraries"
LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://LICENSE;md5=86d3f3a95c324c9479bd8986968f4327;beginline=3"

PV = "0.14.10+git${SRCPV}"
SRCREV = "be455dcaf1400bec0272a6ce90852b9147393a60"
SRC_URI = "git://github.com/Samsung/cynara.git"
S = "${WORKDIR}/git"

SRC_URI += " \
  file://cynara-db-migration-abort-on-errors.patch \
  file://0001-Add-fallthrough-tags.patch \
  file://0002-gcc-7-requires-include-functional-for-std-function.patch \
  file://0003-Avoid-warning-when-compiling-without-smack.patch \
  file://0004-Fix-mode-of-sockets.patch \
  file://0005-Allow-to-tune-sockets.patch \
  file://0006-Install-socket-activation-by-default.patch \
  file://0001-fix-fallthrough-in-cmdlineparser.patch \
"

DEPENDS = " \
glib-2.0 \
systemd \
zip \
"

PACKAGECONFIG ??= ""
# Use debug mode to increase logging. Beware, also compiles with less optimization
# and thus has to disable FORTIFY_SOURCE below.
PACKAGECONFIG[debug] = "-DCMAKE_BUILD_TYPE=DEBUG,-DCMAKE_BUILD_TYPE=RELEASE,libunwind elfutils"

inherit cmake

EXTRA_OECMAKE += " \
  -DCMAKE_VERBOSE_MAKEFILE=ON \
  -DBUILD_WITH_SYSTEMD_DAEMON=ON \
  -DBUILD_WITH_SYSTEMD_JOURNAL=ON \
  -DSYSTEMD_UNIT_DIR=${systemd_system_unitdir} \
  -DSOCKET_DIR=/run/cynara \
  -DBUILD_COMMONS=ON \
  -DBUILD_SERVICE=ON \
  -DBUILD_DBUS=OFF \
  -DCYNARA_ADMIN_SOCKET_GROUP=cynara \
"

# Explicitly package empty directory. Otherwise Cynara prints warnings
# at runtime:
# cyad[198]: Couldn't scan for plugins in </usr/lib/cynara/plugin/service/> : <No such file or directory>
FILES_${PN}_append = " \
${libdir}/cynara/plugin/service \
${libdir}/cynara/plugin/client \
"

inherit useradd
USERADD_PACKAGES = "${PN}"
GROUPADD_PARAM_${PN} = "-r cynara"
USERADD_PARAM_${PN} = "\
--system --home ${localstatedir}/lib/empty \
--no-create-home --shell /bin/false \
--gid cynara cynara \
"

# Causes deadlock during booting, see workaround in postinst below.
#inherit systemd
#SYSTEMD_SERVICE_${PN} = "cynara.service"

#do_install_append () {
#   chmod a+rx ${D}/${sbindir}/cynara-db-migration
#
#   install -d ${D}${sysconfdir}/cynara/
#   install -m 644 ${S}/conf/creds.conf ${D}/${sysconfdir}/cynara/creds.conf
#
#   # No need to create empty directories except for those which
#   # Cynara expects to find.
#   # install -d ${D}${localstatedir}/cynara/
#   # install -d ${D}${prefix}/share/cynara/tests/empty_db
#   install -d ${D}${libdir}/cynara/plugin/client
#   install -d ${D}${libdir}/cynara/plugin/service
#
#   # install db* ${D}${prefix}/share/cynara/tests/
#
#   install -d ${D}${systemd_system_unitdir}/sockets.target.wants
#   ln -s ../cynara.socket ${D}${systemd_system_unitdir}/sockets.target.wants/cynara.socket
#   ln -s ../cynara-admin.socket ${D}${systemd_system_unitdir}/sockets.target.wants/cynara-admin.socket
#   ln -s ../cynara-agent.socket ${D}${systemd_system_unitdir}/sockets.target.wants/cynara-agent.socket
#}

# We want the post-install logic to create and label /var/cynara, so
# it should not be in the package.
do_install_append () {
    rmdir ${D}${localstatedir}/cynara
}

FILES_${PN} += "${systemd_system_unitdir}"

# Cynara itself has no dependency on Smack. Only its installation
# is Smack-aware in the sense that it sets Smack labels. Do not
# depend on smack userspace unless we really need Smack labels.
#
# The Tizen .spec file calls cynara-db-migration in a %pre section.
# That only works when cynara-db-migration is packaged separately
# (overly complex) and does not seem necessary: perhaps there is a
# time window where cynara might already get activated before
# the postinst completes, but that is a general problem. It gets
# avoided entirely when calling this script while building the
# rootfs.
DEPENDS_append_with-lsm-smack = " smack smack-native"
EXTRA_OECMAKE_append_with-lsm-smack = " -DDB_FILES_SMACK_LABEL=System"
CHSMACK_with-lsm-smack = "chsmack"
CHSMACK = "true"
pkg_postinst_ontarget_${PN} () {
   mkdir -p $D${sysconfdir}/cynara
   ${CHSMACK} -a System $D${sysconfdir}/cynara

   # Strip git patch level information, the version comparison code
   # in cynara-db-migration only expect major.minor.patch version numbers.
   VERSION=${@d.getVar('PV',d,1).split('+git')[0]}
   if [ -d $D${localstatedir}/cynara ] ; then
      # upgrade
      echo "NOTE: updating cynara DB to version $VERSION"
      $D${sbindir}/cynara-db-migration upgrade -f 0.0.0 -t $VERSION
   else
      # install
      echo "NOTE: creating cynara DB for version $VERSION"
      mkdir -p $D${localstatedir}/cynara
      ${CHSMACK} -a System $D${localstatedir}/cynara
      $D${sbindir}/cynara-db-migration install -t $VERSION
   fi

   # Workaround for systemd.bbclass issue: it would call
   # "systemctl start" without "--no-block", but because
   # the service is not ready to run at the time when
   # this scripts gets executed by run-postinsts.service,
   # booting deadlocks.
   echo "NOTE: enabling and starting cynara service"
   systemctl enable cynara
   systemctl start --no-block cynara
}

# Testing depends on gmock and gtest. They can be found in meta-oe
# and are not necessarily available, so this feature is off by default.
# If gmock from meta-oe is used, then a workaround is needed to avoid
# a link error (libgmock.a calls pthread functions without libpthread
# being listed in the .pc file).
DEPENDS_append = "${@bb.utils.contains('PACKAGECONFIG', 'tests', ' gmock', '', d)}"
LDFLAGS_append = "${@bb.utils.contains('PACKAGECONFIG', 'tests', ' -lpthread', '', d)}"
SRC_URI_append = "${@bb.utils.contains('PACKAGECONFIG', 'tests', ' file://run-ptest', '', d)}"
PACKAGECONFIG[tests] = "-DBUILD_TESTS:BOOL=ON,-DBUILD_TESTS:BOOL=OFF,gmock gtest,"

# Will be empty if no tests were built.
inherit ptest
FILES_${PN}-ptest += "${bindir}/cynara-tests ${bindir}/cynara-db-migration-tests ${datadir}/cynara/tests"
do_install_ptest () {
    if ${@bb.utils.contains('PACKAGECONFIG', 'tests', 'true', 'false', d)}; then
        mkdir -p ${D}/${datadir}/cynara/tests
        cp -r ${S}/test/db/* ${D}/${datadir}/cynara/tests
    fi
}

