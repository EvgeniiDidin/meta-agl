do_configure_append() {
	if ! grep -q StandardOutput= ${WORKDIR}/run-postinsts.service; then
		sed -i '/ExecStart=/iStandardOutput=journal+console' ${WORKDIR}/run-postinsts.service
	fi
}
