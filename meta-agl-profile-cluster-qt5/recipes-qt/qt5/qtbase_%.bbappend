#Enable eglfs for QT based application

PACKAGECONFIG_GL_append = "${@bb.utils.contains('DISTRO_FEATURES', 'opengl', ' eglfs kms gbm', '', d)}"
