SUMMARY = "Cross SDK of Full AGL Distribution for core profile"

DESCRIPTION = "SDK image for full AGL Distribution for IVI profile. \
It includes the full meta-toolchain, plus developement headers and libraries \
to form a standalone cross SDK."

require agl-image-minimal.bb

LICENSE = "MIT"

IMAGE_FEATURES_append = " dev-pkgs"
IMAGE_INSTALL_append = " kernel-dev kernel-devsrc"

# required dependencies for app and test builds
# also in the minimal image (SPEC-1678)
TOOLCHAIN_HOST_TASK += " \
    nativesdk-lua \
    "

# required dependencies for app and test builds
# also in the minimal image (SPEC-1678)
TOOLCHAIN_TARGET_TASK += " \
    lua-dev \
    lua-staticdev \
    libafb-helpers-staticdev \
    libappcontroller-staticdev \
    "

inherit populate_sdk

# Task do_populate_sdk and do_rootfs can't be exec simultaneously.
# Both exec "createrepo" on the same directory, and so one of them
# can failed (randomly).
addtask do_populate_sdk after do_rootfs

