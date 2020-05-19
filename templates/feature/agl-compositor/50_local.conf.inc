DISTRO_FEATURES_append = " agl-compositor"

# note that these are for testing only, should be removed once the changes
# land in their respective repositories

# shell client
AGL_BRANCH_pn-homescreen = "sandbox/mvlad/agl-compositor"
SRCREV_pn-homescreen = "${AUTOREV}"
DEPENDS_append_pn-homescreen = " wayland-native wayland qtwayland qtwayland-native"

# normal apps
AGL_BRANCH_pn-launcher = "sandbox/mvlad/agl-compositor"
SRCREV_pn-launcher = "${AUTOREV}"
DEPENDS_append_pn-launcher = " wayland-native wayland qtwayland qtwayland-native"
AGL_BRANCH_pn-hvac = "sandbox/mvlad/agl-compositor"
SRCREV_pn-hvac = "${AUTOREV}"
DEPENDS_append_pn-hvac = " libafb-helpers-qt"
AGL_BRANCH_pn-ondemandnavi = "sandbox/mvlad/agl-compositor"
SRCREV_pn-ondemandnavi = "${AUTOREV}"
AGL_BRANCH_pn-mediaplayer = "sandbox/mvlad/agl-compositor"
SRCREV_pn-mediaplayer = "${AUTOREV}"
AGL_BRANCH_pn-alexa-viewer = "sandbox/mvlad/agl-compositor"
SRCREV_pn-alexa-viewer = "${AUTOREV}"
DEPENDS_append_pn-alexa-viewer = " wayland-native wayland qtwayland qtwayland-native"
AGL_BRANCH_pn-onscreenapp = "sandbox/mvlad/agl-compositor"
SRCREV_pn-onscreenapp = "${AUTOREV}"
AGL_BRANCH_pn-settings = "sandbox/mvlad/agl-compositor"
SRCREV_pn-settings = "${AUTOREV}"

# other apps
AGL_BRANCH_pn-radio = "sandbox/mvlad/agl-compositor"
SRCREV_pn-radio = "${AUTOREV}"
AGL_BRANCH_pn-dashboard = "sandbox/mvlad/agl-compositor"
SRCREV_pn-dashboard = "${AUTOREV}"
AGL_BRANCH_pn-taskmanager = "sandbox/mvlad/agl-compositor"
SRCREV_pn-taskmanager = "${AUTOREV}"
AGL_BRANCH_pn-phone = "sandbox/mvlad/agl-compositor"
SRCREV_pn-phone = "${AUTOREV}"
AGL_BRANCH_pn-poiapp = "sandbox/mvlad/agl-compositor"
SRCREV_pn-poiapp = "${AUTOREV}"
AGL_BRANCH_pn-mixer = "sandbox/mvlad/agl-compositor"
SRCREV_pn-mixer = "${AUTOREV}"
AGL_BRANCH_pn-messaging = "sandbox/mvlad/agl-compositor"
SRCREV_pn-messaging = "${AUTOREV}"

# use agl-service-homescreen
AGL_BRANCH_pn-agl-service-homescreen = "sandbox/mvlad/agl-compositor"
SRCREV_pn-agl-service-homescreen = "${AUTOREV}"
