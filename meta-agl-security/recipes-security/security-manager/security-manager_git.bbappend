
FILESEXTRAPATHS_append := ":${THISDIR}/security-manager"

SRC_URI += " \
   file://Removing-tizen-platform-config.patch \
   file://removes-dependency-to-libslp-db-utils.patch \
"

DEPENDS = " \
attr \
boost \
cynara \
icu \
libcap \
smack \
sqlite3 \
sqlite3-native \
systemd \
"

