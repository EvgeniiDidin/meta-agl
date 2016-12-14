FILESEXTRAPATHS_prepend := ":${THISDIR}/wayland-ivi-extension:"


SRC_URI_append = " \
                  file://0001-ivi-input-support-touch-and-pointer-on-subsurface.patch \
                 "

