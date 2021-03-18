#!/bin/bash
#
# Open Hospital (www.open-hospital.org)
# Copyright © 2006-2021 Informatici Senza Frontiere (info@informaticisenzafrontiere.org)
#
# Open Hospital is a free and open source software for healthcare data management.
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# https://www.gnu.org/licenses/gpl-3.0-standalone.html
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program. If not, see <http://www.gnu.org/licenses/>.
#
#

# SET DEBUG mode
# saner programming env: these switches turn some bugs into errors
#set -o errexit -o pipefail -o noclobber -o nounset

######## Open Hospital - Portable Open Hospital Configuration
# OH_PATH is the directory where Portable OpenHospital files are located
# OH_PATH=/usr/local/PortableOpenHospital

OH_SUBDIR="poh-1.11.beta"

######## Software configuration - change at your own risk :-)
OH_DIR="oh"

######## Define architecture

# name of this shell script
SCRIPT_NAME=$(basename "$0")
SCRIPT_ARGS=$@
#SCRIPT_DIR=$(dirname $(readlink -f $0))

# script to launch
TARGET_SCRIPT=oh.sh

######################## DO NOT EDIT BELOW THIS LINE ########################

######## User input / option parsing

function script_usage {
	echo ""
	echo " Open Hospital Client - Web start - experimental "
	echo ""
	echo " Usage: $SCRIPT_NAME [-h][-option]"
	echo ""
	echo " If the script finds a OH installation in the current dir, launches $TARGET_SCRIPT [-params]"
	echo " Otherwise it downloads a dev copy, all the necessary software libraries, clones the OH installation"
	echo " in a subdirectory (poh-version) and launches oh.sh passing the command line options (go.sh -v -> poh-dev/oh.sh -v)"
	echo ""
	echo "   -h    show this help"
	echo ""
	exit 0
}

######## Functions

function get_confirmation {
read -p "(y/n)? " choice
case "$choice" in 
	y|Y ) echo "yes";;
	n|N ) echo "Exiting..."; exit 0;;
	* ) echo "Invalid choice. Exiting."; exit 1 ;;
esac
}

function set_path {
	# set current dir
	CURRENT_DIR=$PWD
	# set OH_PATH if not defined
	if [ -z ${OH_PATH+x} ]; then
		echo "Warning: OH_PATH not found - using current directory"
	fi
	OH_PATH=$PWD
	OH_PATH_ESCAPED=$(echo $OH_PATH | sed -e 's/\//\\\//g')
}

function oh_check_and_go {
	if [ ! -f "$OH_PATH/$OH_DIR/bin/OH-gui.jar" ]; then
		echo "Warning - OH not found in current dir. Do you want to download it? (120 MB)"
		get_confirmation;
		read -p "Enter subdirectory for installation (default $OH_SUBDIR) -> " OH_SUBDIR_TMP
		if [ -z $OH_SUBDIR_TMP ]; then
			echo "Using $OH_SUBDIR"
		else
			OH_SUBDIR=$OH_SUBDIR_TMP
		fi
		# Downloading oh
		echo "Downloading Open Hospital"
		if [ ! -d $OH_PATH/$OH_SUBDIR ]; then
			git clone https://github.com/mizzioisf/openhospital-client $OH_SUBDIR
		fi
		# set new OH_PATH

		OH_PATH=$OH_PATH/$OH_SUBDIR/
                export OH_PATH;
                cd $OH_PATH
                echo "Pulling updates..."
                git pull;
		echo "Download completed!"
	fi
	if [ -x "$OH_PATH/$TARGET_SCRIPT" ]; then
		echo "$TARGET_SCRIPT found!"
		echo "Starting $OH_PATH/$TARGET_SCRIPT.."
		$OH_PATH/$TARGET_SCRIPT $SCRIPT_ARGS
		exit 0;
	fi
	echo "OH installation not working. Exiting."
	exit 1;
}

# list of arguments expected in user the input
OPTIND=1 # Reset in case getopts has been used previously in the shell.
OPTSTRING=":ht:"

# function to parse input
while getopts ${OPTSTRING} opt; do
	case ${opt} in
	h)	# help
		script_usage;
		;;
	esac
done
######################## Script start ########################

# check user
if [ $(id -u) -eq 0 ]; then
	echo "Error - do not run this script as root. Exiting."
	exit 1
fi

######## Environment setup

set_path;
oh_check_and_go;

# go back to starting directory
cd $CURRENT_DIR
