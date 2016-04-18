FILESEXTRAPATHS_prepend := ":${THISDIR}/pulseaudio"

SRC_URI += " \
             file://0008-install-files-for-a-module-development.patch \
             file://0010-volume-ramp-additions-to-the-low-level-infra.patch \
             file://0011-volume-ramp-adding-volume-ramping-to-sink-input.patch \
             file://0012-volume-ramp-add-volume-ramping-to-sink.patch \
             file://0013-add-internal-corking-state-for-sink-input.patch \
             file://0020-core-util-Add-pa_join.patch \
             file://0021-dynarray-Add-pa_dynarray_get_raw_array.patch \
             file://0022-device-port-Add-pa_device_port.active.patch \
             file://0030-volume-api-Add-libvolume-api.patch \
             file://0031-Add-module-main-volume-policy.patch \
             file://0039-main-volume-policy-adapt-to-pa6rev.patch \
           "

PACKAGES =+ " pulseaudio-module-dev"

FILES_pulseaudio-module-dev = "${includedir}/pulsemodule/* ${libdir}/pkgconfig/pulseaudio-module-devel.pc"
