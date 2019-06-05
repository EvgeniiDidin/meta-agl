#!/bin/bash

ZIP_1="R-Car_Gen3_Series_Evaluation_Software_Package_for_Linux-weston5-20190212.zip"
ZIP_2="R-Car_Gen3_Series_Evaluation_Software_Package_of_Linux_Drivers-weston5-20190212.zip"

#BUG FIX PART (AGL JIRA SPEC-2253)
ARCHIVE_PREFIX_NAME="R-Car_Gen3_Series_Evaluation_Software_Package_for_Linux"
ZIP_BUGFIX=$ARCHIVE_PREFIX_NAME"-weston5-20190516.zip"
TAR_BUGFIX=$ARCHIVE_PREFIX_NAME"-20190516.tar.gz"

COPY_SCRIPT="$METADIR/bsp/meta-renesas-rcar-gen3/meta-rcar-gen3/docs/sample/copyscript/copy_evaproprietary_softwares.sh"

test -f ${XDG_CONFIG_HOME:-~/.config}/user-dirs.dirs && source ${XDG_CONFIG_HOME:-~/.config}/user-dirs.dirs
DOWNLOAD_DIR=${XDG_DOWNLOAD_DIR:-$HOME/Downloads}
EXTRACT_DIR=$METADIR/binary-tmp

stdout_in_terminal=1
[[ -t 1 ]] && stdout_in_terminal=1
function color {
    [[ $stdout_in_terminal == 0 ]] && return
    for k in $*; do
        case $k in
            bold) tput bold;;
            none) tput sgr0;;
            *) tput setaf $k;;
        esac
        if [[ $? != 0 ]]; then
            echo "tput: terminal doesn't support color settings, continuing" >&2
            true
        fi
    done
}
color_green=$(color bold 2)
color_yellow=$(color bold 3)
color_red=$(color bold 1)
color_none=$(color none)

function error() {
    echo "${color_red}$@${color_none}" >&2
}

function log() {
    echo "$@" >&2
}

function copy_mm_packages() {
    if [ -f $DOWNLOAD_DIR/$ZIP_1 -a -f $DOWNLOAD_DIR/$ZIP_2 ]; then
        mkdir -p $EXTRACT_DIR
        cp --update $DOWNLOAD_DIR/$ZIP_1 $EXTRACT_DIR
        cp --update $DOWNLOAD_DIR/$ZIP_2 $EXTRACT_DIR
    else
        error "ERROR: FILES \""+$DOWNLOAD_DIR/$ZIP_1+"\" NOT EXTRACTING CORRECTLY"
        error "ERROR: FILES \""+$DOWNLOAD_DIR/$ZIP_2+"\" NOT EXTRACTING CORRECTLY"
        log   "The graphics and multimedia acceleration packages for "
        log   "the R-Car Gen3 board BSP can be downloaded from:"
        log   "<https://www.renesas.com/us/en/solutions/automotive/rcar-download/rcar-demoboard-2.html>"
        log
        error  "These 2 files from there should be stored in your"
        error  "'$DOWNLOAD_DIR' directory."
        error  "  $ZIP_1"
        error  "  $ZIP_2"
        return 1
    fi

    if [ -f $COPY_SCRIPT ]; then
        cd $METADIR/bsp/meta-renesas-rcar-gen3/
        $COPY_SCRIPT -d -f $EXTRACT_DIR
        cd ..
    else
        log   "scripts to copy drivers for Gen3 not found."
        return 1
    fi

    #BUG FIX PART (AGL JIRA SPEC-2253)
    #Detect supported machine
    if [ $MACHINE == "m3ulcb" ] || [ $MACHINE == "h3ulcb" ]
    then
        GFX_ARCHIVE_NAME="EVARTM0RC779*GLPG0001SL41C_2_0_8_C";
        GFX_BINARIES_NAME="EVA_r8a*_linux_gsx_binaries_gles.tar.bz2";
    else
        log "Note: graphics bug (SPEC-2253) will not be fixed for the requested machine ($MACHINE)."
    fi

    #Get binary file
    if [ -f $DOWNLOAD_DIR/$ZIP_BUGFIX ]; then
        cp --update $DOWNLOAD_DIR/$ZIP_BUGFIX $EXTRACT_DIR
    else
        error "ERROR: FILE '$DOWNLOAD_DIR/$ZIP_BUGFIX' NOT FOUND."
        log   "The graphics and multimedia acceleration packages for "
        log   "the R-Car Gen3 board BSP can be downloaded from:"
        log   "<https://www.renesas.com/us/en/solutions/automotive/rcar-download/rcar-demoboard-2.html>"
        log
        error  "This archive should be stored in your '$DOWNLOAD_DIR' directory."
        error  "Requested archive name: '$ZIP_BUGFIX'"
        return 1
    fi

    #Extract the only the needed GFX binaries
    unzip -d $EXTRACT_DIR -oq $EXTRACT_DIR/$ZIP_BUGFIX
    tar -C $EXTRACT_DIR -zxf $EXTRACT_DIR/$TAR_BUGFIX
    mv $EXTRACT_DIR/$ARCHIVE_PREFIX_NAME/*/*.zip $EXTRACT_DIR

    #Manage the needed GFX binaries
    find $EXTRACT_DIR -name "$GFX_ARCHIVE_NAME.zip" -exec unzip -d $EXTRACT_DIR -oq {} \;
    find $EXTRACT_DIR -name "$GFX_BINARIES_NAME" -exec mv -t $EXTRACT_DIR {} \;
    for f in `find $EXTRACT_DIR -name "$GFX_BINARIES_NAME" -exec basename {} \;`
    do
        mv $EXTRACT_DIR/${f} "$METADIR/bsp/meta-renesas-rcar-gen3/meta-rcar-gen3/recipes-graphics/gles-module/gles-user-module"/${f:4}
    done;

    #Clean
    rm -r $EXTRACT_DIR/$ARCHIVE_PREFIX_NAME
    rm -r $EXTRACT_DIR/$GFX_ARCHIVE_NAME

    log   "The graphics hotfix for BUG SPEC-2253 has been successfully applied."
}
