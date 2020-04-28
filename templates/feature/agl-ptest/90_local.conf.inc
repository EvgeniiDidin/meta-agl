
# Enabling ptest in image ...

OVERRIDES .= ":agl-ptest"
DISTRO_FEATURES_append = " ptest"
EXTRA_IMAGE_FEATURES_append = " ptest-pkgs"

# / ptest
