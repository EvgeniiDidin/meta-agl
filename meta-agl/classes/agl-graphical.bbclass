WESTONTTY ??= "1"
WESTONUSER ??= "display"
WESTONGROUP ??= "display"
WESTONARGS ?= "--idle-time=0  --tty=${WESTONTTY}"
WESTONLAUNCHARGS ??= "--tty /dev/tty${WESTONTTY} --user ${WESTONUSER}"
DISPLAY_XDG_RUNTIME_DIR ??= "/run/platform/${WESTONUSER}"

