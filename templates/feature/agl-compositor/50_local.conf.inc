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
AGL_BRANCH_pn-alexa-viewer = "sandbox/mvlad/agl-compositor"
SRCREV_pn-alexa-viewer = "38d77d0c07c2fbe76dda0e011b030855d57dd06c"
AGL_BRANCH_pn-onscreenapp = "sandbox/mvlad/agl-compositor"
SRCREV_pn-onscreenapp = "98dab0eebc3dc0f567be3f80ab129cbcc71738db"
AGL_BRANCH_pn-settings = "sandbox/mvlad/agl-compositor"
SRCREV_pn-settings = "ff650ab8c60a6cd218f4e981740ca41014cce7cc"

# other apps
AGL_BRANCH_pn-radio = "sandbox/mvlad/agl-compositor"
SRCREV_pn-radio = "1d542581205725de446376707dff7c31c61d04d8"
AGL_BRANCH_pn-dashboard = "sandbox/mvlad/agl-compositor"
SRCREV_pn-dashboard = "ea01446bbc5a9bfe739da10869f08b0bd2e82174"
AGL_BRANCH_pn-taskmanager = "sandbox/mvlad/agl-compositor"
SRCREV_pn-taskmanager = "516c53197ff82297ddf7ee1a55497f657e4abc19"
AGL_BRANCH_pn-phone = "sandbox/mvlad/agl-compositor"
SRCREV_pn-phone = "e29b1f9d6d7b17645c4ab65250520b1df612fd7c"
AGL_BRANCH_pn-poiapp = "sandbox/mvlad/agl-compositor"
SRCREV_pn-poiapp = "f7a0bc184e53ba5c756de079891d690eed0fc51e"
AGL_BRANCH_pn-mixer = "sandbox/mvlad/agl-compositor"
SRCREV_pn-mixer = "b6638c65ad9af59abfb2a571e11be5a73dc662b8"
AGL_BRANCH_pn-messaging = "sandbox/mvlad/agl-compositor"
SRCREV_pn-messaging = "eaa3566554111ad335cb73a219f920989ffcb70f"

# use agl-service-homescreen
AGL_BRANCH_pn-agl-service-homescreen = "sandbox/mvlad/agl-compositor"
SRCREV_pn-agl-service-homescreen = "79c9fb4fb8a8c8f6ebfbf0299f16e2ca4ddb56c6"
