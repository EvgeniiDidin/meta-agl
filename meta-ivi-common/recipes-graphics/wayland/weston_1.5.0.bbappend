FILESEXTRAPATHS_prepend := ":${THISDIR}/weston-ivi-shell:"

SRC_URI_append = " \
                  file://0001-IVI-Shell-Backport-from-Weston-1.9.0-to-1.5.0.patch \
                  file://0002-IVI-Shell-use-primary-screen-for-resolution.patch \
                  file://data/background.png \
                  file://data/fullscreen.png \
                  file://data/home.png \
                  file://data/icon_ivi_clickdot.png \
                  file://data/icon_ivi_flower.png \
                  file://data/icon_ivi_simple-egl.png \
                  file://data/icon_ivi_simple-shm.png \
                  file://data/icon_ivi_smoke.png \
                  file://data/panel.png \
                  file://data/random.png \
                  file://data/sidebyside.png \
                  file://data/tiling.png \
                 "

EXTRA_OECONF_append = " --enable-ivi-shell"

do_compile_prepend() {
      cp -f ${WORKDIR}/data/* ${S}/data
}
