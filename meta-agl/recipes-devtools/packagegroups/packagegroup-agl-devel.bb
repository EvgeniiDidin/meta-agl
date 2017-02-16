SUMMARY = "Provides a set of tools for development for AGL DISTRO"

PR = "r1"

inherit packagegroup

RDEPENDS_${PN} = "\
        strace \
        ldd \
        less \
        lsof \
        gdb \
        valgrind \
        perf \
        htop \
        powertop \
        latencytop \
        systemtap \
        screen \
        usbutils \
        rsync \
        "
