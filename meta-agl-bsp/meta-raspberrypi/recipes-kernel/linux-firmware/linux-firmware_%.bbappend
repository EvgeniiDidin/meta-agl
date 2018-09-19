# In releases based on Rocko firmware files for bcm43430 and
# bcm43455 are provided by linux-firmware-raspbian. The lines
# below fix eventual duplication of these files.
FILES_${PN}-bcm43455 = ""
FILES_${PN}-bcm43430 = ""
