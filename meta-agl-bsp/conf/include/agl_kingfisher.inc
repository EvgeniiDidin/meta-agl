SOC_FAMILY = "r8a7796"

# Enable AGL virtualization features
MACHINE_FEATURES_append = " agl-egvirt"

# for Wayland/Weston weston-laucher
DISTRO_FEATURES_append = " pam"

# Enable Gfx Pkgs
MACHINE_FEATURES_append = " gsx"
MULTI_PROVIDER_WHITELIST += "virtual/libgl virtual/egl virtual/libgles1 virtual/libgles2"

# for Wayland/Weston
PREFERRED_PROVIDER_virtual/libgles1 = ""
PREFERRED_PROVIDER_virtual/libgles2 = "virtual-gles-user-module"
PREFERRED_PROVIDER_virtual/egl = "virtual-gles-user-module"
PREFERRED_PROVIDER_virtual/libgl = ""
PREFERRED_PROVIDER_virtual/mesa = "mesa"
PREFERRED_PROVIDER_libgbm = "libgbm"
PREFERRED_RPROVIDER_libgbm-dev = "libgbm"

# Mask the gstreamer recipe for MMP
BBMASK = "meta-renesas/meta-rcar-gen3/recipes-multimedia/gstreamer"

# Add for gstreamer plugins ugly
LICENSE_FLAGS_WHITELIST = "commercial"

PREFERRED_VERSION_gstreamer1.0 = "1.6.3"
PREFERRED_VERSION_gstreamer1.0-libav = "1.6.3"
PREFERRED_VERSION_gstreamer1.0-plugins-base = "1.6.3"
PREFERRED_VERSION_gstreamer1.0-plugins-bad = "1.6.3"
PREFERRED_VERSION_gstreamer1.0-plugins-good = "1.6.3"
PREFERRED_VERSION_gstreamer1.0-plugins-ugly = "1.6.3"
PREFERRED_VERSION_gstreamer1.0-plugins-vspfilter = "1.0%"

MACHINE_FEATURES_append = " multimedia"

DISTRO_FEATURES_append = " use_eva_pkg"

#DISTRO_FEATURES_append = " h265dec_lib mpeg2dec_lib"
DISTRO_FEATURES_append = " h264dec_lib h264enc_lib aaclcdec_lib aaclcdec_mdw"

DISTRO_FEATURES_BACKFILL_remove = "gobject-introspection-data"

IMAGE_INSTALL_append_rcar-gen3 = " \
	kernel-devicetree \
	kernel-module-pvrsrvkm \
	kernel-module-vsp2 \
	kernel-module-vspm  \
	kernel-module-vspm-if \
	omx-user-module \
"

# Custom packages
IMAGE_INSTALL_append_rcar-gen3 = " \
    libsocketcan \
    iproute2 \
    spidev-dbg \
    e2fsprogs \
    e2fsprogs-tune2fs \
    ethtool \
    usbutils \
    util-linux \
    mtd-utils \
    capture \
    iperf \
    bonnie++ \
    lmbench \
    libpcap \
    eglibc-utils \
    procps \
    libsocketcan \
    iio-utils \
    pulseaudio-server \
    pulseaudio-misc \
    pulseaudio-module-cli \
    pulseaudio-module-remap-sink \
    pulseaudio-module-remap-source \
    gstreamer1.0-plugins-good-pulse \
    most-tools \
"

# Radio packages
IMAGE_INSTALL_append_rcar-gen3 += " \
    si-tools \
    linux-firmware-wl18xx \
    wireless-tools \
    ti-bt \
    ti-bt-firmware \
    bluez5 \
    bluez5-testtools \
    pulseaudio-module-bluez5-device \
    pulseaudio-module-bluez5-discover \
    pulseaudio-module-bluetooth-discover \
    pulseaudio-module-bluetooth-policy \
    ofono \
    ofono-tests \
"

BBMASK .= "|meta-renesas-rcar-gen3/meta-rcar-gen3/recipes-forward-port/"

OSTREE_KERNEL = "Image"
IMAGE_BOOT_FILES_sota = "m3ulcb-ota-bootfiles/* Image-r8a7796-m3ulcb.dtb"
OSTREE_BOOTLOADER ?= "u-boot"

WKS_FILE = "singlepart-noloader.wks"

AGL_EXTRA_IMAGE_FSTYPES = "wic.xz wic.bmap wic.xz.sha256sum"
