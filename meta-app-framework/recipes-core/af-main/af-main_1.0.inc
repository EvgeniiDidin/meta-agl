SUMMARY = "AGL Framework Main part"
DESCRIPTION = "\
This is a core framework component for managing \
applications, widgets, and components. \
"

HOMEPAGE = "https://gerrit.automotivelinux.org/gerrit/#/admin/projects/src/app-framework-main"
LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://COPYING;md5=3b83ef96387f14655fc854ddc3c6bd57"

SRC_URI_git = "git://gerrit.automotivelinux.org/gerrit/src/app-framework-main;protocol=https;branch=master"
SRC_URI_files = ""
SRC_URI = "${SRC_URI_git} \
           ${SRC_URI_files} \
          "

SRCREV = "c2fa10efe8e8b2443883e7b04b2cf452b6b8dd85"
PV = "master+git${SRCPV}"

S = "${WORKDIR}/git"

afm_name    = "afm"
afm_confdir = "${sysconfdir}/${afm_name}"
afm_datadir = "/var/local/lib/${afm_name}"
afb_binding_dir = "${libdir}/afb"
systemd_units_root = "/usr/local/lib/systemd"

CFLAGS_append_agl-devel = " -DAGL_DEVEL"

