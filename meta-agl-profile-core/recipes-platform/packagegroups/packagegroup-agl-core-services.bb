DESCRIPTION = "The minimal set of packages for Connectivity Subsystem"
LICENSE = "MIT"

inherit packagegroup

PACKAGES = "\
    packagegroup-agl-core-services \
    "

ALLOW_EMPTY_${PN} = "1"

RDEPENDS_${PN} += "\
agl-service-bluetooth \
agl-service-bluetooth-pbap \
agl-service-can-low-level \
agl-service-data-persistence \
agl-service-geoclue \
agl-service-geofence \
agl-service-gps \
agl-service-identity-agent \
agl-service-iiodevices \
agl-service-mediascanner \
agl-service-navigation \
agl-service-network \
agl-service-nfc \
${@bb.utils.contains('DISTRO_FEATURES', 'agl-audio-4a-framework', 'agl-service-radio', bb.utils.contains('DISTRO_FEATURES', 'pulseaudio','agl-service-radio','',d), d)} \
agl-service-signal-composer \
agl-service-steering-wheel \
agl-service-unicens \
agl-service-weather \
high-level-viwi-service \
    "
