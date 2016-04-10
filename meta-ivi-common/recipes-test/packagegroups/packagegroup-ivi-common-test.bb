SUMMARY = "Utilities for testing of AGL"
DESCRIPTION = "A set of common packages required by testing AGL for Quality Assurance"

LICENSE = "MIT"

inherit packagegroup

PACKAGES = "\
    packagegroup-ivi-common-test \
    packagegroup-ivi-common-test-ltp \
    "

ALLOW_EMPTY_${PN} = "1"

RDEPENDS_${PN} += "\
    bc \
    blobsallad \
    dbench \
    ebizzy \
    ffsb \
    interbench \
    iozone3 \
    iperf \
    himeno \
    nbench-byte \
    netperf \
    netpipe \
    packagegroup-ivi-common-test-ltp \
    rt-tests \
    wayland-fits \
    "


# Packages for shell commands which are required by LTP
#   readelf, logrotate, vsftpd, crontab, sar, arp, ftp,
#   host, rcp, rlogin, rsh, tcpdump, expect, iptables, dnsmasq,
#   pgrep
RDEPENDS_packagegroup-ivi-common-test-ltp += " \
    initscripts-functions bind-utils binutils \
    cronie dnsmasq expect inetutils-ftp inetutils-rsh \
    iptables logrotate net-tools sysstat tcpdump vsftpd \
    "
