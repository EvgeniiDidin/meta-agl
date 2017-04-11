WESTONCORE[repaint-window] ??= "34"

WESTONIVISHELL[transition-duration] ??= "300"
WESTONIVISHELL[cursor-theme] ??= "default"

WESTONV4L2RENDERER[device] ??= "/dev/media0"
WESTONV4L2RENDERER[device-module] ??= "vsp2"

python() {
    if "multimedia" in d.getVar("MACHINE_FEATURES", True).split(" "):
        d.setVarFlag("WESTONSECTION", "WESTONV4L2RENDERER", "v4l2-renderer")
}
