# Update Linux kernel for Raspberry Pi to 4.19.80. This version
# allows to run firmware KMS to support output through HDMI and
# DSI for the official 7" Raspberry Pi touch screen display.
# Bug-AGL: SPEC-2465
LINUX_VERSION = "4.19.80"
SRCREV = "3492a1b003494535eb1b17aa7f258469036b1de7"

ENABLE_UART_raspberrypi4 = "1"

