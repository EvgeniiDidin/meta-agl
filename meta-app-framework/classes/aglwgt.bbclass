#
# aglwgt bbclass
#
# Jan-Simon Moeller, jsmoeller@linuxfoundation.org
#
# This class expects a "make package" target in the makefile
# which creates the wgt files in the package/ subfolder.
# The makefile needs to use wgtpkg-pack.
#


# 'wgtpkg-pack' in af-main-native is required.
DEPENDS_append = " af-main-native"

# for bindings  af-binder is required.
DEPENDS_append = " af-binder"

# for bindings  that use the cmake-apps-module
DEPENDS_append = " cmake-apps-module-native"

# for hal bindings genskel is required.
DEPENDS_append = " af-binder-devtools-native"

EXTRA_OECMAKE_append_agl-ptest = " -DBUILD_TEST_WGT=TRUE"

# FIXME: Remove once CMake+ninja issues are resolved
OECMAKE_GENERATOR = "Unix Makefiles"

do_aglwgt_package()  {

    mkdir -p ${S}/build-test
    mkdir -p ${S}/build-debug
    mkdir -p ${S}/build-coverage

    bldcmd=${S}/autobuild/agl/autobuild
    if [ ! -x "$bldcmd" ]; then
        bldcmd=${S}/conf.d/autobuild/agl/autobuild
        if [ -x "$bldcmd" ]; then
            bbwarn "OBSOLETE: Your autobuild script should be located in :"
            bbwarn "autobuild/agl/ from the project root source folder"
            bbwarn "and generate a .wgt file using wgtpack in the build"
            bbwarn "root folder calling:"
            bbwarn "./autobuild/agl/autobuild package DEST=<BUILDDIR>"
            bbwarn "See: https://wiki.automotivelinux.org/troubleshooting/app-recipes"
        else
            bbwarn "OBSOLETE: You must have an autobuild script located in:"
            bbwarn "autobuild/agl/ from the project root source folder"
            bbwarn "with filename autobuild which should generate"
            bbwarn "a .wgt file using wgtpack in the build"
            bbwarn "root folder calling:"
            bbwarn "./autobuild/agl/autobuild package DEST=<BUILDDIR>"
            bbwarn "Fix your package as it will not work within the SDK"
            bbwarn "See: https://wiki.automotivelinux.org/troubleshooting/app-recipes"
            bldcmd=make
        fi
    fi

    cd ${B}
    if ! $bldcmd package BUILD_DIR=${B} DEST=${S}/widgets VERBOSE=TRUE; then
        bbwarn "Target: package failed"
    fi

    cd ${S}/build-test
    if ! $bldcmd package-test BUILD_DIR=${S}/build-test DEST=${S}/widgets VERBOSE=TRUE; then
        bbwarn "Target: package-test failed"
    fi

    cd ${S}/build-debug
    if ! $bldcmd package-debug BUILD_DIR=${S}/build-debug DEST=${S}/widgets VERBOSE=TRUE; then
        bbwarn "Target: package-debug failed"
    fi

    cd ${S}/build-coverage
    if ! $bldcmd package-coverage BUILD_DIR=${S}/build-coverage DEST=${S}/widgets VERBOSE=TRUE; then
        bbwarn "Target: package-coverage failed"
    fi
}

python () {
    d.setVarFlag('do_aglwgt_deploy', 'fakeroot', '1')
}


POST_INSTALL_LEVEL ?= "10"
POST_INSTALL_SCRIPT ?= "${POST_INSTALL_LEVEL}-${PN}.sh"

EXTRA_WGT_POSTINSTALL ?= ""

do_aglwgt_deploy() {
    TEST_WGT="*-test.wgt"
    DEBUG_WGT="*-debug.wgt"
    COVERAGE_WGT="*-coverage.wgt"
    if [ "${AGLWGT_AUTOINSTALL_${PN}}" = "0" ]
    then
        install -d ${D}/usr/AGL/apps/manualinstall
        install -m 0644 ${B}/*.wgt ${D}/usr/AGL/apps/manualinstall || \
        install -m 0644 ${B}/package/*.wgt ${D}/usr/AGL/apps/manualinstall
    else
        install -d ${D}/usr/AGL/apps/autoinstall
        install -m 0644 ${B}/*.wgt ${D}/usr/AGL/apps/autoinstall || \
        install -m 0644 ${B}/package/*.wgt ${D}/usr/AGL/apps/autoinstall

        install -m 0644 ${S}/widgets/*.wgt ${D}/usr/AGL/apps/autoinstall || \
            ( bbwarn "no package found in widget directory")

        if [ "$(find ${D}/usr/AGL/apps/autoinstall -name ${TEST_WGT})" ]
        then
                install -d ${D}/usr/AGL/apps/testwgt
            mv ${D}/usr/AGL/apps/autoinstall/*-test.wgt ${D}/usr/AGL/apps/testwgt
        fi

        if [ "$(find ${D}/usr/AGL/apps/autoinstall -name ${DEBUG_WGT})" ]
        then
                install -d ${D}/usr/AGL/apps/debugwgt
            mv ${D}/usr/AGL/apps/autoinstall/*-debug.wgt ${D}/usr/AGL/apps/debugwgt
        fi

        if [ "$(find ${D}/usr/AGL/apps/autoinstall -name ${COVERAGE_WGT})" ]
        then
                install -d ${D}/usr/AGL/apps/coveragewgt
            mv ${D}/usr/AGL/apps/autoinstall/*-coverage.wgt ${D}/usr/AGL/apps/coveragewgt
        fi

    fi

    APP_FILES=""
    for file in ${D}/usr/AGL/apps/autoinstall/*.wgt;do
        APP_FILES="${APP_FILES} $(basename $file)";
    done
    install -d ${D}/${sysconfdir}/agl-postinsts
    cat > ${D}/${sysconfdir}/agl-postinsts/${POST_INSTALL_SCRIPT} <<EOF
#!/bin/sh -e
for file in ${APP_FILES}; do
    /usr/bin/afm-install install /usr/AGL/apps/autoinstall/\$file
done
sync
${EXTRA_WGT_POSTINSTALL}
EOF
    chmod a+x ${D}/${sysconfdir}/agl-postinsts/${POST_INSTALL_SCRIPT}
}

FILES_${PN} += "/usr/AGL/apps/autoinstall/*.wgt \
    /usr/AGL/apps/manualinstall/*.wgt \
    /usr/AGL/apps/testwgt/*.wgt \
    /usr/AGL/apps/debugwgt/*.wgt \
    /usr/AGL/apps/coveragewgt/*.wgt \
    ${sysconfdir}/agl-postinsts/${POST_INSTALL_SCRIPT} \
    "

do_install() {
}

addtask aglwgt_deploy  before do_package after do_install
addtask aglwgt_package before do_aglwgt_deploy after do_compile

# Signature keys
# These are default keys for development purposes !
# Change it for production.
WGTPKG_AUTOSIGN_0_agl-sign-wgts ??= "${WORKDIR}/recipe-sysroot-native/usr/share/afm/keys/developer.key.pem:${WORKDIR}/recipe-sysroot-native/usr/share/afm/certs/developer.cert.pem"
WGTPKG_AUTOSIGN_1_agl-sign-wgts ??= "${WORKDIR}/recipe-sysroot-native/usr/share/afm/keys/platform.key.pem:${WORKDIR}/recipe-sysroot-native/usr/share/afm/certs/platform.cert.pem"

export WGTPKG_AUTOSIGN_0
export WGTPKG_AUTOSIGN_1

