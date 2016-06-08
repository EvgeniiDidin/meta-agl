SUMMARY = "AGL Audio Policy Plugin"
DESCRIPTION = "AGL PulseAudio Routing plugin, forked from module-murphy-ivi"
HOMEPAGE = "http://www.iot.bzh"

LICENSE = "LGPL-2.1"
LIC_FILES_CHKSUM = "file://COPYING;md5=2d5025d4aa3495befef8f17206a5b0a1"

DEPENDS = "pulseaudio"
RDEPENDS_${PN} = "pulseaudio-server pulseaudio-module-null-sink pulseaudio-module-loopback"

SRCREV = "10f3fcb0f71edaad2a9c2a0e64e4e6c0277e58f3"
SRC_URI = "git://github.com/Tarnyko/agl-audio-plugin;protocol=https"

S = "${WORKDIR}/git"

inherit cmake pkgconfig

FULL_OPTIMIZATION = "-O1 -pipe ${DEBUG_FLAGS}"

FILES_${PN} += "${libdir}/pulse-6.0/modules/*"
FILES_${PN}-dbg += "${libdir}/pulse-6.0/modules/.debug/*"
