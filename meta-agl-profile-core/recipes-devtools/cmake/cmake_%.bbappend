FILESEXTRAPATHS_append := ":${THISDIR}/files"

SRC_URI_append_class-nativesdk = " \
    file://0001-CMakeDetermineSystem-use-oe-environment-vars-to-load.patch \
    file://environment.d-cmake-agl.sh \
"

do_install_append_class-nativesdk() {
    install -m 644 ${WORKDIR}/environment.d-cmake-agl.sh ${D}${SDKPATHNATIVE}/environment-setup.d/cmake-agl.sh
}
