# Select default screen type and orientation
# and only one default output

# Note when such change is applied it will not be taken due to a Yocto cache error
# Fix:
# bitbake weston-ini-conf -c clean ; bitbake weston-ini-conf -c cleansstate

WESTONOUTPUT1[agl_screen] = "SCREEN_eGalax"
