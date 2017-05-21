FILESEXTRAPATHS_append := ":${THISDIR}/${PN}"

SRC_URI_append_porter_sota = "file://0001-Autoload-uEnv.txt-on-boot.patch"

SRC_URI_append_agl-porter-hibernate = " file://hibernation/0001-Add-rcar-sdhi-DMA-support.patch \
                                        file://hibernation/0002-Add-Hibernation-swsusp-command-support.patch \
                                        file://hibernation/0003-Add-Hibernation-swsuspmem-command-support.patch \
                                        file://hibernation/0004-Add-porter-board-Hibernation-code.patch \
                                      "

