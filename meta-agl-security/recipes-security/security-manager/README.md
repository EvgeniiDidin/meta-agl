security-manager adaptation for Automotive Grade Linux Distribution
===================================================================

This recipe complements the recipes security-manager of the
meta yocto layers: meta-intel-iot-security (see
https://github.com/01org/meta-intel-iot-security)

This patches are removing dependencies that are specific to Tizen:
* tizen-platform-config
* libslp-db-utils

The advantages is that this modules are not needed for AGL.

The -temporary- drawbacks is that the user "userapp" is
hard coded for security-manager.


Layer Dependencies
------------------
URI: git@github.com:01org/meta-intel-iot-security.git
> branch: master
> revision: 0ca70e4954aaeb0e3e3ad502b462bb077023f7e5

Enabling
--------

To enable security manager for AGL, in the local.conf

    IMAGE_INSTALL_append = " security-manager"

To enable smack see https://github.com/01org/meta-intel-iot-security/tree/master/meta-security-smack
In brief, in the local.conf:

    OVERRIDES .= ":smack"
    DISTRO_FEATURES_append = " smack"

