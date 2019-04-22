do_configure_append_bbe() {
    echo 'gbm-format=rgb565' >> ${WORKDIR}/core.cfg
    if [[ -e "${WORKDIR}/hdmi-a-1-270.cfg" ]]; then
        echo 'mode=1280x720' >> ${WORKDIR}/hdmi-a-1-270.cfg
    fi
}
