FILESEXTRAPATHS_prepend := ":${THISDIR}/weston-ivi-shell:"


SRC_URI_append = " \
                  file://0001-IVI-Shell-use-primary-screen-for-resolution.patch \
                 "

EXTRA_OECONF_append = " --enable-ivi-shell"
