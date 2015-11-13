# If Bluetooth is asked in DISTRO_FEATURES, verify if Bluez 5 is also
# explicitly specified. If it is not, fall back to BlueZ 4
BLUEZ_CONFIG = "bluez='true',bluez='false',${@bb.utils.contains('DISTRO_FEATURES', 'bluetooth', bb.utils.contains('DISTRO_FEATURES', 'bluez5', 'bluez5', 'bluez4', d), '', d)}"
PACKAGECONFIG[bluez] := "${BLUEZ_CONFIG}"
