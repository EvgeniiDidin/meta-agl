SUMMARY = "Utilities for testing of AGL"
DESCRIPTION = "A set of common packages required by testing AGL for Quality Assurance"

LICENSE = "MIT"

inherit packagegroup

PACKAGES = "\
    packagegroup-ivi-common-test \
    "

ALLOW_EMPTY_${PN} = "1"

RDEPENDS_${PN} += "\
    "
