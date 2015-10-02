SUMMARY = "A basic system of AGL distribution of IVI profile"
require ${PN}.inc

IMAGE_INSTALL_append = "\
    packagegroup-agl-core \
    packagegroup-agl-ivi \
    packagegroup-ivi-common-core \
    "
