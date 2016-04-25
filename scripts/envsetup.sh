#!/bin/bash

find_and_ack_eula() {
    # Handle EULA , if needed. This is a generic method to handle BSPs
    # that might (or not) come with a EULA. If a machine has a EULA, we
    # assume that its corresponding layers has conf/EULA/$MACHINE file
    # with the EULA text, which we will display to the user and request
    # for acceptance. If accepted, the variable ACCEPT_EULA_$MACHINE is
    # set to 1 in local.conf, which can later be used by the BSP.
    # If the env variable EULA_$MACHINE is set it is used by default,
    # without prompting the user.
    # FIXME: there is a potential issue if the same $MACHINE is set in more than one layer.. but we should assert that earlier
    EULA=$(find $1 -print | grep "conf/eula/$MACHINE" | grep -v scripts | grep -v openembedded-core || true)
    if [ -n "$EULA" ]; then
        # remove '-' since we are constructing a bash variable name here
        EULA_MACHINE="EULA_$(echo $MACHINE | sed 's/-//g')"
        # NOTE: indirect reference / dynamic variable
        if [ -n "${!EULA_MACHINE}" ]; then
            # the EULA_$MACHINE variable is set in the environment, so we just configure
            # ACCEPT_EULA_$MACHINE in local.conf
            EULA_ACCEPT=${!EULA_MACHINE}
        else
            # so we need to ask user if he/she accepts the EULA:
            cat <<EOF
The BSP for $MACHINE depends on packages and firmware which are covered by an 
End User License Agreement (EULA). To have the right to use these binaries
in your images, you need to read and accept the following...

The firmware package can contains several types
of firmware (depending on BSP):

* bootloaders: the first stage bootloaders are proprietary for this
  board, they are included in this firmware package.
* firmware for the power management 'companion' core: on QCOM SoC some
  power management features are implemented in a companion core , called
  RPM, and not on the main CPU.
* firmware for GPU, WLAN, DSP/GPS and video codecs. These firmware are
  used by their respective linux drivers (DRM, wlan, v4l2, .. ) and are
  loaded on-demand by the main CPU onto the various cores on the SoC.
EOF

            echo
            REPLY=
            while [ -z "$REPLY" ]; do
                echo -n "Do you read the EULA ? (y/n) "
                read REPLY
                case "$REPLY" in
                    y|Y)
                        READ_EULA=1
                        ;;
                    n|N)
                        READ_EULA=0
                        ;;
                    *)
                        REPLY=
                        ;;
                esac
            done

            if [ "$READ_EULA" == 1 ]; then
                more -d ${EULA}
                echo
                REPLY=
                while [ -z "$REPLY" ]; do
                    echo -n "Do you accept the EULA you just read? (y/n) "
                    read REPLY
                    case "$REPLY" in
                        y|Y)
                            echo "EULA has been accepted."
                            EULA_ACCEPT=1
                            ;;
                        n|N)
                            echo "EULA has not been accepted."
                            ;;
                        *)
                            REPLY=
                            ;;
                    esac
                done
            fi
        fi
    fi
}

if [ -z $1 ]; then
        echo -e "Usage: source envsetup.sh <board/device> [build dir]"
        return 1
fi

MACHINE="$1"
echo "MACHINE=$MACHINE"

EULA_ACCEPT=0

case "$MACHINE" in
        "porter")
                # setup proprietary gfx drivers and multimedia packages
                COPY_MM_SCRIPT=meta-renesas/meta-rcar-gen2/scripts/setup_mm_packages.sh
                if [ -f $COPY_MM_SCRIPT ]; then
                        . $COPY_MM_SCRIPT
                        copy_mm_packages $1
                        if [ $? -ne 0 ]; then
                                echo "Copying gfx drivers and multimedia packages for '$1' failed."
                                return 1
                        fi
                fi

                if [ ! -d "$TEMPLATECONF" ]; then
                    # set template conf for R-Car2 M2 Porter board
                    TEMPLATECONF="$PWD/meta-renesas/meta-rcar-gen2/conf"
                fi
                ;;
        "porter-nogfx")
                MACHINE="porter"
                if [ ! -d "$TEMPLATECONF" ]; then
                    # set template conf for R-Car2 M2 Porter board
                    TEMPLATECONF="$PWD/meta-renesas/meta-rcar-gen2/conf"
                fi
                ;;
        "raspberrypi3")
                ;;
        "raspberrypi2")
                ;;
        "intel-corei7-64")
                ;;
        "minnowboard")
                # alias for minnowboardmax
                MACHINE="intel-corei7-64"
                ;;
        "qemux86")
                ;;
        "qemux86-64")
                ;;
        "dra7xx-evm")
                ;;
        "vayu")
                # nickname for dra7xx-evm
                MACHINE="dra7xx-evm"
                ;;
        "wandboard")
                ;;
        "dragonboard-410c")
                find_and_ack_eula meta-qcom
                ;;
        *)
                # nothing to do here
                echo "WARN: '$MACHINE' is not tested by AGL Distro"
                ;;
esac

echo "TEMPALTECONF=$TEMPLATECONF"
# set template conf for each <board/device>
if [ -z "$TEMPLATECONF" ]; then
    # lookup meta-agl-demo first
    if [ -d "$PWD/meta-agl-demo/templates/$MACHINE/conf" ]; then
        TEMPLATECONF="$PWD/meta-agl-demo/templates/$MACHINE/conf"
    # lookup meta-agl 2nd
    elif [ -d "$PWD/meta-agl/templates/$MACHINE/conf" ]; then
        TEMPLATECONF="$PWD/meta-agl/templates/$MACHINE/conf"
    fi
fi
echo "TEMPLATECONF=$TEMPLATECONF"

echo "envsetup: Set '$1' as MACHINE."
export MACHINE

# fallback
if [ ! -d "$TEMPLATECONF" ]; then
   # Allow to use templates at meta-agl-demo/conf
   TEMPLATECONF="$PWD/meta-agl-demo/conf"
fi

echo "envsetup: Using templates for local.conf & bblayers.conf from :"
echo "          '$TEMPLATECONF'"
export TEMPLATECONF

if [ -n "$2" ]; then
  BUILD_DIR="$2"
else
  BUILD_DIR=build
fi

echo "envsetup: Setup build environment for poky/oe."
echo -e

source poky/oe-init-build-env $BUILD_DIR

if [ -n "$DL_DIR" ]; then
        BB_ENV_EXTRAWHITE="$BB_ENV_EXTRAWHITE DL_DIR"
fi

if [ -n "$SSTATE_DIR" ]; then
        BB_ENV_EXTRAWHITE="$BB_ENV_EXTRAWHITE SSTATE_DIR"
fi

export BB_ENV_EXTRAWHITE

unset TEMPLATECONF

case "$EULA_ACCEPT" in
    1)
        echo "" >> conf/local.conf
        echo "# EULA" >> conf/local.conf
        echo "ACCEPT_EULA_$MACHINE = \"1\"" >> conf/local.conf
        ;;
    *)
        ;;
esac
