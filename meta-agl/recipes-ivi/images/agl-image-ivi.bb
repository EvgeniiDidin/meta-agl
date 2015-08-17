SUMMARY = "A basic system of AGL distribution of IVI profile"
require recipes-ivi/images/agl-image-ivi.inc

IMAGE_INSTALL_append = "\
    packagegroup-agl-core \
    packagegroup-agl-ivi \
    packagegroup-ivi-common \
    "
