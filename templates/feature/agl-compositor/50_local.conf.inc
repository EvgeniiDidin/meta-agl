DISTRO_FEATURES_append = " agl-compositor"

# note that these are for testing only, should be removed once the changes
# land in their respective repositories

# shell client
AGL_BRANCH_pn-homescreen = "sandbox/mvlad/agl-compositor"
SRCREV_pn-homescreen = "c1b3b05d436d270b0b6df6ef718309b1f0b82be3"
DEPENDS_append_pn-homescreen = " wayland-native wayland qtwayland qtwayland-native"

# normal apps
AGL_BRANCH_pn-launcher = "sandbox/mvlad/agl-compositor"
SRCREV_pn-launcher = "83496d2f6968f7d12a183581d320065bdba52132"
DEPENDS_append_pn-launcher = " wayland-native wayland qtwayland qtwayland-native"
AGL_BRANCH_pn-hvac = "sandbox/mvlad/agl-compositor"
SRCREV_pn-hvac = "2afae8c55678cf070ee1a41137be48019ea4872c"
DEPENDS_append_pn-hvac = " libafb-helpers-qt"
AGL_BRANCH_pn-ondemandnavi = "sandbox/mvlad/agl-compositor"
SRCREV_pn-ondemandnavi = "10acae987db859bace7d2dcf4913a21073d65990"
AGL_BRANCH_pn-mediaplayer = "sandbox/mvlad/agl-compositor"
SRCREV_pn-mediaplayer = "4518cdde5ddb053a4759f7b50f038c53bc41a45e"
