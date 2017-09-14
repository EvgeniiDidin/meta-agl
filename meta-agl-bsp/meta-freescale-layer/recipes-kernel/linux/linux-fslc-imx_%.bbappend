# Borrowed fragments logic from linaro kernel configuration

FILESEXTRAPATHS_prepend := "${THISDIR}/files:"
KERNEL_CONFIG_FRAGMENTS ?= ""

kernel_conf_variable() {
    CONF_SED_SCRIPT="$CONF_SED_SCRIPT /CONFIG_$1[ =]/d;"
    if test "$2" = "n"
    then
        echo "# CONFIG_$1 is not set" >> ${B}/.config
    else
        echo "CONFIG_$1=$2" >> ${B}/.config
    fi
}

do_configure_append() {

    CONF_SED_SCRIPT=""

    # kernel_conf_variable NAME y/n lines here

    if [ -f '${WORKDIR}/defconfig' ]; then
        sed -e "${CONF_SED_SCRIPT}" < '${WORKDIR}/defconfig' >> '${B}/.config'
    else
        sed -e "${CONF_SED_SCRIPT}" < '${KERNEL_DEFCONFIG}' >> '${B}/.config'
    fi

    # Check for kernel config fragments.  The assumption is that the config
    # fragment will be specified with the absolute path.  For example:
    #   * ${WORKDIR}/config1.cfg
    #   * ${S}/config2.cfg
    # Iterate through the list of configs and make sure that you can find
    # each one.  If not then error out.
    # NOTE: If you want to override a configuration that is kept in the kernel
    #       with one from the OE meta data then you should make sure that the
    #       OE meta data version (i.e. ${WORKDIR}/config1.cfg) is listed
    #       after the in kernel configuration fragment.
    # Check if any config fragments are specified.
    if [ ! -z "${KERNEL_CONFIG_FRAGMENTS}" ]
    then
        for f in ${KERNEL_CONFIG_FRAGMENTS}
        do
            # Check if the config fragment was copied into the WORKDIR from
            # the OE meta data
            if [ ! -e "$f" ]
            then
                echo "Could not find kernel config fragment $f"
                exit 1
            fi
        done

#        # Now that all the fragments are located merge them.
#        ( cd ${WORKDIR} && ${S}/scripts/kconfig/merge_config.sh -m -r -O ${B} ${B}/.config ${KERNEL_CONFIG_FRAGMENTS} 1>&2 )
#

        cat ${KERNEL_CONFIG_FRAGMENTS} >> ${B}/.config
    fi

    yes '' | oe_runmake -C ${S} O=${B} oldconfig
    oe_runmake -C ${S} O=${B} savedefconfig && cp ${B}/defconfig ${WORKDIR}/defconfig.saved
}

# Make sure these are enabled so that AGL configurations work

SRC_URI_append = " file://tmpfs.cfg"
KERNEL_CONFIG_FRAGMENTS_append = " ${WORKDIR}/tmpfs.cfg"
SRC_URI_append = " file://namespace.cfg"
KERNEL_CONFIG_FRAGMENTS_append = " ${WORKDIR}/namespace.cfg"
SRC_URI_append = " file://cgroup.cfg"
KERNEL_CONFIG_FRAGMENTS_append = " ${WORKDIR}/cgroup.cfg"

# Fragments common to AGL demo platform (make sure they are added)

# Enable support for USB HID touch display
SRC_URI_append = " file://touchscreen.cfg"
KERNEL_CONFIG_FRAGMENTS_append = " ${WORKDIR}/touchscreen.cfg"

# Enable support for TP-Link TL-W722N USB Wifi adapter
SRC_URI_append = " file://ath9k_htc.cfg"
KERNEL_CONFIG_FRAGMENTS_append = " ${WORKDIR}/ath9k_htc.cfg"

# Enable support for RTLSDR
SRC_URI_append = " file://rtl_sdr.cfg"
KERNEL_CONFIG_FRAGMENTS_append = " ${WORKDIR}/rtl_sdr.cfg"

# Enable support for Bluetooth HCI USB devices
SRC_URI_append = " file://btusb.cfg"
KERNEL_CONFIG_FRAGMENTS_append = " ${WORKDIR}/btusb.cfg"

#-------------------------------------------------------------------------
# smack patches for handling bluetooth

SRC_URI_append_smack = "\
       file://0004-Smack-Assign-smack_known_web-label-for-kernel-thread.patch \
"

# Enable support for smack
KERNEL_CONFIG_FRAGMENTS_append_smack = "\
       ${WORKDIR}/audit.cfg \
       ${WORKDIR}/smack.cfg \
       ${WORKDIR}/smack-default-lsm.cfg \
"

# Enable support for usb video class for usb camera devices
KERNEL_CONFIG_FRAGMENTS_append = " ${WORKDIR}/uvc.cfg"
