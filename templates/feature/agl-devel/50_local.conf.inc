EXTRA_IMAGE_FEATURES =+ "debug-tweaks eclipse-debug tools-debug tools-profile"

IMAGE_INSTALL_append = " \
	strace \
	ldd \
	gdb \
	valgrind \
	perf \
	powertop \
	latencytop \
	systemtap \
	screen \
	usbutils \
"

# disable install of debug files in SDK
# initial value: SDKIMAGE_FEATURES="dev-pkgs dbg-pkgs staticdev-pkgs"
SDKIMAGE_FEATURES="dev-pkgs"


