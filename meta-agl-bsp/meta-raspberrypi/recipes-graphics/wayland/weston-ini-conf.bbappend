# Disable LVDS
WESTONOUTPUT2[agl_screen] ??= "SCREEN_DSI"

WESTONSECTION[WESTONOUTPUT2] = "output"

do_generate_weston_init[vardeps] += "WESTONOUTPUT2"
