DESCRIPTION = "The minimal set of packages for Connectivity Subsystem"
LICENSE = "MIT"

inherit packagegroup

PACKAGES = "\
    packagegroup-agl-core-services \
    "

ALLOW_EMPTY_${PN} = "1"

RDEPENDS_${PN} += "\
agl-service-bluetooth \
agl-service-can-low-level \
agl-service-data-persistence \
agl-service-geoclue \
agl-service-geofence \
agl-service-gps \
agl-service-identity-agent \
agl-service-mediascanner \
agl-service-navigation \
agl-service-nfc \
agl-service-radio \
agl-service-signal-composer \
agl-service-steering-wheel \
agl-service-unicens \
agl-service-weather \
agl-service-wifi \
high-level-viwi-service \
    "
