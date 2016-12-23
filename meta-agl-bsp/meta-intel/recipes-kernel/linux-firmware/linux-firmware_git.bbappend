LIC_FILES_CHKSUM_remove = "file://LICENSE.amdgpu;md5=a8592c24c2672062e03c7392fc7fe3bc"
LIC_FILES_CHKSUM_remove = "file://LICENSE.radeon;md5=6c7f97c6c62bdd9596d0238bb205118c"
LIC_FILES_CHKSUM_remove = "file://WHENCE;md5=2ec7cdcaf7b1f57b77665b4d77b76e50"
LIC_FILES_CHKSUM += "\
	file://LICENSE.amdgpu;md5=3fe8a3430700a518990c3b3d75297209 \
	file://LICENSE.radeon;md5=69612f4f7b141a97659cb1d609a1bde2 \
	file://WHENCE;md5=fc7f8a9fce11037078e90df415baad71 \
"

SRCREV = "cccb6a0da98372bd66787710249727ad6b0aaf72"

LICENSE_${PN}-ibt-license      	= "Firmware-ibt_firmware"
LICENSE_${PN}-ibt-11-5 		= "Firmware-ibt_firmware"
FILES_${PN}-ibt-license		= "/lib/firmware/LICENCE.ibt_firmware"
FILES_${PN}-ibt-11-5		= " \
	/lib/firmware/intel/ibt-11-5.sfi \
	/lib/firmware/intel/ibt-11-5.ddc \
"

RDEPENDS_${PN}-ibt-11-5		+= "${PN}-ibt-license"

PACKAGES =+ " ${PN}-ibt-license ${PN}-ibt-11-5 "
