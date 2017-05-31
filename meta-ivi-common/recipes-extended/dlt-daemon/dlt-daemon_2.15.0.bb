SUMMARY = "Diagnostic Log and Trace"
DESCRIPTION = "This component provides a standardised log and trace interface, \
based on the standardised protocol specified in the AUTOSAR standard 4.0 DLT. \
This component can be used by GENIVI components and other applications as \
logging facility providing: \
- the DLT shared library \
- the DLT daemon, including startup scripts \
- the DLT daemon adaptors- the DLT client console utilities \
- the DLT test applications"
HOMEPAGE = "https://www.genivi.org/"
SECTION = "console/utils"
LICENSE = "MPLv2"
LIC_FILES_CHKSUM = "file://LICENSE;md5=8184208060df880fe3137b93eb88aeea"

DEPENDS = "dbus zlib pigz-native"
do_unpack[depends] += "pigz-native:do_populate_sysroot"

SRCREV = "e9a486a08fff6d3cc7133a350cec3ee10f463207"
SRC_URI = "git://git.projects.genivi.org/${BPN}.git;protocol=http \
    file://0002-Don-t-execute-processes-as-a-specific-user.patch \
    file://0004-Modify-systemd-config-directory.patch \
    "
S = "${WORKDIR}/git"

inherit autotools gettext cmake systemd

# -fPIC is needed to prevent relocation errors when we compile gtest with
# Yocto security flags. See this issue for more details:
#
# https://github.com/google/googletest/issues/854
#
# If that issue is fixed, we can probably remove the manual -fPIC flags here.
OECMAKE_C_FLAGS += "-fPIC"
OECMAKE_CXX_FLAGS += "-fPIC"

PACKAGES += "${PN}-systemd"
SYSTEMD_PACKAGES = "${PN} ${PN}-systemd"
SYSTEMD_SERVICE_${PN} = "dlt-system.service dlt.service"
SYSTEMD_AUTO_ENABLE_${PN} = "enable"
SYSTEMD_SERVICE_${PN}-systemd = "dlt-example-user.service \
    dlt-dbus.service \
    dlt-adaptor-udp.service \
    dlt-receive.service"
SYSTEMD_AUTO_ENABLE_${PN}-systemd = "disable"

EXTRA_OECMAKE = "-DWITH_SYSTEMD=ON"

FILES_${PN}-doc += "/usr/share/dlt-filetransfer"

do_install_append() {
   rm -f ${D}${bindir}/dlt-test-*
}
