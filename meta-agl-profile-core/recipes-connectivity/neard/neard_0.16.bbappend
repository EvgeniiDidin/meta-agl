FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SRC_URI_append = "file://0001-systemd-neard-add-multi-user.target-to-neard.service.patch"
SYSTEMD_SERVICE_${PN} = "neard.service"
