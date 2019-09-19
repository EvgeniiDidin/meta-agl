MACHINE = "raspberrypi3"
#see meta-agl/meta-agl-bsp/conf/include/agl_raspberrypi3.inc
require conf/include/agl_raspberrypi3.inc

# Set appropriate version of Mesa for Raspberry Pi 3 and
# ignore the newer version with has been added for Raspberry Pi 4
PREFERRED_VERSION_mesa_raspberrypi3 = "18.1%"
