IMAGE_FEATURES =+ "debug-tweaks eclipse-debug tools-debug tools-profile"

IMAGE_INSTALL_append = " \
    packagegroup-agl-devel \
"

# disable install of debug files in SDK
# initial value: SDKIMAGE_FEATURES="dev-pkgs dbg-pkgs staticdev-pkgs"
SDKIMAGE_FEATURES="dev-pkgs"
