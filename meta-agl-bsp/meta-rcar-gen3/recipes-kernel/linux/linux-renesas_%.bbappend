FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

require recipes-kernel/linux/linux-agl.inc

SRC_URI_append  = " file://namespace_fix.cfg \
    "

# This can fix a compilation issue with perf. As this seems to collide with the cogent layer
# we apply this here by variable and reset it when the -adas layer is present.
perfFIX ??= " file://9999-perf-libbft-upstream.patch "
#

# Add ADSP patch to enable and add sound hardware abstraction
SRC_URI_append_ulcb = " \
    file://0004-ADSP-enable-and-add-sound-hardware-abstraction.patch \
    ${perfFIX} \
"

# For Xen
SRC_URI_append = " \
    ${@bb.utils.contains('AGL_XEN_WANTED','1','file://xen-be.cfg','',d)} \
"
SRC_URI_append_m3ulcb = " \
    ${@bb.utils.contains('AGL_XEN_WANTED','1','file://r8a7796-m3ulcb-xen.dts;subdir=git/arch/${ARCH}/boot/dts/renesas','',d)} \
"
KERNEL_DEVICETREE_append_m3ulcb = " \
    ${@bb.utils.contains('AGL_XEN_WANTED','1','renesas/r8a7796-m3ulcb-xen.dtb','',d)} \
"