# Prevent BlueZ 4 from being always pulled
PACKAGECONFIG_remove = "bluez4"

# If Bluetooth is asked in DISTRO_FEATURES, verify if Bluez 5 is also
# explicitly specified. If it is not, fall back to BlueZ 4
PACKAGECONFIG_append = " ${@bb.utils.contains('DISTRO_FEATURES', 'bluetooth', bb.utils.contains('DISTRO_FEATURES', 'bluez5', 'bluez5', 'bluez4', d), '', d)}"
