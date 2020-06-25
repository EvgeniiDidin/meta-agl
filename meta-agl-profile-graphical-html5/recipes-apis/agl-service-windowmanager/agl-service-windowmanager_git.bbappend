FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SRC_URI += " \
  file://areas.horizontal.json \
"

do_compile_prepend() {
  cp ${WORKDIR}/areas.horizontal.json ${S}/conf/areas.json
}
