
# Enabling ptest in image ...

OVERRIDES .= ":agl-ptest"
EXTRA_OECMAKE_append = " -DBUILD_TEST_WGT=TRUE"
DISTRO_FEATURES_append = " ptest"
EXTRA_IMAGE_FEATURES_append = " ptest-pkgs"

# / ptest
