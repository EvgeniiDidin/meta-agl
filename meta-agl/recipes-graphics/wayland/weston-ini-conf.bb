SUMMARY = "Startup script and systemd unit file for the Weston Wayland compositor"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COREBASE}/LICENSE;md5=4d92cd373abda3937c2bc47fbc49d690"

S = "${WORKDIR}"

require weston-ini-conf/screen.inc

DEFAULT_SCREEN[transform]?="270"
DEFAULT_SCREEN[name]?="HDMI-A-1"

WESTONCORE[shell]??="desktop-shell.so"
WESTONCORE[backend]??="drm-backend.so"

WESTONSHELL[locking]="true"
# hide panel
WESTONSHELL[panel-location]="none"


WESTONOUTPUT1[agl_screen]??="DEFAULT_SCREEN"

WESTONSECTION[WESTONCORE]?="core"
WESTONSECTION[WESTONSHELL]?="shell"
WESTONSECTION[WESTONOUTPUT1]?="output"

python do_generate_weston_init() {
    with open(d.getVar('WORKDIR', True)+"/weston.ini"  ,'w') as weston_ini:
        dicoSection=d.getVarFlags('WESTONSECTION')
        keysSection=list(dicoSection.keys())
        keysSection.sort()
        for section in keysSection:
            weston_ini.writelines( "["+dicoSection[section]+"]\n")
            dicoSectionValues=d.getVarFlags(section)
            keysSectionValues=list(dicoSectionValues.keys())
            keysSectionValues.sort()
            for sectionValue in keysSectionValues:
                if (dicoSection[section] == "output" and sectionValue == "agl_screen"):
                    screen=dicoSectionValues[sectionValue]
                    dicoScreenConfig=d.getVarFlags(screen)
                    keysScreenConfig=list(dicoScreenConfig.keys())
                    keysScreenConfig.sort()
                    for screenConfig in keysScreenConfig:
                        weston_ini.writelines( screenConfig+"="+dicoScreenConfig[screenConfig]+"\n")
                else:
                    weston_ini.writelines( str(sectionValue)+"="+str(dicoSectionValues[sectionValue])+"\n")

            weston_ini.writelines( "\n")
}

#ar_src = d.getVarFlag('ARCHIVER_MODE', 'src', True)

addtask do_generate_weston_init after do_compile before do_install

do_install_append() {
    WESTON_INI_CONFIG=${sysconfdir}/xdg/weston
    install -d ${D}${WESTON_INI_CONFIG}
    install -m 0644 ${WORKDIR}/weston.ini ${D}${WESTON_INI_CONFIG}/weston.ini
}
