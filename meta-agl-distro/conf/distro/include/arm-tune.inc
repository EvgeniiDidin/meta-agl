# We should not need any includes as the board should include the right set already. This is just for reference.
# high profile boards need to
#   include conf/machine/include/arm/arch-armv7ve.inc
# medium profile boards need to
#   include conf/machine/include/arch/arm-armv7-a.inc
DEFAULTTUNE = "${@bb.utils.contains('DISTRO_FEATURES', 'agl-medium-arm-compiler', 'armv7athf-neon', 'armv7vethf-neon-vfpv4', d)}"
QB_SYSTEM_NAME ?= "qemu-system-arm"
QB_DEFAULT_KERNEL ?= "zImage"
QB_DEFAULT_FSTYPE ?= "ext4"
QB_MACHINE ?= "${@bb.utils.contains('DISTRO_FEATURES', 'agl-medium-arm-compiler', '-machine vexpress-a9', '-machine vexpress-a15', d)}"
QB_CPU ?= "${@bb.utils.contains('DISTRO_FEATURES', 'agl-medium-arm-compiler', '-cpu cortex-a9', '-cpu cortex-a15', d)}"
