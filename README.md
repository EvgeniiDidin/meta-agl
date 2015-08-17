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

URI: https://gerrit.automotivelinux.org/gerrit/AGL/meta-renesas
> branch:   agl-1.0-bsp-1.8.0
> revision: 13a2551505942808752a1721c9a27ce7d35cec33

Layers
------

There are 3 layers in top-level `meta-agl`.

`meta-ivi-common` is a layer which contains common packages to AGL
Distribution and other platforms for In-Vehicle Infotainment system.
> meta-agl/meta-ivi-common

`meta-agl` is a layer which contains AGL common and middleware packages.
> meta-agl/meta-agl

`meta-agl-bsp` is a layer which contains required packages to boot AGL distribution on an emulated machine(QEMU).
> meta-agl/meta-agl-bsp

Packagegroups
-------------

AGL package group design:

These are the top-level packagegroups for AGL Distribution.
> packagegroup-agl-core  (minimal packages to boot system)
> packagegroup-agl-ivi   (middlewares for AGL IVI)
> packagegroup-ivi-common (common packages to AGL and others)

Each package group can contain sub-package groups like these.
> packagegroup-agl-core-multimedia
> packagegroup-agl-core-connectivity
> ...
> packagegroup-agl-ivi-multimedia
> packagegroup-agl-ivi-connectivity
> ...
> packagegroup-ivi-common-multimedia
> packagegroup-ivi-common-connectivity

The recipe for `packagegroup-ivi-common-*.bb` will contain common packages to
AGL Distribution(meta-agl) and other In-Vehicle Infotainment system(e.g. meta-ivi and meta-tizen).
> directory: meta-agl/meta-ivi-common/recipes-core/packagegroups
> recipes  : packagegroup-ivi-common-[subsystem].bb

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

NOTE: These instructions are based on GENIVI wiki, [here](http://wiki.projects.genivi.org/index.php/Hardware_Setup_and_Software_Installation/koelsch%26porter). If these didn't work correctly especially around Renesas Binary Packages, please check there and updated instructions.

#### Getting Source Code and Build image

1. Create a directory for working, then go to there.
        $ mkdir -p $HOME/ANYWHERE_YOU_WANT_TO_WORK_THERE
        $ cd $HOME/ANYWHERE_YOU_WANT_TO_WORK_THERE
        $ export AGL_TOP=`pwd`

2. Get the meta data and checkout
        $ git clone git://git.yoctoproject.org/poky
        $ cd poky
        $ git checkout 5f0d25152bac2d3798663a4ebfdd2df24060f153
        $ cd -
        $ git clone git://git.openembedded.org/meta-openembedded
        $ cd meta-openembedded
        $ git checkout 853dcfa0d618dc26bd27b3a1b49494b98d6eee97
        $ cd -
        $ git clone https://gerrit.automotivelinux.org/gerrit/AGL/meta-renesas
        $ cd meta-renesas
        $ git checkout c28172567a6325f5692e5d33b1ae1c1e64e59ddf
        $ cd -
        $ git clone https://gerrit.automotivelinux.org/gerrit/AGL/meta-agl

#### Obtain and Install Renesas Graphics Drivers

1. Download packages from Renesas

  The graphics and multimedia acceleration packages for the R-Car M2 Porter board
  can be download directory from [here](http://www.renesas.com/secret/r_car_download/rcar_demoboard.jsp).

  There are 2 ZIP files can be downloaded.
    * Multimedia and Graphics library which require registeration and click through license
    > r-car_series_evaluation_software_package_for_linux-*.zip
    * Related Linux drivers
    > r-car_series_evaluation_software_package_of_linux_drivers-*.zip

2. Unzip the two downloads into a temporary directory.
        $ cd $AGL_TOP
        $ mkdir binary-tmp
        $ cd binary-tmp
        $ unzip PATH_TO_DOWNLOAD/r-car_series_evaluation_software_package_for_linux-*.zip
        $ unzip PATH_TO_DOWNLOAD/r-car_series_evaluation_software_package_of_linux_drivers-*.zip

   After this step there should be two files in binary-tmp:
   * Multimedia and Graphics library
   > R-Car_Series_Evaluation_Software_Package_for_Linux-*.tar.gz
   * Related Linux drivers
   > R-Car_Series_Evaluation_Software_Package_of_Linux_Drivers-*.tar.gz

3. Extract 2 tar archives
        $ tar xf R-Car_Series_Evaluation_Software_Package_for_Linux-*.tar.gz
        $ tar xf R-Car_Series_Evaluation_Software_Package_of_Linux_Drivers-*.tar.gz

4. Copy 2 files manually
   1. Locate `EVA_r8a7791_linux_sgx_binaries_gles2.tar.bz2` in the Multimedia and Graphics library deliverable and copy it into the BSP layer.
          $ cd $AGL_TOP
          $ cp <path_to_file>/EVA_r8a7791_linux_sgx_binaries_gles2.tar.bz2 \
          meta-renesas/meta-rcar-gen2/recipes-graphics/gles-module/\
          gles-user-module/r8a7791_linux_sgx_binaries_gles2.tar.bz2

   2. Locate `SGX_KM_M2.tar.bz2` in the related linux drivers deliverable and copy it into the BSP layer.
          $ cp <path_to_file>SGX_KM_M2.tar.bz2 \
          $ meta-renesas/meta-rcar-gen2/recipes-kernel/gles-module/gles-kernel-module

#### Build from the Source code

You can build a R-Car2 M2 (porter) image using the following steps:

1. Export TEMPLATECONF to pick up correct configuration for the build
        $ export TEMPLATECONF=$AGL_TOP/meta-renesas/meta-rcar-gen2/conf

2. Run the following command:
        $ cd $AGL_TOP
        $ source poky/oe-init-build-env

3. Build the minimal image of AGL Distribution
        $ bitbake agl-image-ivi

### Deployment (SDCARD)

NOTE: These instructions are based on GENIVI wiki, [here](http://wiki.projects.genivi.org/index.php/Hardware_Setup_and_Software_Installation/koelsch%26porter#Deployment_.28SDCARD.29).

#### Instructions on the host

1. Format SD-Card and then, create single EXT3 partition on it.

2. Mount the SD-Card, for example `/media/$SDCARD_LABEL`.

3. Copy AGL root file system onto the SD-Card
   1. Go to build directory
           $ cd $AGL_TOP/build/tmp/deploy/images/porter
   2. Extract the root file system into the SD-Card
           $ sudo tar --extract --numeric-owner --preserve-permissions --preserve-order \
           --totals --directory=/media/$SDCARD_LABEL --file=agl-image-ivi-porter.tar.bz2
   3. Copy kernel and DTB into the `/boot` of the SD-Card
           $ sudo cp uImage uImage-r8a7791-porter.dtb /media/$SDCARD_LABEL

4. After the copy finished, unmount SD-Card and insert it into the SD-Card slot of the porter board.

#### Instructions on the host

NOTE: There is details about porter board [here](http://elinux.org/R-Car/Boards/Porter).

NOTE: To boot weston on porter board, we need keyboard and mouse. (USB2.0 can be use for this)

##### Change U-Boot parameters to boot from SD card

1. Power up the board and, using your preferred terminal emulator, stop the board's autoboot by hitting any key.

  > Debug serial settings are 38400 8N1. Any standard terminal emulator program can be used.

2. Set the follow environment variables and save them
        => setenv bootargs_console console=ttySC6,${baudrate}
        => setenv bootargs_video vmalloc=384M video=HDMI-A-1:1024x768-32@60
        => setenv bootcmd_sd 'ext4load mmc 0:1 0x40007fc0 boot/uImage;ext4load mmc 0:1 0x40f00000 boot/uImage-r8a7791-porter.dtb'
        => setenv bootcmd 'setenv bootargs ${bootargs_console} ${bootargs_video} root=/dev/mmcblk0p1 rw rootfstype=ext3;run bootcmd_sd;bootm 0x40007fc0 - 0x40f00000'
        => saveenv

##### Boot from SD card

1. After board reset, U-Boot is started and after a countdown, ...
   Linux boot message should be displayed. Please wait a moment.
2. Then weston is booted automatically, and weston-terminal appears.

3. Have fun! :)
