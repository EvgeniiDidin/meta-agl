SUMMARY = "A basic system of AGL distribution of IVI profile"

IMAGE_FEATURES += "splash package-management ssh-server-dropbear"

LICENSE = "MIT"

inherit core-image distro_features_check

REQUIRED_DISTRO_FEATURES = "wayland"

CORE_IMAGE_BASE_INSTALL += "weston weston-init weston-examples"

IMAGE_INSTALL_append = "\
    packagegroup-agl-core \
    packagegroup-agl-ivi \
    "
