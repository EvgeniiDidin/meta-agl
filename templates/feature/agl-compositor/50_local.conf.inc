DISTRO_FEATURES_append = " agl-compositor"

# note that these are for testing only, should be removed once the changes
# land in their respective repositories

# shell client
AGL_BRANCH_pn-homescreen = "sandbox/mvlad/agl-compositor"
SRCREV_pn-homescreen = "745f1d9e86e8cbd83c5ae84aba2513341da5ad7a"
DEPENDS_append_pn-homescreen = " wayland-native wayland qtwayland qtwayland-native"

# normal apps
AGL_BRANCH_pn-launcher = "sandbox/mvlad/agl-compositor"
SRCREV_pn-launcher = "0b53ebc5e8c0df2fad64ea5b60fda05ae0aafb3b"
DEPENDS_append_pn-launcher = " wayland-native wayland qtwayland qtwayland-native"
AGL_BRANCH_pn-hvac = "sandbox/mvlad/agl-compositor"
SRCREV_pn-hvac = "2afae8c55678cf070ee1a41137be48019ea4872c"
DEPENDS_append_pn-hvac = " libafb-helpers-qt"
AGL_BRANCH_pn-navigation-demo = "sandbox/mvlad/agl-compositor"
SRCREV_pn-navigation-demo = "d98e5a070e4109e28289000a7d99ff6fc91b5670"
AGL_BRANCH_pn-mediaplayer = "sandbox/mvlad/agl-compositor"
SRCREV_pn-mediaplayer = "9d3d0bfa6de3c21b1c770d18f4e3ea6dba6a68db"
