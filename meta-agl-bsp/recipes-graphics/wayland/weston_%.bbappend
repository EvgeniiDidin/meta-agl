RRECOMMENDS_${PN}_append = " libegl-gallium llvm3.3 "
RRECOMMENDS_${PN}_remove_intel-corei7-64 = "libegl-gallium llvm3.3"
RDEPENDS_${PN}_append_intel-corei7-64 = " mesa-megadriver "

EXTRA_OECONF_append_vexpressa9 = "\
    --enable-simple-egl-clients  \
    WESTON_NATIVE_BACKEND=fbdev-backend.so \
    "
EXTRA_OECONF_append_qemux86 = "\
    --enable-simple-egl-clients  \
    WESTON_NATIVE_BACKEND=fbdev-backend.so \
    "
EXTRA_OECONF_append_qemux86-64 = "\
    --enable-simple-egl-clients  \
    WESTON_NATIVE_BACKEND=fbdev-backend.so \
    "
