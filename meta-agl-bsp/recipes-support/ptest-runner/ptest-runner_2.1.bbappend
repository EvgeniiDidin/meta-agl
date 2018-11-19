FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI += "file://0004-README.md-Update-to-my-current-email.patch file://0001-utils.c-Prefer-monotonic-clock-to-calculate-elapsed-.patch file://0002-Makefile-libcheck-now-requires-to-link-subunit.patch file://0003-Add-support-to-avoid-load-run-twice-a-run_ptest-scri.patch file://0005-main.c-Use-realpath-to-get-the-actual-directory-of-p.patch file://0006-main.c-Add-option-e-to-exclude-certain-tests-for-exe.patch file://0007-WIP-Initial-LAVA-support.patch"

