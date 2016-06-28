# setup proprietary gfx drivers and multimedia packages
pushd $METADIR 2>/dev/null

SETUP_MM_SCRIPT=$METADIR/meta-renesas/meta-rcar-gen2/scripts/setup_mm_packages.sh
if [ -f $SETUP_MM_SCRIPT ]; then
	. $SETUP_MM_SCRIPT $MACHINE
	copy_mm_packages $MACHINE
	if [ $? -ne 0 ]; then
		echo "Copying gfx drivers and multimedia packages for '$MACHINE' failed."
		exit 1
	fi
fi

popd 2>/dev/null
