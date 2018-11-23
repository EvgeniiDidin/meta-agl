FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SRC_URI += "file://0001-disable-when-booting-over-nfs.patch \
            file://main.conf \
"

FILES_${PN} += "${sysconfdir}/connman/main.conf"

do_install_append() {
	install -d ${D}${sysconfdir}/connman
	install -m 0644 ${WORKDIR}/main.conf ${D}${sysconfdir}/connman
}
