SUMMARY = "AGL Audio Policy Plugin"
DESCRIPTION = "AGL PulseAudio Routing plugin, forked from the Tizen IVI \
PulseAudio Routing plugin, also known as module-murphy-ivi. This is a \
stripped-down version of the former, not needing Murphy anymore and using \
either a JSON configuration file or its own embedded configuration."
HOMEPAGE = "http://www.iot.bzh"

LICENSE = "LGPL-2.1"
LIC_FILES_CHKSUM = "file://COPYING;md5=2d5025d4aa3495befef8f17206a5b0a1"

DEPENDS = "json-c pulseaudio"
RDEPENDS_${PN} = "pulseaudio-server pulseaudio-module-null-sink pulseaudio-module-loopback"

SRCREV = "2d5b809de9d5b69fb9b1ad9e0f3ee5bd53eb2785"
SRC_URI = "git://github.com/iotbzh/agl-audio-plugin;protocol=https"

S = "${WORKDIR}/git"

inherit cmake pkgconfig

FULL_OPTIMIZATION = "-O1 -pipe ${DEBUG_FLAGS}"

FILES_${PN} += "${libdir}/pulse-6.0/modules/* ${sysconfdir}/pulse/*"
FILES_${PN}-dbg += "${libdir}/pulse-6.0/modules/.debug/*"
