FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SYSTEMD_SMACK_PATCHES_216 = " \
file://0003-tizen-smack-Handling-of-run-and-sys-fs-cgroup-v216.patch \
file://0004-tizen-smack-Handling-of-dev-v216.patch \
file://0005-tizen-smack-Handling-network-v216.patch \
file://0007-tizen-smack-Runs-systemd-journald-with-v216.patch \
"

SYSTEMD_SMACK_PATCHES_219 = " \
file://0003-tizen-smack-Handling-of-run-and-sys-fs-cgroup.patch \
file://0004-tizen-smack-Handling-of-dev.patch \
file://0005-tizen-smack-Handling-network.patch \
file://0007-tizen-smack-Runs-systemd-journald-with.patch \
"
SYSTEMD_SMACK_PATCHES_225 = " \
file://0003-tizen-smack-Handling-of-run-and-sys-fs-cgroup.patch \
file://0004-tizen-smack-Handling-of-dev.patch \
file://0005-tizen-smack-Handling-network-v225.patch \
file://0007-tizen-smack-Runs-systemd-journald-with.patch \
"

SYSTEMD_SMACK_PATCHES_228 = " \
file://0005-tizen-smack-Handling-network-v228.patch \
file://mount-setup.c-fix-handling-of-symlink-Smack-labellin-v228.patch \
"

SYSTEMD_SMACK_PATCHES_234 = " \
file://0001-Switch-Smack-label-earlier.patch \
"

# Most patches from sandbox/jobol/v219. Cannot be applied unconditionally
# because systemd panics when booted without Smack support:
# systemd[1]: Cannot determine cgroup we are running in: No such file or directory
# systemd[1]: Failed to allocate manager object: No such file or directory
# [!!!!!!] Failed to allocate manager object, freezing.
#
# There's a slight dependency on the base systemd in 0005-tizen-smack-Handling-network.
# We use the beginning of PV (unexpanded here to prevent a cyclic dependency
# during resolution apparently caused by ${SRCPV}) to pick the right set of
# patches.
#
# Patches are optional. Hopefully we won't need any for systemd >= 229.
SRC_URI_append_with-lsm-smack = " ${SYSTEMD_SMACK_PATCHES_234}"

# A workaround for a missing space in a SRC_URI_append in a private layer elsewhere:
SRC_URI += ""

# Ensures systemd runs with label "System"
EXTRA_OECONF_append_with-lsm-smack = " --with-smack-run-label=System"

# Maintaining trivial, non-upstreamable configuration changes as patches
# is tedious. But in same cases (like early mounting of special directories)
# the configuration has to be in code. We make these changes here directly.
do_patch[prefuncs] += "patch_systemd"
do_patch[vardeps] += "patch_systemd"
patch_systemd() {
    # Handling of /run and /sys/fs/cgroup. Make /run a transmuting directory to
    # enable systemd communications with services in the User domain.
    # Original patch by Michael Demeter <michael.demeter@intel.com>.
    #
    # We simplify the patching by touching only lines which check the result of
    # mac_smack_use(). Those are the ones which are used when Smack is active.
    #
    # smackfsroot=* on /sys/fs/cgroup may be upstreamable, but smackfstransmute=System::Run
    # is too distro specific (depends on Smack rules) and thus has to remain here.
    sed -i -e 's;\("/sys/fs/cgroup", *"[^"]*", *"[^"]*\)\(.*mac_smack_use.*\);\1,smackfsroot=*\2;' \
           -e 's;\("/run", *"[^"]*", *"[^"]*\)\(.*mac_smack_use.*\);\1,smackfstransmute=System::Run\2;' \
           ${S}/src/core/mount-setup.c
}

##################################################################################
# What follows is temporary.
# This is a solution to the Bug-AGL SPEC-539
# (see https://jira.automotivelinux.org/browse/SPEC-539).
#
# It renames the file "touchscreen.rules" to "55-touchscreen.rules"
# This comes with the recipe systemd_230/234 of poky (meta/recipes-core/systemd)
# It should be removed when poky changes.
##################################################################################
do_install_prepend() {
	mv ${WORKDIR}/touchscreen.rules ${WORKDIR}/55-touchscreen.rules || true
}

