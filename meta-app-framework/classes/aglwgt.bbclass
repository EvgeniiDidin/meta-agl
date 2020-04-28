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

# Set the default build type for cmake based projects
# NOTE: This can be removed after switching to using the autobuild
#       script to do compilation
EXTRA_OECMAKE_append = " -DCMAKE_BUILD_TYPE=RELEASE"

# FIXME: Remove once CMake+ninja issues are resolved
OECMAKE_GENERATOR = "Unix Makefiles"

AGLWGT_EXTRA_BUILD_ARGS = "VERBOSE=TRUE ${PARALLEL_MAKE}"

# Only widgets with recipe names starting with agl-service- are
# assumed to have tests by default, set this to "true" to force
# building/packaging of the test widget for other widgets.
AGLWGT_HAVE_TESTS = "false"

# Warning on missing test/debug/coverage packages disabled by default
# for now to reduce build output clutter.
AGLWGT_PACKAGE_WARN = "false"

# There are some widgets with build issues wrt test/debug/coverage
# that are currently non-fatal but do not yield a widget, allow empty
# test and coverage packages for now to allow the build to proceed.
# This matches the default behavior for -dbg packages.
#
# NOTE: This should revisited after a round of autobuild script rework
#       to address SPEC-3300.
ALLOW_EMPTY_${PN}-coverage = "1"
ALLOW_EMPTY_${PN}-test = "1"


do_aglwgt_package()  {
    bldcmd=${S}/autobuild/agl/autobuild
    if [ ! -x "$bldcmd" ]; then
        bbfatal "Missing autobuild/agl/autobuild script"
    fi

    cd ${B}
    if ! $bldcmd package BUILD_DIR=${B} DEST=${B}/build-release ${AGLWGT_EXTRA_BUILD_ARGS}; then
        bbwarn "Target: package failed"
    fi

    if echo ${BPN} | grep -q '^agl-service-' || [ "${AGLWGT_HAVE_TESTS}" = "true" ]; then
        mkdir -p ${S}/build-test
        cd ${S}/build-test
        if ! $bldcmd package-test BUILD_DIR=${S}/build-test DEST=${B}/build-test ${AGLWGT_EXTRA_BUILD_ARGS}; then
            bbwarn "Target: package-test failed"
        fi
    fi

    mkdir -p ${S}/build-debug
    cd ${S}/build-debug
    if ! $bldcmd package-debug BUILD_DIR=${S}/build-debug DEST=${B}/build-debug ${AGLWGT_EXTRA_BUILD_ARGS}; then
        bbwarn "Target: package-debug failed"
    fi

    mkdir -p ${S}/build-coverage
    cd ${S}/build-coverage
    if ! $bldcmd package-coverage BUILD_DIR=${S}/build-coverage DEST=${B}/build-coverage ${AGLWGT_EXTRA_BUILD_ARGS}; then
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
    DEST=release
    if [ "${AGLWGT_AUTOINSTALL_${PN}}" = "0" ]; then
        DEST=manualinstall
    fi

    if [ "$(find ${B}/build-release -name '*.wgt')" ]; then
        install -d ${D}/usr/AGL/apps/$DEST
        install -m 0644 ${B}/build-release/*.wgt ${D}/usr/AGL/apps/$DEST/
    else
        bberror "no package found in widget directory"
    fi

    for t in test debug coverage; do
        if [ "$(find ${B}/build-${t} -name *-${t}.wgt)" ]; then
            install -d ${D}/usr/AGL/apps/${t}
            install -m 0644 ${B}/build-${t}/*-${t}.wgt ${D}/usr/AGL/apps/${t}/
        elif [ "${AGLWGT_PACKAGE_WARN}" = "true" ]; then
            if [ "$t" != "test" ]; then
                bbwarn "no package found in ${t} widget directory"
            elif echo ${BPN} | grep -q '^agl-service-' || [ "${AGLWGT_HAVE_TESTS}" = "true" ]; then
                bbwarn "no package found in ${t} widget directory"
            fi
        fi
    done

    if [ "${AGLWGT_AUTOINSTALL_${PN}}" != "0" ]; then
        # For now assume autoinstall of the release versions
        rm -rf ${D}/usr/AGL/apps/autoinstall
        ln -sf release ${D}/usr/AGL/apps/autoinstall

        APP_FILES=""
        for file in ${D}/usr/AGL/apps/autoinstall/*.wgt; do
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
    fi
}

do_install() {
}

addtask aglwgt_deploy  before do_package after do_install
addtask aglwgt_package before do_aglwgt_deploy after do_compile

PACKAGES += "${PN}-test ${PN}-coverage"

FILES_${PN} += " \
    /usr/AGL/apps/release/*.wgt \
    /usr/AGL/apps/autoinstall \
    /usr/AGL/apps/manualinstall \
    ${sysconfdir}/agl-postinsts/${POST_INSTALL_SCRIPT} \
"
FILES_${PN}-test = "/usr/AGL/apps/test/*.wgt"
FILES_${PN}-dbg = "/usr/AGL/apps/debug/*.wgt"
FILES_${PN}-coverage = "/usr/AGL/apps/coverage/*.wgt"

# Test widgets need the base widget
RDEPENDS_${PN}-test = "${PN}"

# Signature keys
# These are default keys for development purposes !
# Change it for production.
WGTPKG_AUTOSIGN_0_agl-sign-wgts ??= "${WORKDIR}/recipe-sysroot-native/usr/share/afm/keys/developer.key.pem:${WORKDIR}/recipe-sysroot-native/usr/share/afm/certs/developer.cert.pem"
WGTPKG_AUTOSIGN_1_agl-sign-wgts ??= "${WORKDIR}/recipe-sysroot-native/usr/share/afm/keys/platform.key.pem:${WORKDIR}/recipe-sysroot-native/usr/share/afm/certs/platform.cert.pem"

export WGTPKG_AUTOSIGN_0
export WGTPKG_AUTOSIGN_1

