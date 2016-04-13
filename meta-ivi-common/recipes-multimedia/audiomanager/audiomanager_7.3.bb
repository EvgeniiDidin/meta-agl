SUMMARY = "Genivi AudioManager"
HOMEPAGE = "https://www.genivi.org/"
SECTION = "multimedia"

LICENSE = "MPLv2"
LIC_FILES_CHKSUM = "file://LICENCE;md5=f164349b56ed530a6642e9b9f244eec5"
PR = "r1"

DEPENDS = "dlt-daemon dbus"

BRANCH = "master"

SRC_URI = " \
    git://git.projects.genivi.org/AudioManager.git;branch=${BRANCH};tag=${PV} \
    file://0001-Fix-duplicated-command-line-arg-t.patch \
    file://AudioManager.service \
    "

S = "${WORKDIR}/git"
inherit autotools gettext cmake pkgconfig systemd

EXTRA_OECMAKE += "-DWITH_TESTS=OFF -DUSE_BUILD_LIBS=OFF -DWITH_SYSTEMD_WATCHDOG=ON \
    -DWITH_DBUS_WRAPPER=ON"
OECMAKE_CXX_FLAGS +="-ldl"

PACKAGECONFIG ??= ""

# With CommonAPI support
PACKAGECONFIG[capi] = "-DWITH_CAPI_WRAPPER=ON,-DWITH_CAPI_WRAPPER=OFF,common-api-c++-dbus"

FILES_${PN} += " \
    ${@bb.utils.contains('DISTRO_FEATURES', 'systemd', '${systemd_user_unitdir}/AudioManager.service', '', d)} \
    "

do_install_append() {
    if ${@bb.utils.contains('DISTRO_FEATURES','systemd','true','false',d)}; then
        install -m 644 -p -D ${WORKDIR}/AudioManager.service ${D}${systemd_user_unitdir}/AudioManager.service

        mkdir -p ${D}/etc/systemd/user/default.target.wants/
        ln -sf ${systemd_user_unitdir}/AudioManager.service ${D}/etc/systemd/user/dbus-org.genivi.AudioManager.service
        ln -sf ${systemd_user_unitdir}/AudioManager.service ${D}/etc/systemd/user/default.target.wants/AudioManager.service
    fi
}
