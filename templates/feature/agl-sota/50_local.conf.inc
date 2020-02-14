#see meta-updater/conf/distro/sota.conf.inc
INHERIT += "sota"
DISTRO_FEATURES_append = " sota usrmerge"
DISTRO_FEATURES_NATIVE_append = " sota"
AGL_DEFAULT_INITRAMFS_FSTYPES = "cpio.gz"
