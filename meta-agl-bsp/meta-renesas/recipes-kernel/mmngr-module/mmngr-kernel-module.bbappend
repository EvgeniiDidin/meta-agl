FILESEXTRAPATHS_prepend := '${THISDIR}/files:'
SRC_URI_append_agl-porter-hibernate = " file://0001-Fix-for-memory-corruption-during-hibernate.patch \
                                      "

