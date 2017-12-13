setenv bootargs console=ttySC0,115200 root=/dev/mmcblk0p1 rootwait ro rootfstype=ext4
ext4load mmc 0:1 0x48000000 /boot/${fdtfile}
ext4load mmc 0:1 0x48080000 /boot/Image
booti 0x48080000 - 0x48000000
