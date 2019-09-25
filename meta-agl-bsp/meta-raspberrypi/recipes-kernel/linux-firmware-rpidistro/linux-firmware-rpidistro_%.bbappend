FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI += "file://0001-brcmfmac43455-sdio.txt-Follow-raspbian-change-for-bo.patch"

do_unpack_append() {
    bb.build.exec_func('do_clean_pc', d)
}
do_clean_pc() {
    rm -rf ${S}/.pc
}
