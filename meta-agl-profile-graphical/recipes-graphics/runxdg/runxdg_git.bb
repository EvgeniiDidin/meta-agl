SUMMARY     = "Launcher of XDG application on AGL HMI Framework (2017)"
DESCRIPTION = "The command 'runxdg' is a launcher to execute XDG application \
               on AGL HMI Framework which using wayland-ivi-extension"
HOMEPAGE    = "https://git.automotivelinux.org/staging/xdg-launcher"
LICENSE     = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

DEPENDS = "json-c wayland wayland-ivi-extension libhomescreen libwindowmanager"

inherit cmake

SRC_URI = "git://gerrit.automotivelinux.org/gerrit/staging/xdg-launcher;protocol=https;branch=${AGL_BRANCH}"
SRCREV  = "${AGL_APP_REVISION}"

PV = "1.0+git${SRCPV}"
S  = "${WORKDIR}/git"
