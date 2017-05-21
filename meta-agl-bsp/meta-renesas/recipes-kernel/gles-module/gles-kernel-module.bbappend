FILESEXTRAPATHS_prepend := '${THISDIR}/${PN}:'
SRC_URI_r8a7791_append_agl-porter-hibernate = ' file://hibernation/0001-Add-gles-hibernation-code-for-M2W-only.patch \
                                              '
python __anonymous () {
	d.delVarFlag('do_patch', 'noexec')
}

