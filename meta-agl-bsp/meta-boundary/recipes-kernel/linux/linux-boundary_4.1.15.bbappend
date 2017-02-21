FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

DEPENDS += "kern-tools-native"

# Enable support for AR9271
SRC_URI_append = " file://ath9k_htc.cfg"

# Enable support for Bluetooth HCI USB devices
SRC_URI_append = " file://btusb.cfg"

# Enable support for Bluetooth HCI USB devices
SRC_URI_append = " file://btusb.cfg"

# Enable support for HID multitouch
SRC_URI_append = " file://hid.cfg"

# Enable support for RTLSDR
SRC_URI_append = " file://rtl_sdr.cfg"

# returns all the elements from the src uri that are .cfg files
def find_cfgs(d):
    sources=src_patches(d, True)
    sources_list=[]
    for s in sources:
        if s.endswith('.cfg'):
            sources_list.append(s)

    return sources_list

do_configure_prepend () {
    cp -a ${WORKDIR}/defconfig .config
    merge_config.sh -m .config ${@" ".join(find_cfgs(d))}
}