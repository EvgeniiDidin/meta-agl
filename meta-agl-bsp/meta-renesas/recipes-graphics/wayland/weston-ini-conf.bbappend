# Disable LVDS
WESTONOUTPUT2[name] = "LVDS-1"
WESTONOUTPUT2[mode] = "off"

WESTONSECTION[WESTONOUTPUT2] = "output"

do_generate_weston_init[vardeps] += "WESTONOUTPUT2"
