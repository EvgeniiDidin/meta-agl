# This must be parsed after qt5, etc. layers so that they are correctly
# recognized by meta-freescale/dynamic-layers
BBLAYERS =+ "\
  ${METADIR}/meta-freescale \
  ${METADIR}/meta-freescale-3rdparty \
  ${METADIR}/meta-freescale-distro \
  "
