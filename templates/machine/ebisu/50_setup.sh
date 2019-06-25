# setup proprietary gfx drivers and multimedia packages
pushd $METADIR 2>/dev/null

COPY_SCRIPT="$METADIR/bsp/meta-renesas-rcar-gen3/meta-rcar-gen3/docs/sample/copyscript/copy_proprietary_softwares.sh"
EXTRACT_DIR=$METADIR/binary-tmp
#EBISU_BIN_PATH should contain the path where the .zip archive of E3 binaries is.

# Check the ebisu binaries path
if [[ ! -d $EBISU_BIN_PATH ]] || [[ $EBISU_BIN_PATH == "" ]]; then
	echo "ERROR: E3 Binary path not valid."
	echo "HELP: Export the path where the E3 Binaries ZIP file is into 'EBISU_BIN_PATH' then launch the setup again."
	echo "HELP: Example: '$ export EBISU_BIN_PATH=`pwd`/ebisu_binaries'"
	exit 1
else
	[ -z "$(ls -A $EBISU_BIN_PATH)" ] && echo "ERROR: $EBISU_BIN_PATH is empty. Add the E3 Binaries ZIP file inside and try again." && exit 1
fi

if [ -f $COPY_SCRIPT ]; then
	# Extract the ZIP into the tmp directory
	mkdir -p $EXTRACT_DIR
	unzip -q -o $EBISU_BIN_PATH/*.zip -d $EXTRACT_DIR

	cd $METADIR/bsp/meta-renesas-rcar-gen3/
	$COPY_SCRIPT $EXTRACT_DIR
	cd ..

	#Fix libpvrWAYLAND_WSEGL.so
	#TODO

	#Clean temp dir
	rm -r $EXTRACT_DIR
else
	echo "ERROR: Script to copy Renesas proprietary drivers for $MACHINE not found."
	exit 1
fi

popd 2>/dev/null
