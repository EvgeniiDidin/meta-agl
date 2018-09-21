SUMMARY = "Distribution build manifest"
DESCRIPTION = "The /etc/platform-build-info file contains build manifest (SPEC-720)."
LICENSE = "MIT"

# information distributed by the package is machine specific
PACKAGE_ARCH = "${MACHINE_ARCH}"

# dependencies of ${DISTRO_MANIFEST_GENERATOR}
DEPENDS = "coreutils-native bash-native git-native gawk-native sed-native"

# force a rebuild everytime a build is started
do_compile[nostamp] = "1"

do_compilestep1 () {
    rc=99
    outfile=${B}/platform-build-info
    if [ -f "${DISTRO_MANIFEST_GENERATOR}" -a -f "${DISTRO_SETUP_MANIFEST}" ]; then
        ${DISTRO_MANIFEST_GENERATOR} ${DISTRO_SETUP_MANIFEST} deploy >${outfile}-deploy
        rc1=$?
        ${DISTRO_MANIFEST_GENERATOR} ${DISTRO_SETUP_MANIFEST} target >${outfile}-target
        rc2=$?
        ${DISTRO_MANIFEST_GENERATOR} ${DISTRO_SETUP_MANIFEST} sdk >${outfile}-sdk
        rc=$?

        if [ "$rc1" -ne 0 -o "$rc2" -ne 0 -o "$rc3" -ne 0 ]; then
            rc=98
        fi
    fi

    if [ "$rc" -ne  0 ]; then
        echo "distro-build-manifest generation failed."
    fi
    return $rc
}

# borrowed to os-release.bb (output format is very close)
python do_compilestep2 () {
   import shutil
   with open(d.expand('${B}/platform-build-info-deploy'),'a') as f:
      for field in d.getVar('BUILD_MANIFEST_FIELDS_DEPLOY').split():
         value=d.getVar(field)
         if value:
            f.write('DIST_BB_{0}="{1}"\n'.format(field,value))

   with open(d.expand('${B}/platform-build-info-target'),'a') as f:
      for field in d.getVar('BUILD_MANIFEST_FIELDS_TARGET').split():
         value=d.getVar(field)
         if value:
            f.write('DIST_BB_{0}="{1}"\n'.format(field,value))

   with open(d.expand('${B}/platform-build-info-sdk'),'a') as f:
      for field in d.getVar('BUILD_MANIFEST_FIELDS_SDK').split():
         value=d.getVar(field)
         if value:
            f.write('DIST_BB_{0}="{1}"\n'.format(field,value))
}
do_compilestep2[vardeps] += " ${BUILD_MANIFEST_FIELDS_DEPLOY}"
do_compilestep2[vardeps] += " ${BUILD_MANIFEST_FIELDS_TARGET}"
do_compilestep2[vardeps] += " ${BUILD_MANIFEST_FIELDS_SDK}"

# combine the two steps
python do_compile() {
   bb.build.exec_func("do_compilestep1",d)
   bb.build.exec_func("do_compilestep2",d)
}

do_install () {
    # install in target dir
    install -d ${D}${sysconfdir}
    install -m 0644 platform-build-info-target ${D}${sysconfdir}/platform-build-info

    # also copy in deploy dir
    install -d ${DEPLOY_DIR_IMAGE}
    install -m 0644 platform-build-info-deploy ${DEPLOY_DIR_IMAGE}/platform-build-info

    # and copy to nativesdk package
    # TODO
}

# list of variables to add to the various manifests
# smalles one is 'target', then 'deploy' and finally 'sdk'
BUILD_MANIFEST_FIELDS_TARGET = "\
    MACHINE_ARCH \
    MACHINEOVERRIDES \
    MACHINE_FEATURES \
    DISTRO_CODENAME \
    DISTRO_FEATURES \
    DISTRO_BRANCH_VERSION_TAG \
    AGLVERSION \
    AGL_BRANCH \
    AGLRELEASETYPE \
"

BUILD_MANIFEST_FIELDS_DEPLOY = "\
    ${BUILD_MANIFEST_FIELDS_TARGET} \
    DISTRO \
    DISTRO_VERSION \
    DISTROOVERRIDES \
    TUNE_FEATURES \
    TUNE_PKGARCH \
    ALL_MULTILIB_PACKAGE_ARCHS \
"

BUILD_MANIFEST_FIELDS_SDK = "\
    ${BUILD_MANIFEST_FIELDS_DEPLOY} \
    HOST_SYS \
    TARGET_SYS \
    TARGET_VENDOR \
    SDK_ARCH \
    SDK_VENDOR \
    SDK_VERSION \
    SDK_OS \
"

# dont exec useless tasks
do_fetch[noexec] = "1"
do_unpack[noexec] = "1"
do_patch[noexec] = "1"
do_configure[noexec] = "1"

