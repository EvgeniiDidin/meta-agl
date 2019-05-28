# setup proprietary gfx drivers and multimedia packages
pushd $METADIR 2>/dev/null

COPY_SCRIPT="$METADIR/bsp/meta-renesas-rcar-gen3/meta-rcar-gen3/docs/sample/copyscript/copy_proprietary_softwares.sh"
EXTRACT_DIR=$METADIR/binary-tmp

if [ ! -d $EXTRACT_DIR ]; then
	echo "ERROR: $EXTRACT_DIR does not exist." && exit 1
else
	[ -z "$(ls -A $EXTRACT_DIR)"  ] && echo "ERROR: $EXTRACT_DIR is empty." && exit 1
fi

if [ -f $COPY_SCRIPT ]; then
	cd $METADIR/bsp/meta-renesas-rcar-gen3/
	$COPY_SCRIPT $EXTRACT_DIR
	cd ..
else
	echo "Script to copy Renesas proprietary drivers for $MACHINE not found."
	exit 1
fi

popd 2>/dev/null
