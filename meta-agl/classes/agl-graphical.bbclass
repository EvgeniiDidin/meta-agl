WESTONTTY ??= "1"
WESTONUSER ??= "display"
WESTONGROUP ??= "display"
WESTONARGS ?= "--idle-time=4294967"
WESTONLAUNCHARGS ??= "--tty /dev/tty${WESTONTTY} --user ${WESTONUSER}"
DISPLAY_XDG_RUNTIME_DIR ??= "/run/platform/${WESTONUSER}"

