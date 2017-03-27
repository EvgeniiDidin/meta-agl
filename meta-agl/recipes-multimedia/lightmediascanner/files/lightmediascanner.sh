#!/bin/sh
#
# Call from udev
#
# Attempt to scan any new inserted media

name="`basename "$DEVNAME"`"

/usr/bin/lightmediascannerctl scan audio:/run/media/$(basename "$DEVNAME")
