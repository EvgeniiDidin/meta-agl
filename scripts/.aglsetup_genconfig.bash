#!/bin/bash

################################################################################
#
# The MIT License (MIT)
#
# Copyright (c) 2016 Stéphane Desneux <sdx@iot.bzh>
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
#
################################################################################

# this script shouldn't be called directly, but through aglsetup.sh that will in 
# turn execute (source) generated instructions back in the parent shell, 
# whether it's bash, zsh, or any other supported shell

VERSION=1.0.0
AGL_REPOSITORIES="meta-agl meta-agl-extra meta-agl-contrib"
DEFAULT_MACHINE=qemux86-64
DEFAULT_BUILDDIR=./build
VERBOSE=0
DEBUG=0

#SCRIPT=$(basename $BASH_SOURCE)
SCRIPT=aglsetup.sh
SCRIPTDIR=$(cd $(dirname $BASH_SOURCE) && pwd -P)
METADIR=$(cd $(dirname $BASH_SOURCE)/../.. && pwd -P)

function info() { echo "$@" >&2; }
function infon() { echo -n "$@" >&2; }
function error() { echo "ERROR: $@" >&2; return 1; }
function verbose() { [[ $VERBOSE == 1 ]] && echo "$@" >&2; return 0; }
function debug() { [[ $DEBUG == 1 ]] && echo "DEBUG: $@" >&2; return 0;}

info "------------ $SCRIPT: Starting"

function list_machines() {
	for x in $@; do
		for y in $(ls -d $METADIR/$x/templates/machine/* 2>/dev/null); do
			echo -n "$(basename $y) "
		done
	done
}

function list_all_machines() {
	for x in $AGL_REPOSITORIES; do
		[[ ! -d $METADIR/$x ]] && continue
		list_machines $x
	done
}

function list_features() {
	for x in $@; do
		for y in $(ls -d $METADIR/$x/templates/feature/* 2>/dev/null); do
			echo -n "$(basename $y) "
		done
	done
}

function list_all_features() {
	for x in $AGL_REPOSITORIES; do
		[[ ! -d $METADIR/$x ]] && continue
		list_features $x
	done
}

function find_machine_dir() {
	machine=$1
	for x in $AGL_REPOSITORIES; do
		[[ ! -d $METADIR/$x ]] && continue
		dir=$METADIR/$x/templates/machine/$machine
		[[ -d $dir ]] && { echo $dir; return 0; }
	done
	return 1
}

function find_feature_dir() {
	feature=$1
	for x in $AGL_REPOSITORIES; do
		[[ ! -d $METADIR/$x ]] && continue
		dir=$METADIR/$x/templates/feature/$feature
		[[ -d $dir ]] && { echo $dir; return 0; }
	done
	return 1
}

function usage() {
    cat <<EOF >&2
Usage: . $SCRIPT [options] [feature [feature [... ]]]

Version: $VERSION
Compatibility: bash, zsh, ksh

Options:
   -m|--machine <machine>
      what machine to use
      default: '$DEFAULT_MACHINE'
   -b|--build <directory>
      build directory to use
      default: '$DEFAULT_BUILDDIR'
   -s|--script <filename>
      file where setup script is generated
      default: none (no script)
   -f|--force
      flag to force overwriting any existing configuration
      default: false
   -v|--verbose
      verbose mode
      default: false
   -d|--debug
      debug mode
      default: false
   -h|--help
      get some help

EOF
	
	echo "Available machines:" >&2
	for x in $AGL_REPOSITORIES; do
		[[ ! -d $METADIR/$x ]] && continue
		echo "   [$x]"
		for y in $(list_machines $x); do 
			[[ $y == $DEFAULT_MACHINE ]] && def="* " || def="  "
			echo "     $def$y"
		done
	done
	echo >&2

	echo "Available features:" >&2
	for x in $AGL_REPOSITORIES; do
		[[ ! -d $METADIR/$x ]] && continue
		echo "   [$x]"
		for y in $(list_features $x); do
			echo "       $y"
		done
	done
	echo >&2
}

function append_fragment() {
	basefile=$1; shift # output file
	f=$1; shift # input file
	label=$(echo "$@")

	debug "adding fragment to $basefile: $f"
	echo >>$basefile
	echo "# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #" >>$basefile
	echo "# fragment { " >>$basefile
	[[ -f $f ]] && echo "# $f" >>$basefile || true
	echo "#" >>$basefile
	[[ -n "$label" ]] && echo "$label" >>$basefile
	[[ -f $f ]] && cat $f >>$basefile || true
	echo "#" >>$basefile
	echo "# }" >>$basefile
	echo "# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #" >>$basefile
	[[ -f $f ]] && echo $f >>$BUILDDIR/conf/fragments.log || true
}

function execute_setup() {
	script=$1
	debug "Executing script $script"
	opts=
	[[ $DEBUG == 1 ]] && opts="$opts -x"
	pushd $BUILDDIR &>/dev/null
		$BASH $opts $script \
			&& rc=0 \
			|| { rc=$?; error "Script $script failed"; }
	popd &>/dev/null
	return $rc
}

# process all fragments
FRAGMENTS_BBLAYERS=""
FRAGMENTS_LOCALCONF=""
FRAGMENTS_SETUP=""
function process_fragments() {
	for dir in "$@"; do
		debug "processing fragments in dir $dir"

		verbose "   Searching fragments: $dir"

		# lookup for files with priorities specified: something like xx_bblayers.conf.yyyyy.inc
		for x in $(ls $dir/??[._]bblayers.conf*.inc 2>/dev/null); do
			FRAGMENTS_BBLAYERS="$FRAGMENTS_BBLAYERS $(basename $x):$x"
			verbose "      priority $(basename $x | cut -c1-2): $(basename $x)"
		done

		# same for local.conf
		for x in $(ls $dir/??[._]local.conf*.inc 2>/dev/null); do
			FRAGMENTS_LOCALCONF="$FRAGMENTS_LOCALCONF $(basename $x):$x"
			verbose "      priority $(basename $x | cut -c1-2): $(basename $x)"
		done

		# same fot setup.sh
		for x in $(ls $dir/??[._]setup*.sh 2>/dev/null); do
			FRAGMENTS_SETUP="$FRAGMENTS_SETUP $(basename $x):$x"
			verbose "      priority $(basename $x | cut -c1-2): $(basename $x)"
		done
	done
}

GLOBAL_ARGS=( "$@" )
debug "Parsing arguments: $@"
TEMP=$(getopt -o m:b:s:fvdh --long machine:,builddir:,script:,force,verbose,debug,help -n $SCRIPT -- "$@")
[[ $? != 0 ]] && { usage; exit 1; }
eval set -- "$TEMP"

set -e

### default options values
MACHINE=$DEFAULT_MACHINE
BUILDDIR=$DEFAULT_BUILDDIR
SETUPSCRIPT=
FORCE=

while true; do
	case "$1" in
		-m|--machine)  MACHINE=$2; shift 2;;
		-b|--builddir) BUILDDIR=$2; shift 2;;
		-s|--setupscript) SETUPSCRIPT=$2; shift 2;;
		-f|--force) FORCE=1; shift;;
		-v|--verbose) VERBOSE=1; shift;;
		-d|--debug) VERBOSE=1; DEBUG=1; shift;;
		-h|--help)     HELP=1; shift;;
		--)            shift; break;;
		*) error "Arguments parsing error"; exit 1;;
	esac
done

[[ "$HELP" == 1 ]] && { usage; exit 0; }

verbose "Command line arguments: ${GLOBAL_ARGS[@]}"

# the remaining args are the features
FEATURES="$@"

# validate the machine
debug "validating machine $MACHINE"
find_machine_dir $MACHINE >/dev/null || error "Machine '$MACHINE' not found in [ $(list_all_machines)]"

# validate the features
for f in $FEATURES; do
	debug "validating feature $f"
	find_feature_dir $f >/dev/null || error "Feature '$f' not found in [ $(list_all_features)]"
done

# validate build dir
debug "validating builddir $BUILDDIR"
BUILDDIR=$(mkdir -p $BUILDDIR && cd $BUILDDIR && pwd -P)

###########################################################################################
function dump_log() {
	info "    ------------ $(basename $1) -----------------"
	sed 's/^/   | /g' $1
	info "    ----------------------------------------"
}

function genconfig() {
	info "Generating configuration files:"
	info "   Build dir: $BUILDDIR"
	info "   Machine: $MACHINE"
	info "   Features: $FEATURES"

	# step 1: run usual OE setup to generate conf dir
	export TEMPLATECONF=$(cd $SCRIPTDIR/../templates/base && pwd -P)
	debug "running oe-init-build-env with TEMPLATECONF=$TEMPLATECONF"
	info "   Running $METADIR/poky/oe-init-build-env"
	info "   Templates dir: $TEMPLATECONF"

	CURDIR=$(pwd -P)
	. $METADIR/poky/oe-init-build-env $BUILDDIR >/dev/null
	cd $CURDIR

	# step 2: concatenate other remaining fragments coming from base
	process_fragments $TEMPLATECONF

	# step 3: fragments for machine
	process_fragments $(find_machine_dir $MACHINE)

	# step 4: fragments for features
	for feature in $FEATURES; do
		process_fragments $(find_feature_dir $feature)
	done

	# step 5: sort fragments and append them in destination files
	FRAGMENTS_BBLAYERS=$(sed 's/ /\n/g' <<<$FRAGMENTS_BBLAYERS | sort)
	debug "bblayer fragments: $FRAGMENTS_BBLAYERS"
	info "   Config: $BUILDDIR/conf/bblayers.conf"
	for x in $FRAGMENTS_BBLAYERS; do
		file=${x/#*:/}
		append_fragment $BUILDDIR/conf/bblayers.conf $file
		verbose "      + $file"
	done

	FRAGMENTS_LOCALCONF=$(sed 's/ /\n/g' <<<$FRAGMENTS_LOCALCONF | sort)
	debug "localconf fragments: $FRAGMENTS_LOCALCONF"
	info "   Config: $BUILDDIR/conf/local.conf"
	for x in $FRAGMENTS_LOCALCONF; do
		file=${x/#*:/}
		append_fragment $BUILDDIR/conf/local.conf $file
		verbose "      + $file"
	done

	FRAGMENTS_SETUP=$(sed 's/ /\n/g' <<<$FRAGMENTS_SETUP | sort)
	debug "setup fragments: $FRAGMENTS_SETUP"
	cat <<EOF >$BUILDDIR/conf/setup.sh
#!/bin/bash

# this script has been generated by $BASH_SOURCE

export MACHINE="$MACHINE"
export FEATURES="$FEATURES"
export BUILDDIR="$BUILDDIR"
export METADIR="$METADIR"

echo "--- beginning of setup script"
EOF
	info "   Setup script: $BUILDDIR/conf/setup.sh"
	for x in $FRAGMENTS_SETUP; do
		file=${x/#*:/}
		append_fragment $BUILDDIR/conf/setup.sh $file "echo '--- fragment $file'"
		verbose "      + $file"
	done
	append_fragment $BUILDDIR/conf/setup.sh "" "echo '--- end of setup script'"

	infon "   Executing setup script ... "
	execute_setup $BUILDDIR/conf/setup.sh >$BUILDDIR/conf/setup.log 2>&1 \
		&& { 
			info "OK"
			[[ $VERBOSE == 1 ]] && dump_log $BUILDDIR/conf/setup.log
			rm $BUILDDIR/conf/setup.sh
		} \
		|| { 
			info "FAIL: please check $BUILDDIR/conf/setup.log"
			dump_log $BUILDDIR/conf/setup.log
			return 1
		}
	# NOTE: the setup.sh script is removed if execution succeeded (only the log remains)
}

###########################################################################################

# check for overwrite
[[ $FORCE -eq 1 ]] && rm -f \
	$BUILDDIR/conf/local.conf \
	$BUILDDIR/conf/bblayers.conf \
	$BUILDDIR/conf/setup.* \
	$BUILDDIR/conf/*.log

if [[ -f $BUILDDIR/conf/local.conf || -f $BUILDDIR/conf/bblayers.conf ]]; then
	info "Configuration files already exist:"
	for x in $BUILDDIR/conf/local.conf $BUILDDIR/conf/bblayers.conf; do
		[[ -f $x ]] && info "   - $x" 
	done
	info "Skipping configuration files generation."
	info "Use option -f|--force to overwrite existing configuration."
else
	genconfig
fi

# always generate setup script in builddir: it can be sourced later manually without re-running the setup
infon "Generating setup file: $BUILDDIR/agl-init-build-env ... "
cat <<EOF >$BUILDDIR/agl-init-build-env
. $METADIR/poky/oe-init-build-env $BUILDDIR
if [ -n "\$DL_DIR" ]; then
	BB_ENV_EXTRAWHITE="\$BB_ENV_EXTRAWHITE DL_DIR"
fi
if [ -n "\$SSTATE_DIR" ]; then
	 BB_ENV_EXTRAWHITE="\$BB_ENV_EXTRAWHITE SSTATE_DIR" 
fi
export BB_ENV_EXTRAWHITE
unset TEMPLATECONF
EOF
info "OK"

# finally, generate output script if requested by caller
if [[ -n "$SETUPSCRIPT" ]]; then
	debug "generating setupscript in $SETUPSCRIPT"
	cat <<EOF >$SETUPSCRIPT
. $BUILDDIR/agl-init-build-env
EOF
fi

info "------------ $SCRIPT: Done"
