LICENSE_${PN}-ibt-license      	= "Firmware-ibt_firmware"
LICENSE_${PN}-ibt-11-5 		= "Firmware-ibt_firmware"
FILES_${PN}-ibt-license		= "/lib/firmware/LICENCE.ibt_firmware"
FILES_${PN}-ibt-11-5		= " \
	/lib/firmware/intel/ibt-11-5.sfi \
	/lib/firmware/intel/ibt-11-5.ddc \
"

RDEPENDS_${PN}-ibt-11-5		+= "${PN}-ibt-license"

PACKAGES =+ " ${PN}-ibt-license ${PN}-ibt-11-5 "
