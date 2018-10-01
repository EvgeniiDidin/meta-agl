# use a function to be neutral with other fragments
function 01_setup_pkg_revision() {
    # BASH_SOURCE can't be used as this fragment is concatenated in a larger script
    local THIS=meta-agl/templates/base/01_setup_pkg_revision.sh

    # RPMREVISION and LOCALCONF must be set previously in the setup script
    [[ -z "$RPMREVISION" || -z "$LOCALCONF" ]] && return 0

    echo "INFO: using RPM revision schema $RPMREVISION"

    cat <<EOF >> $LOCALCONF

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# fragment {
# generated by $THIS "$RPMREVISION"
#

EOF

    case "$RPMREVISION" in
        prservice*)
            [[ $RPMREVISION =~ ^prservice(:([^ \t\n]+))?$ ]] && {
                echo "PRSERV_HOST ?= \"${BASH_REMATCH[2]:-localhost:0}\"" >> $LOCALCONF
            } || {
                echo "ERROR ($THIS): invalid address specified for PR Service"
                return 1
            }
            ;;
        timestamp)
            AGL_PR=$(date --utc '+%Y%m%d.%H%M%S')
            cat <<'EOF' >> $LOCALCONF
# to re-generate AGL_PR the same way as aglsetup does, run:
#   echo "AGL_PR ?= \"$(date --utc '+%Y%m%d.%H%M%S')\""
EOF
            echo "AGL_PR ?= \"${AGL_PR}\"" >> $LOCALCONF;
            cat <<'EOF' >> $LOCALCONF
PKGR = "${PR}${EXTENDPRAUTO}.${AGL_PR}"
PKGV = "${@ '${PV}'.replace('AUTOINC','${AGL_PR}')}"
BB_HASHBASE_WHITELIST_append = " PKGR PKGV"
EOF
            ;;
        value:*)
            echo "AGL_PR ?= \"${RPMREVISION#value:}\"" >> $LOCALCONF;
            cat <<'EOF' >> $LOCALCONF
PKGR = "${PR}${EXTENDPRAUTO}.${AGL_PR}"
PKGV = "${@ '${PV}'.replace('AUTOINC','${AGL_PR}')}"
BB_HASHBASE_WHITELIST_append = " PKGR PKGV"
EOF
            ;;
        none)
            # do nothing
            ;;
        *)
            echo "ERROR ($THIS): unknown package revision method '$REVISION'"
            return 1
            ;;
    esac

    cat <<'EOF' >> $LOCALCONF

#
# }
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
EOF

}

01_setup_pkg_revision
