SCREEN_eGalax[name] ?= "HDMI-A-1"
SCREEN_eGalax[transform] ?= "90"

do_generate_weston_init[vardeps] += "SCREEN_eGalax"
