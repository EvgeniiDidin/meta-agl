SCREEN_DSI[name] ?= "DSI-1"
SCREEN_DSI[transform] ?= "270"

do_generate_weston_init[vardeps] += "SCREEN_DSI"
