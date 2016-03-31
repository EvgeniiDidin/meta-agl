# This bbappend is to implement native package built
#
# native support has been submitted upstream, and may land in meta-openembedded:
#  http://lists.openembedded.org/pipermail/openembedded-devel/2016-March/106755.html

# all3: to build bin/7za, bin/7z (with its plugins), bin/7zr and bin/7zCon.sfx
EXTRA_OEMAKE_class-native = "all3"

do_install_class-native() {
    install -d ${D}${bindir}
    install -d ${D}${bindir}/Codecs
    install -m 0755 ${S}/bin/7* ${D}${bindir}
    install -m 0755 ${S}/bin/Codecs/* ${D}${bindir}/Codecs

    # Create a shell script wrapper to execute next to 7z.so
    mv ${D}${bindir}/7z ${D}${bindir}/7z.bin
    echo "#! /bin/sh" > ${D}${bindir}/7z
    echo "exec ${D}${bindir}/7z.bin \"\$@\"" >> ${D}${bindir}/7z
    chmod 0755 ${D}${bindir}/7z
}

BBCLASSEXTEND += "native"
