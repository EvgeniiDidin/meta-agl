# provide "libegl-gallium" if it does not exist (poky > 1.7)
RPROVIDES_${PN}_append = "libegl-gallium"

PACKAGECONFIG_append = " gallium gallium-egl gallium-llvm"

DRIDRIVERS_append_intel-corei7-64 = ",i965"
