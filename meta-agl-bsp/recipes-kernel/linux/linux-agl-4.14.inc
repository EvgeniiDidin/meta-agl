FILESEXTRAPATHS_prepend := "${THISDIR}/linux-4.14:"

#-------------------------------------------------------------------------
# smack patches for kernels keys

SRC_URI_append_with-lsm-smack = "\
       file://Smack-Privilege-check-on-key-operations.patch \
       file://Smack-Handle-CGROUP2-in-the-same-way-that-CGROUP.patch \
       "

