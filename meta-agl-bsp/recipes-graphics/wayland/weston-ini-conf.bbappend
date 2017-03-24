# OVERRIDES save us some c'n'p below ...
OVERRIDES_prepend_qemux86 = "customwestonini:"
OVERRIDES_prepend_qemux86-64 = "customwestonini:"
# intel-corei7-64 ??

python() {
    if "customwestonini" in d.getVar("OVERRIDES", True).split(":"):
        # DRM backend disabled for now to allow compatibility with VirtualBox
        # and VMWare Player. It may be re-enabled if running on QEMU for
        # potentially increased performance.
        #backend=drm-backend.so
        d.delVarFlag("WESTONCORE", "backend")

        d.setVarFlag("WESTONOUTPUT1","agl_screen", "SCREEN_QEMU")
}


