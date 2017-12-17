FILESEXTRAPATHS_append_class-native := ":${THISDIR}/${PN}"
SRC_URI_append_class-native = " file://removing-capability-enforcement.patch"
