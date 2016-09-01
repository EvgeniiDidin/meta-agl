LICENSE = "LGPL-2.1"
LIC_FILES_CHKSUM = "file://COPYING;md5=b42382de5d854b9bb598acf2e8827de3"

#SRC_URI = "git://github.com/CogentEmbedded/automotive-message-broker.git;protocol=https;branch=master"
#SRCREV = "58569fac42bb8b6e1ad208caef5db8a51befc87f"

SRC_URI = "git://github.com/otcshare/automotive-message-broker.git;branch=0.14"
SRCREV = "c216955d16ca275159891cad296217094d972390"
#SRCREV = "c26819073d2a1444a156e4d2e3b61bef81663ea5"

PV = "0.14+git${SRCPV}"

# The paches from 0001 to 0009 are from difference between
# hash:58569fac42bb8b6e1ad208caef5db8a51befc87f(main branch) and
# hash:8f761e02172544212915c82b7e8dd8d4dd1281a6(dev_0.14_2)
SRC_URI += " \
    file://ambd.service \
    file://gps \
    "
#    file://0001-Improve-backward-compatibility-with-old-linaro-gcc.patch 
#    file://0002-Fix-library-versioning.patch 
#    file://0003-AmbSignalMapper-fix-can-interface-specification.patch 
#    file://0004-cansocketbcm-Fix-reading-of-frames-in-case-of-RX_TIM.patch 
#    file://0005-ambctl-remove-unnecessary-dependency-on-glib-introsp.patch 
#    file://0006-cangen-Implement-basic-handling-of-RX_TIMEOUT.patch 
#    file://0007-WORKAROUND-Allow-amb-qt-binding-to-work-in-case-of-m.patch 
#    file://0008-Add-simple-Qt-QML-example.patch 
#    file://0009-Add-Pressure-property-to-BrakeOperation.patch 
#    file://0001-Fix-build-issues-while-bitbake-without-meta-qt5-laye.patch 

S = "${WORKDIR}/git"

INSANE_SKIP_{PN} += "dev-elf"
INSANE_SKIP_{PN} += "dev-deps"
INSANE_SKIP_{PN}-devel += "dev-elf"
INSANE_SKIP_{PN}-devel += "dev-deps"
