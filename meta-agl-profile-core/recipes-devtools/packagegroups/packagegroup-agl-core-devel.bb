SUMMARY = "Provides a set of tools for development for AGL DISTRO"
LICENSE = "MIT"

inherit packagegroup

RDEPENDS_${PN} = "\
	afb-test \
        strace \
        ldd \
        less \
        vim \
        lsof \
        gdb \
        valgrind \
        perf \
        htop \
        powertop \
        systemtap \
        screen \
        usbutils \
        rsync \
        tree \
        pstree \
        procps \
        jq \
        libxslt-bin \
        agl-service-network-tools \
        gcc-sanitizers \
        "
