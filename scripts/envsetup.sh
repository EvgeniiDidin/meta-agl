#!/bin/bash

if [ -z $1 ]; then
        echo -e "Usage: source envsetup.sh <board/device> [build dir]"
        return 1
fi

MACHINE="$1"
echo "MACHINE=$MACHINE"

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
