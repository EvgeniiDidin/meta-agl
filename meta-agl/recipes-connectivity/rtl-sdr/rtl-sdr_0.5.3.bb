SUMMARY = "Turns a Realtek RTL2832U-based DVB dongle into a SDR receiver"
DESCRIPTION = "DVB-T dongles based on the Realtek RTL2832U chipset can be used as Software Digital Radio adapters, since the chip allows transferring raw I/Q samples to the host, which is really used for DAB/DAB+/FM demodulation."
HOMEPAGE = "http://sdr.osmocom.org/trac/wiki/rtl-sdr"

LICENSE = "GPLv2+"
LIC_FILES_CHKSUM = "file://COPYING;md5=751419260aa954499f7abaabaa882bbe \
                    file://src/librtlsdr.c;endline=18;md5=1b05599c3ebd4d74857a0a7c45f3d4ef"

DEPENDS = "libusb1"

SRC_URI = "git://git.osmocom.org/rtl-sdr"
SRCREV = "df9596b2d1ebd36cdb14549cfdd76c25092e14d0"
S = "${WORKDIR}/git"

inherit autotools pkgconfig

EXTRA_OECONF = "--enable-driver-detach"
