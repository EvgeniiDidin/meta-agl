#!/bin/bash

ZIP_1="R-Car_Gen3_Series_Evaluation_Software_Package_for_Linux-20160906.zip"
ZIP_2="R-Car_Gen3_Series_Evaluation_Software_Package_of_Linux_Drivers-20160906.zip"

COPY_SCRIPT="$METADIR/meta-rcar/meta-rcar-gen3/docs/sample/copyscript/copy_evaproprietary_softwares.sh"

test -f ${XDG_CONFIG_HOME:-~/.config}/user-dirs.dirs && source ${XDG_CONFIG_HOME:-~/.config}/user-dirs.dirs
DOWNLOAD_DIR=${XDG_DOWNLOAD_DIR:-$HOME/Downloads}

function copy_mm_packages() {
        if [ ! -d $METADIR/binary-tmp ]; then
                if [ -f $DOWNLOAD_DIR/$ZIP_1 -a -f $DOWNLOAD_DIR/$ZIP_2 ]; then
                        mkdir $METADIR/binary-tmp
                        cd $METADIR/binary-tmp
                        unzip -o $DOWNLOAD_DIR/$ZIP_1
                        unzip -o $DOWNLOAD_DIR/$ZIP_2
                        cd -
                else
                        echo -n "The graphics and multimedia acceleration packages for "
                        echo -e "the R-Car Gen3 board can be download from :"
                        echo -e "  <http://www.renesas.com/secret/r_car_download/rcar_demoboard.jsp>"
                        echo -e
                        echo -n "These 2 files from there should be store in your"
                        echo -e "'$DOWNLOAD_DIR' directory."
                        echo -e "  $ZIP_1"
                        echo -e "  $ZIP_2"
                        return 1
                fi
        fi

        if [ -f $COPY_SCRIPT ]; then
                cd $METADIR/meta-rcar/
                $COPY_SCRIPT -d -f $METADIR/binary-tmp
                cd ..
        else
                echo "scripts to copy drivers for Gen3 not found."
                return 1
        fi
}
