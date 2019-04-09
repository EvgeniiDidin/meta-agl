SUMMARY = "Combine dtb and dtbo"
DESCRIPTION = "Combine specified dtb and one or more dtbo into specified filename found in deploydir"
SECTION = "bootloader"
PR = "r1"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COREBASE}/meta/COPYING.MIT;md5=3da9cfbcb788c80a0384361b4de20420"

DEPENDS = "dtc-native"

ALLOW_EMPTY_${PN} = "1"
FILES_${PN} = ""

S = "${WORKDIR}"

do_compile[depends] += "virtual/kernel:do_deploy"

do_compile () {
	# Official touchscreen setup (rpi3b/rpi3b dtb, vc4-kms-v3d and ft5406)
	fdtoverlay -v -i ${DEPLOY_DIR_IMAGE}/bcm2710-rpi-3-b-plus.dtb -o bcm2710-rpi-3-b+vc4+ft5406.dtb ${DEPLOY_DIR_IMAGE}/rpi-ft5406.dtbo ${DEPLOY_DIR_IMAGE}/vc4-kms-v3d.dtbo
	fdtoverlay -v -i ${DEPLOY_DIR_IMAGE}/bcm2710-rpi-3-b.dtb -o bcm2710-rpi-3+vc4+ft5406.dtb ${DEPLOY_DIR_IMAGE}/rpi-ft5406.dtbo ${DEPLOY_DIR_IMAGE}/vc4-kms-v3d.dtbo

	# HDMI screen setup (rpi3b/rpi3b dtb and vc4-kms-v3d)
	fdtoverlay -v -i ${DEPLOY_DIR_IMAGE}/bcm2710-rpi-3-b-plus.dtb -o bcm2710-rpi-3-b+vc4.dtb ${DEPLOY_DIR_IMAGE}/vc4-kms-v3d.dtbo
	fdtoverlay -v -i ${DEPLOY_DIR_IMAGE}/bcm2710-rpi-3-b.dtb -o bcm2710-rpi-3+vc4.dtb ${DEPLOY_DIR_IMAGE}/vc4-kms-v3d.dtbo
}

do_deploy () {
	install -d ${DEPLOY_DIR_IMAGE}
	install -m 0644 ${S}/bcm2710-rpi-3-b+vc4+ft5406.dtb ${DEPLOY_DIR_IMAGE}
	install -m 0644 ${S}/bcm2710-rpi-3+vc4+ft5406.dtb ${DEPLOY_DIR_IMAGE}
	install -m 0644 ${S}/bcm2710-rpi-3-b+vc4.dtb ${DEPLOY_DIR_IMAGE}
	install -m 0644 ${S}/bcm2710-rpi-3+vc4.dtb ${DEPLOY_DIR_IMAGE}
}

addtask deploy after do_install
