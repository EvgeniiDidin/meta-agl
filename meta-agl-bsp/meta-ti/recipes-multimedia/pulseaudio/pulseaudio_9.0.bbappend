FILESEXTRAPATHS_prepend := "${THISDIR}/pulseaudio-9.0:"

SRC_URI += " \
	file://dra7xx-evm-set-default-sink-source.patch \
"
