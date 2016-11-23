MACHINE = "m3ulcb"
SOC_FAMILY = "r8a7796"

# for Wayland/Weston weston-laucher
DISTRO_FEATURES_append = " pam"

# Enable Gfx Pkgs
MACHINE_FEATURES_append = " gsx"
MULTI_PROVIDER_WHITELIST += "virtual/libgl virtual/egl virtual/libgles1 virtual/libgles2"

# for Wayland/Weston
PREFERRED_PROVIDER_virtual/libgles1 = ""
PREFERRED_PROVIDER_virtual/libgles2 = "gles-user-module"
PREFERRED_PROVIDER_virtual/egl = "gles-user-module"
PREFERRED_PROVIDER_virtual/libgl = ""
PREFERRED_PROVIDER_virtual/mesa = ""
PREFERRED_PROVIDER_libgbm = "libgbm"
PREFERRED_PROVIDER_libgbm-dev = "libgbm"

# Mask the gstreamer recipe for MMP
BBMASK = "meta-renesas/meta-rcar-gen3/recipes-multimedia/gstreamer"

# Add for gstreamer plugins ugly
LICENSE_FLAGS_WHITELIST = "commercial"

PREFERRED_VERSION_gstreamer1.0-libav = "1.4.5"
PREFERRED_VERSION_gstreamer1.0-plugins-base = "1.4.5"
PREFERRED_VERSION_gstreamer1.0-plugins-bad = "1.4.5"
PREFERRED_VERSION_gstreamer1.0-plugins-good = "1.4.5"
PREFERRED_VERSION_gstreamer1.0-plugins-ugly = "1.4.5"
PREFERRED_VERSION_gstreamer1.0-plugins-vspfilter = "1.0%"

MACHINE_FEATURES_append = " multimedia"

DISTRO_FEATURES_append = " use_eva_pkg"

#DISTRO_FEATURES_append = " h265dec_lib mpeg2dec_lib"
DISTRO_FEATURES_append = " h264dec_lib aaclcdec_lib aaclcdec_mdw"

DISTRO_FEATURES_BACKFILL_remove = "gobject-introspection-data"

IMAGE_INSTALL_append_rcar-gen3 = " \
	kernel-module-pvrsrvkm \
	kernel-module-vsp2 \
	kernel-module-vspm-if \
	omx-user-module \
	weston-bin \
"
