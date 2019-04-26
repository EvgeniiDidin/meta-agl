FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

require recipes-kernel/linux/linux-agl.inc

# Make sure these are enabled so that AGL configurations work
SRC_URI_append = " file://tmpfs.cfg"
KERNEL_CONFIG_FRAGMENTS_append = " ${WORKDIR}/tmpfs.cfg"
SRC_URI_append = " file://namespace.cfg"
KERNEL_CONFIG_FRAGMENTS_append = " ${WORKDIR}/namespace.cfg"
SRC_URI_append = " file://cgroup.cfg"
KERNEL_CONFIG_FRAGMENTS_append = " ${WORKDIR}/cgroup.cfg"

#-------------------------------------------------------------------------
# smack patches for handling bluetooth

SRC_URI_append_with-lsm-smack = "\
       file://0004-Smack-Assign-smack_known_web-label-for-kernel-thread.patch \
"

# Support for CFG80211 subsystem
SRC_URI_append = " file://cfg80211.cfg"
KERNEL_CONFIG_FRAGMENTS_append = " ${WORKDIR}/cfg80211.cfg"

