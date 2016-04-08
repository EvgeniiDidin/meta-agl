FILESEXTRAPATHS_prepend := ":${THISDIR}/wayland-ivi-extension:"


SRC_URI_append = " \
                  file://0001-Send-process-ID-that-created-surface-to-client.patch \
                 "

