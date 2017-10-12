# Currently only works with fbdev backend
# and only one default output

WESTONCORE[backend] = "fbdev-backend.so"

SCREEN_fbdev[name] = "fbdev"
SCREEN_fbdev[transform] = "270"
WESTONOUTPUT1[agl_screen] = "SCREEN_fbdev"

do_generate_weston_init[vardeps] += "SCREEN_fbdev"
