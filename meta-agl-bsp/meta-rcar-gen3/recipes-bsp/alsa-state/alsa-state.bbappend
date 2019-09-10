FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

COMPATIBLE_MACHINE = "(m3ulcb|h3ulcb|ebisu)"

PACKAGE_ARCH = "${MACHINE_ARCH}"

do_configure_append_ebisu () {
	sed -i 's/state.ak4613\ {/state.rcarsound\ {/g' ${WORKDIR}/asound.state
}
