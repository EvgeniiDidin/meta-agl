meta-agl, the Yocto layer for Automotive Grade Linux Distribution
=================================================================

This layer's purpose is ... [TBD]

Layer Dependencies
------------------

URI: git://git.yoctoproject.org/poky
> branch:   dizzy
> revision: 5f0d25152bac2d3798663a4ebfdd2df24060f153

URI: git://git.openembedded.org/meta-openembedded
> layer:    meta-oe
> branch:   dizzy
> revision: 853dcfa0d618dc26bd27b3a1b49494b98d6eee97

Layers
------

There are 2 sub-layers in top-level `meta-agl`.

`meta-agl` is a layer which contains AGL common and middleware packages.
> meta-agl/meta-agl
  
`meta-agl-bsp` is a layer which contains required packages to boot AGL distribution on an emulated machine(QEMU).
> meta-agl/meta-agl-bsp

Packagegroups
-------------

AGL package group design:

These are the top-level packagegroups for AGL Distribution.
> packagegroup-agl-core  (basic/common packages out of oe-core)
> packagegroup-agl-ivi   (middlewares for AGL IVI)

Each package group can contain sub-package groups like these.
> packagegroup-agl-core-multimedia
> packagegroup-agl-core-connectivity
> ...
> packagegroup-agl-ivi-multimedia
> packagegroup-agl-ivi-connectivity
> ...

The recipe for `packagegroup-agl-core-*.bb` will contain common packages between meta-agl, meta-ivi and meta-tizen.
> directory: meta-agl/meta-agl/recipes-core/packagegroups
> recipes  : packagegroup-agl-core-[subsystem].bb

The "packagegroups-agl-ivi-*" will contain AGL specific middleware packages.
> directory: meta-agl/meta-agl/recipes-ivi/packagegroups
> recipes  : packagegroup-agl-ivi-[subsystem].bb

Supported Machine
-----------------

* QEMU (x86-64) - emulated machine: qemux86-64

Supported Target of bitbake
------------------------

* `agl-image-ivi` The baseline image of AGL Distributions

* `agl-image-minimal` For internal use to develop distribution (experimental)
* `agl-image-weston`  For internal use to develop distribution (experimental)

Build a QEMU image
------------------

You can build a QEMU image using the following steps:

1. Export TEMPLATECONF to pick up correct configuration for the build
   > $ export TEMPLATECONF=/full/path/to/meta-agl/meta-agl/conf

2. Rune the following command:
   > $ source poky/oe-init-build-env

3. Build the minimal image of AGL Distribution
   > $ bitbake agl-image-ivi

4. Run the emulator
   > $ PATH_TO_POKY/poky/scripts/runqemu agl-image-ivi qemux86-64

   For large screen:
   > $ PATH_TO_POKY/poky/scripts/runqemu agl-image-ivi qemux86-64 bootparams="uvesafb.mode_option=1280x720-32"

5. Some weston samples are available from weston terminal.
