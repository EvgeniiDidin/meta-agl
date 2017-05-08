# DEFAULTTUNE overrides for AGL on x86-64

# We should not need the tuning include below as the BSP should include the right set already.
# A double inclusion would produce a warning. This include line is just for reference
#include conf/machine/include/tune-corei7.inc
DEFAULTTUNE = "corei7-64"

# shortened copy of tune-corei7.inc due to bug in inclusion for tune-core2.inc
# TUNE_ARCH is using .= x86-64 , if done twice, you get x86-64x86-64 as TUNE_ARCH :/
# we should have at least the core2 tunings by default (=qemux86-64)

# Extra tune features
TUNEVALID[corei7] = "Enable corei7 specific processor optimizations"
TUNE_CCARGS = "${@bb.utils.contains('TUNE_FEATURES', 'corei7', ' -march=corei7 -mtune=corei7 -mfpmath=sse -msse4.2', '', d)}"

# Extra tune selections
AVAILTUNES += "corei7-32"
TUNE_FEATURES_tune-corei7-32 = "${TUNE_FEATURES_tune-x86} corei7"
BASE_LIB_tune-corei7-32 = "lib"
TUNE_PKGARCH_tune-corei7-32 = "corei7-32"
PACKAGE_EXTRA_ARCHS_tune-corei7-32 = "${PACKAGE_EXTRA_ARCHS_tune-core2-32} corei7-32"
QEMU_EXTRAOPTIONS_corei7-32 = " -cpu Nehalem,check=false"
QB_CPU_corei7-32 = "-cpu Nehalem,check=false"
QB_MACHINE_corei7-32 = "-machine q35"

AVAILTUNES += "corei7-64"
TUNE_FEATURES_tune-corei7-64 = "${TUNE_FEATURES_tune-x86-64} corei7"
BASE_LIB_tune-corei7-64 = "lib64"
TUNE_PKGARCH_tune-corei7-64 = "corei7-64"
PACKAGE_EXTRA_ARCHS_tune-corei7-64 = "${PACKAGE_EXTRA_ARCHS_tune-core2-64} corei7-64"
QEMU_EXTRAOPTIONS_corei7-64 = " -cpu Nehalem,check=false"
QB_CPU_corei7-64 = " -cpu Nehalem,check=false"
QB_MACHINE_corei7-64 = "-machine q35"

AVAILTUNES += "corei7-64-x32"
TUNE_FEATURES_tune-corei7-64-x32 = "${TUNE_FEATURES_tune-x86-64-x32} corei7"
BASE_LIB_tune-corei7-64-x32 = "libx32"
TUNE_PKGARCH_tune-corei7-64-x32 = "corei7-64-x32"
PACKAGE_EXTRA_ARCHS_tune-corei7-64-x32 = "${PACKAGE_EXTRA_ARCHS_tune-core2-64-x32} corei7-64-x32"
QEMU_EXTRAOPTIONS_corei7-64-x32 = " -cpu Nehalem,check=false"
QB_CPU_corei7-64-x32 = "-cpu Nehalem,check=false"
QB_MACHINE_corei7-64-x32 = "-machine q35"

TUNE_ARCH = "${@bb.utils.contains('TUNE_FEATURES', 'm64', '${X86ARCH64}', '' ,d)}"

# Bump qemux86-64 up to corei7
AVAILTUNES += "qemux86-64"
TUNE_FEATURES_tune-qemux86-64 = "${TUNE_FEATURES_tune-x86-64} corei7"
BASE_LIB_tune-qemux86-64 = "lib64"
TUNE_PKGARCH_tune-qemux86-64 = "corei7-64"
PACKAGE_EXTRA_ARCHS_tune-qemux86-64 = "${PACKAGE_EXTRA_ARCHS_tune-core2-64} corei7-64"
QEMU_EXTRAOPTIONS_qemux86-64 = " -cpu Nehalem,check=false"
QB_CPU_qemux86-64 = " -cpu Nehalem,check=false"
QB_CPU_KVM_x86 = "-cpu Nehalem,check=false"
QB_CPU_KVM_x86-64 = "-cpu Nehalem,check=false"
QB_MACHINE_qemux86-64 = "-machine q35"
