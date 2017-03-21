FILES_${PN}_append_rcar-gen3 = " \
    ${libexecdir}/weston-screenshooter \
    ${libexecdir}/weston-ivi-shell-user-interface \
    ${libexecdir}/weston-keyboard \
    ${libexecdir}/weston-simple-im \
    ${libexecdir}/weston-desktop-shell \
"

SRC_URI_remove = "file://fix-touchscreen-crash.patch"
