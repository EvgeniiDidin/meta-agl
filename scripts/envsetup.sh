#!/bin/bash

if [ -z $1 ]; then
        echo -e "Usage: source envsetup.sh <board/device> [build dir]"
        return -1
fi

case "$1" in
        "porter")
                # setup proprietary gfx drivers and multimedia packages
                COPY_MM_SCRIPT=meta-renesas/meta-rcar-gen2/scripts/setup_mm_packages.sh
                if [ -f $COPY_MM_SCRIPT ]; then
                        . $COPY_MM_SCRIPT
                        copy_mm_packages $1
                        if [ $? -ne 0 ]; then
                                echo "Copying gfx drivers and multimedia packages for '$1' failed."
                                return -1
                        fi
                fi

                # template conf for R-Car2 M2 Porter board
                TEMPLATECONF=$PWD/meta-renesas/meta-rcar-gen2/conf
                ;;
        "qemux86-64")
                # template conf for QEMU x86-64
                TEMPLATECONF=$PWD/meta-agl-demo/conf
                ;;
        *)
                # nothing to do here
                echo "WARN: '$1' is not tested by AGL Distro"
                if [ -z $TEMPLATECONF ]; then
                        TEMPLATECONF=$PWD/meta-agl-demo/conf
                fi
                ;;
esac

echo "envsetup: Set '$1 as MACHINE."
export MACHINE="$1"

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

