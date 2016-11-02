FILESEXTRAPATHS_append := ":${THISDIR}/${PN}"

SRC_URI_append_porter_sota = "file://0001-Autoload-uEnv.txt-on-boot.patch"
