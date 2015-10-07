SUMMARY = "Cross SDK of AGL Distribution for IVI profile"

DESCRIPTION = "Basic image for baseline of AGL Distribution for IVI profile. \
It includes the full meta-toolchain, plus developement headers and libraries \
to form a standalone cross SDK."

require agl-image-ivi.bb

IMAGE_FEATURES += "dev-pkgs"
IMAGE_INSTALL += "kernel-dev"

inherit populate_sdk
