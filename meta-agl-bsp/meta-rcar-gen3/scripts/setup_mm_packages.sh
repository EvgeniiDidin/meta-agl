#!/bin/bash

ZIP_1="R-Car_Gen3_Series_Evaluation_Software_Package_for_Linux-20170427.zip"
ZIP_2="R-Car_Gen3_Series_Evaluation_Software_Package_of_Linux_Drivers-20170427.zip"

COPY_SCRIPT="$METADIR/meta-renesas-rcar-gen3/meta-rcar-gen3/docs/sample/copyscript/copy_evaproprietary_softwares.sh"

test -f ${XDG_CONFIG_HOME:-~/.config}/user-dirs.dirs && source ${XDG_CONFIG_HOME:-~/.config}/user-dirs.dirs
DOWNLOAD_DIR=${XDG_DOWNLOAD_DIR:-$HOME/Downloads}
EXTRACT_DIR=$METADIR/binary-tmp


function copy_mm_packages() {
        if [ -f $DOWNLOAD_DIR/$ZIP_1 -a -f $DOWNLOAD_DIR/$ZIP_2 ]; then
                mkdir -p $EXTRACT_DIR
                cp --update $DOWNLOAD_DIR/$ZIP_1 $EXTRACT_DIR
                cp --update $DOWNLOAD_DIR/$ZIP_2 $EXTRACT_DIR
        else
                echo -n "The graphics and multimedia acceleration packages for "
                echo -e "the R-Car Gen3 board BSP 2.19 can be downloaded from:"
                echo -e " <https://www.renesas.com/solutions/automotive/rcar-demoboard.html>"
                echo -e
                echo -n "These 2 files from there should be stored in your"
                echo -e "'$DOWNLOAD_DIR' directory."
                echo -e "  $ZIP_1"
                echo -e "  $ZIP_2"
                return 1
        fi

        if [ -f $COPY_SCRIPT ]; then
                cd $METADIR/meta-renesas-rcar-gen3/
                $COPY_SCRIPT -d -f $EXTRACT_DIR
                cd ..
        else
                echo "scripts to copy drivers for Gen3 not found."
                return 1
        fi
}
