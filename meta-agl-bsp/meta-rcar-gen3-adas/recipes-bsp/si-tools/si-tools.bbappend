FILESEXTRAPATHS_append := ":${THISDIR}/files"

SRC_URI += " \
    file://si-tools-fm-improvements.patch \
"

EXTRA_OEMAKE_append = " 'LDFLAGS=${LDFLAGS}'"

