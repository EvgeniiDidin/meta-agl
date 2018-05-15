SUMMARY = "The software for application framework of AGL IVI profile"
DESCRIPTION = "A set of packages belong to AGL application framework which required by \
Multimedia Subsystem"

LICENSE = "MIT"

inherit packagegroup

PACKAGES = "\
    packagegroup-agl-core-multimedia \
    "

RDEPENDS_${PN} += "\
    ${@bb.utils.contains('DISTRO_FEATURES', 'agl-audio-4a-framework', '' , 'agl-audio-plugin', d)} \
    alsa-utils \
    pulseaudio-server \
    pulseaudio-misc \
    ${@bb.utils.contains('DISTRO_FEATURES', 'bluetooth', '\
        pulseaudio-module-bluetooth-discover \
        pulseaudio-module-bluetooth-policy \
        pulseaudio-module-bluez5-discover \
        pulseaudio-module-bluez5-device \
        pulseaudio-module-switch-on-connect \
        pulseaudio-module-loopback \
        ','', d)} \
    gstreamer1.0-meta-base \
    "
