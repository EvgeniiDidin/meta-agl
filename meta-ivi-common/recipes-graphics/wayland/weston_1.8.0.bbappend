FILESEXTRAPATHS_prepend := ":${THISDIR}/weston-ivi-shell:"


SRC_URI_append = " \
                  file://0001-IVI-Shell-Backport-from-Weston-1.9.0-to-1.8.0.patch \
                  file://0002-IVI-Shell-use-primary-screen-for-resolution.patch \
                 "

EXTRA_OECONF_append = " --enable-ivi-shell"
