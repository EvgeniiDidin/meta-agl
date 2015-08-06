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

## The Renesas R-Car Gen2 (Porter) board depends in addition on: ##

URI: https://gerrit.automotivelinux.org/gerrit/p/AGL/meta-renesas.git
> branch:   agl-1.0-bsp-1.8.0
> revision: 0a69b07cfca17d1435f2bc7bf779139c5fac09a3

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
* Renesas R-Car Gen2 (R-Car M2) - machine: porter

Supported Target of bitbake
------------------------

* `agl-image-ivi` The baseline image of AGL Distributions

* `agl-image-minimal` For internal use to develop distribution (experimental)
* `agl-image-weston`  For internal use to develop distribution (experimental)

Supposed Directory Trees of Layers to build
-------------------------------------------

* For QEMU

      ${TOPDIR}/
                meta-agl/
                meta-openembedded/
                poky/

* For R-Car M2

      ${TOPDIR}/
                meta-agl/
                meta-openembedded/
                meta-renesas/
                poky/

Build a QEMU image
------------------

You can build a QEMU image using the following steps:

1. Export TEMPLATECONF to pick up correct configuration for the build
   > $ export TEMPLATECONF=/full/path/to/meta-agl/meta-agl/conf

2. Run the following command:
   > $ source poky/oe-init-build-env

3. Build the minimal image of AGL Distribution
   > $ bitbake agl-image-ivi

4. Run the emulator
   > $ PATH_TO_POKY/poky/scripts/runqemu agl-image-ivi qemux86-64

   For large screen:
   > $ PATH_TO_POKY/poky/scripts/runqemu agl-image-ivi qemux86-64 bootparams="uvesafb.mode_option=1280x720-32"

5. Some weston samples are available from weston terminal.

Build a R-Car M2 (porter) image
-------------------------------

### Software setup

#### Obtain and Install Renesas Graphics Drivers

See [here](http://wiki.projects.genivi.org/index.php/Hardware_Setup_and_Software_Installation/koelsch%26porter#M2_Porter_low_cost_board) and get 2 ZIP files from the link there.

Note: You have to copy files manually because there is no shell-script
in the current meta-renesas.

1. Unzip the two downloads into a folder. In this example a temporary directory is used.
        $ cd $HOME/AGL
        $ mkdir binary-tmp
        $ <unzip the two downloads into binary-tmp>

   After this step there should be two files in binary-tmp:
        R-Car_Series_Evaluation_Software_Package_for_Linux-*.tar.gz
        R-Car_Series_Evaluation_Software_Package_of_Linux_Drivers-*.tar.gz

2. Extract 2 tar.gz
        tar xf R-Car_Series_Evaluation_Software_Package_for_Linux-*.tar.gz
        tar xf R-Car_Series_Evaluation_Software_Package_of_Linux_Drivers-*.tar.gz

3. Copy 2 files manually
   1. Locate EVA_r8a7791_linux_sgx_binaries_gles2.tar.bz2 in the graphics
   driver deliverable and copy it into the BSP layer. (need rename)
          cp <path_to_file>/EVA_r8a7791_linux_sgx_binaries_gles2.tar.bz2 \
          meta-renesas/meta-rcar-gen2/recipes-graphics/gles-module/\
          gles-user-module/r8a7791_linux_sgx_binaries_gles2.tar.bz2

   2. Locate SGX_KM_M2.tar.bz2 in the graphics driver deliverable and copy
   it into the BSP layer.
          cp <path_to_file>SGX_KM_M2.tar.bz2 \
          meta-renesas/meta-rcar-gen2/recipes-kernel/gles-module/gles-kernel-module

#### Build from the Source code

You can build a R-Car2 M2 (porter) image using the following steps:

1. Export TEMPLATECONF to pick up correct configuration for the build
   > $ export TEMPLATECONF=/full/path/to/meta-renesas/meta-rcar-gen2/conf

2. Run the following command:
   > $ source poky/oe-init-build-env

3. Build the minimal image of AGL Distribution
   > $ bitbake agl-image-ivi

### Deployment (SDCARD)

Follow the instructions [here](http://wiki.projects.genivi.org/index.php/Hardware_Setup_and_Software_Installation/koelsch%26porter#Deployment_.28SDCARD.29)

Note: Use `agl-image-ivi-porter.tar.bz2` as name of root file system archive.
