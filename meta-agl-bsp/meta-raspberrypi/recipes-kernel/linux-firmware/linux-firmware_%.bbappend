FILESEXTRAPATHS_prepend_rpi := "${THISDIR}/files:"

SRC_URI_append_rpi = " \
    file://brcmfmac43455-sdio.bin \
    file://brcmfmac43455-sdio.clm_blob \
    file://brcmfmac43455-sdio.txt \
"

do_install_append_rpi() {
    install -d ${D}${nonarch_base_libdir}/firmware/brcm/

    # Replace outdated linux-firmware files with updated ones from
    # raspbian firmware-nonfree. Raspbian adds blobs and nvram
    # definitions that are also necessary so copy those too.
    for fw in brcmfmac43455-sdio ; do
        install -m 0644 ${WORKDIR}/${fw}.* ${D}${nonarch_base_libdir}/firmware/brcm/
    done
}

LICENSE_${PN}-bcm43455 = "Firmware-broadcom_bcm43xx"

FILES_${PN}-bcm43455 = " \
    ${nonarch_base_libdir}/firmware/brcm/brcmfmac43455-sdio.* \
"

RDEPENDS_${PN}-bcm43455 += "${PN}-broadcom-license"
