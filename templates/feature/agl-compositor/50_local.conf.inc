DISTRO_FEATURES_append = " agl-compositor"

# note that these are for testing only, should be removed once the changes
# land in their respective repositories

# shell client
AGL_BRANCH_pn-homescreen = "sandbox/mvlad/agl-compositor"
DEPENDS_append_pn-homescreen = " wayland-native wayland qtwayland qtwayland-native"

# normal apps
AGL_BRANCH_pn-launcher = "sandbox/mvlad/agl-compositor"
AGL_BRANCH_pn-hvac = "sandbox/mvlad/agl-compositor"
DEPENDS_append_pn-hvac = " libafb-helpers-qt"
AGL_BRANCH_pn-navigation-demo = "sandbox/mvlad/agl-compositor"
AGL_BRANCH_pn-mediaplayer = "sandbox/mvlad/agl-compositor"
