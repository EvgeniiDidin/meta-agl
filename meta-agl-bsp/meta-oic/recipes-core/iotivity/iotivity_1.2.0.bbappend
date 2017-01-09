DEPENDS += " glib-2.0-native"
FILESEXTRAPATHS_prepend := "${THISDIR}/files:"
SRC_URI += "file://0081-yocto-Add-aarch64-for-DragonBoard-410c.patch"
SRC_URI += "file://0364-yocto-Use-tools-from-sysroot-before-system-PATH-agai.patch"
