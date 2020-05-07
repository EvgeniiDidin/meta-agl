FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

require recipes-kernel/linux/linux-agl.inc

# Make sure these are enabled so that AGL configurations work
SRC_URI_append = " file://tmpfs.cfg"
KERNEL_CONFIG_FRAGMENTS_append = " ${WORKDIR}/tmpfs.cfg"
SRC_URI_append = " file://namespace.cfg"
KERNEL_CONFIG_FRAGMENTS_append = " ${WORKDIR}/namespace.cfg"
SRC_URI_append = " file://cgroup.cfg"
KERNEL_CONFIG_FRAGMENTS_append = " ${WORKDIR}/cgroup.cfg"

# Support for CFG80211 subsystem
SRC_URI_append = " file://cfg80211.cfg"
KERNEL_CONFIG_FRAGMENTS_append = " ${WORKDIR}/cfg80211.cfg"

# Support for i.MX8MQ EVKB (e.g. Broadcom wifi)
SRC_URI_append_imx8mqevk = " file://imx8mq-evkb.cfg"
KERNEL_CONFIG_FRAGMENTS_append_imx8mqevk = " ${WORKDIR}/imx8mq-evkb.cfg"

# Turn off a couple of things enabled by default by Freescale
# (lock debugging and userspace firmware loader fallback)
SRC_URI_append = " file://fixups.cfg"
KERNEL_CONFIG_FRAGMENTS_append = " ${WORKDIR}/fixups.cfg"
