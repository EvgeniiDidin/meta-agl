FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

def prep_version (d) :
	KV = d.getVar('KERNEL_VERSION', True)
	if not KV :
		return "4.12"
	else:
		return KV

ORIG_KERN_VER = "${@prep_version(d)}"

VANILLA_KERNEL_VERSION = "${@str(ORIG_KERN_VER.split("-")[0].split(".")[0]+ORIG_KERN_VER.split("-")[0].split(".")[1])}"

APPLY = "${@str('no' if ${VANILLA_KERNEL_VERSION} > 412 else 'yes')}"
APPLY_419 = "${@str('no' if ${VANILLA_KERNEL_VERSION} < 419 else 'yes')}"

SRC_URI_append = " \
	    file://0001-most-aim-network-backport-Kernel-API.patch;apply=${APPLY} \
	    file://0002-src-most-add-auto-conf-feature.patch \
	    file://0003-core-remove-kernel-log-for-MBO-status.patch \
	    file://0004-most-video-set-device_caps.patch \
	    file://0005-most-video-set-V4L2_CAP_DEVICE_CAPS-flag.patch \
	    file://0006-dim2-fix-startup-sequence.patch \
	    file://0007-dim2-use-device-tree.patch \
	    file://0008-dim2-read-clock-speed-from-the-device-tree.patch \
	    file://0009-dim2-use-device-for-coherent-memory-allocation.patch \
	    file://0010-backport-usb-setup-timer.patch \
	    file://0011-handle-snd_pcm_lib_mmap_vmalloc-removal.patch;apply=${APPLY_419} \
	   "
# Make sure we can expose KERNEL_VERSION ...
do_patch[depends] += "virtual/kernel:do_populate_sysroot"
