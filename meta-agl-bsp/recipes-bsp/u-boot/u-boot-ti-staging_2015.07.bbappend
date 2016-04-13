FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

# This applies to the JACINTO 6 vayu board ... essentially it is dra7_evm.
SRC_URI_vayu     += "file://fix_builderror_gcc5.patch"
