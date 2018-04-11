DESCRIPTION = "Waltham is a network IPC library designed to resemble Wayland both protocol and protocol-API wise"
HOMEPAGE = "https://github.com/waltham/waltham"

LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://waltham-transmitter/COPYING;md5=f21c9af4de068fb53b83f0b37d262ec3"

DEPENDS += "libdrm virtual/kernel wayland waltham weston gstreamer1.0 gstreamer gstreamer1.0-plugins-base gstreamer1.0-plugins-good"

SRC_URI = "git://gerrit.automotivelinux.org/gerrit/p/src/weston-ivi-plugins.git;protocol=https"
SRCREV = "a1974a6a8cf8ed073b08bc65b01a6a6e99251723"

S = "${WORKDIR}/git/"

WALTHAM_PIPELINE ?= "waltham-transmitter/waltham-renderer/pipeline_example_general.cfg"
WALTHAM_RECIEVER_IP ?= "192.168.1.2"
WALTHAM_RECEIVER_PORT ?= "3440"

inherit pkgconfig cmake

do_install_append () {
   install -d ${D}/etc/xdg/weston/
   install ${S}/${WALTHAM_PIPELINE} ${D}/etc/xdg/weston/pipeline.cfg

   sed -i -e "s/YOUR_RECIEVER_IP/${WALTHAM_RECIEVER_IP}/g" ${D}/etc/xdg/weston/pipeline.cfg
   sed -i -e "s/YOUR_RECIEVER_PORT/${WALTHAM_RECEIVER_PORT}/g" ${D}/etc/xdg/weston/pipeline.cfg

}

FILES_${PN} += "/etc/xdg/weston/*.cfg"
FILES_${PN} += "${libdir}/*"
