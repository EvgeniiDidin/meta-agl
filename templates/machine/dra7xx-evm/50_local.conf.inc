MACHINE = "dra7xx-evm"

## ATTENTION, this is needed right now to build meta-ti with AGL: ##
## due to meta-ti being based on YP 1.8 instead of YP 2.0
BBMASK  = "meta-ti/.*eudev"
