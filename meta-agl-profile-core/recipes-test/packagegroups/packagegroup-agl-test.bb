SUMMARY = "Utilities for testing of AGL"
DESCRIPTION = "A set of common packages required by testing AGL for Quality Assurance"

LICENSE = "MIT"

inherit packagegroup

PACKAGES = "\
    packagegroup-agl-test \
    packagegroup-agl-test-ltp \
    packagegroup-ivi-common-test \
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
    iperf3 \
    ipv6connect \
    linpack \
    linus-stress \
    lmbench \
    nbench-byte \
    rt-tests \
    stress \
    "
# to be added, but needs LICENSE_FLAGS_WHITELIST="non-commercial"
#    netperf

# FTBS, SPEC-316
#    himeno 
# FTBS, SPEC-1384
#    trinity

#    packagegroup-agl-test-ltp \
#    ltp \
#

# Packages for shell commands which are required by LTP
#   readelf, logrotate, vsftpd, crontab, sar, arp, ftp,
#   host, rcp, rlogin, rsh, tcpdump, expect, iptables, dnsmasq,
#   pgrep
RDEPENDS_packagegroup-agl-test-ltp += " \
    initscripts-functions bind-utils binutils \
    cronie dnsmasq expect inetutils-ftp inetutils-rsh \
    iptables logrotate net-tools sysstat tcpdump vsftpd \
    "

RDEPENDS_packagegroup-ivi-common-test = " \
    packagegroup-agl-test \
    "
