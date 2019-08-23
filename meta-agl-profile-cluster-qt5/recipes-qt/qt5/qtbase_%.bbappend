#Enable eglfs for QT based application

FILESEXTRAPATHS_prepend := "${THISDIR}/files:"


SRC_URI += " file://0001-fixed-eglfs_kms-fails-to-build.patch \
             file://0002-fixed-invalid-conversion-from-EGLNativeDisplayType-to-void.patch \
           "

PACKAGECONFIG_GL_append = "${@bb.utils.contains('DISTRO_FEATURES', 'opengl', ' eglfs kms gbm', '', d)}"
