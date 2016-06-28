case "$EULA_ACCEPT" in
	1)
		echo "" >> $BUILDDIR/conf/local.conf
		echo "# EULA" >> $BUILDDIR/conf/local.conf
		echo "ACCEPT_EULA_$MACHINE = \"1\"" >> $BUILDDIR/conf/local.conf
		;;
	*)
		;;
esac

