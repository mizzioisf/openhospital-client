#!/bin/bash
#
# Open Hospital (www.open-hospital.org)
# Copyright © 2006-2020 Informatici Senza Frontiere (info@informaticisenzafrontiere.org)
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
set -o errexit -o pipefail -o noclobber -o nounset

######## Open Hospital - Portable Open Hospital Configuration
# POH_PATH is the directory where Portable OpenHospital files are located
# POH_PATH=/usr/local/PortableOpenHospital

OH_DISTRO=portable
#OH_DISTRO=client
DEMO_MODE=off

# Language setting - default set to en
#OH_LANGUAGE=en fr es it pt
#OH_LANGUAGE=en

######## Software configuration - change at your own risk :-)
OH_DIR="oh"
SQL_DIR="sql"
MYSQL_SOCKET="var/run/mysqld/mysql.sock"
MYSQL_DATA_DIR="var/lib/mysql/"
DB_CREATE_SQL="create_all_en.sql"
DB_DEMO="create_all_demo.sql"
DATE=`date +%Y-%m-%d_%H-%M-%S`

######## Define architecture

# name of this shell script
SCRIPT_NAME=$(basename "$0")
SCRIPT_ARGS=$@
#SCRIPT_DIR=$(dirname $(readlink -f $0))

######################## DO NOT EDIT BELOW THIS LINE ########################

######## User input / option parsing

#function script_usage {
#	echo ""
#	echo " Portable Open Hospital Client | OH"
#	echo ""
#	echo " Usage: $SCRIPT_NAME [-option]"
#	echo ""
#	echo "   -s    save OH database"
#	echo "   -r    restore OH database"
#	echo "   -c    clean POH installation"
#	echo "   -v    show POH version information"
#	echo "   -h    show this help"
#	echo ""
#	exit 0
#}

######## Functions

function get_confirmation {
read -p "(y/n)? " choice
case "$choice" in 
	y|Y ) echo "yes";;
	n|N ) echo "Exiting..."; exit 0;;
	* ) echo "Invalid choice"; exit 1 ;;
esac
}

function set_path {
	# set current dir
	CURRENT_DIR=$PWD
	# set POH_PATH if not defined
	if [ -z ${POH_PATH+x} ]; then
		echo "Warning: POH_PATH not found - using current directory"
	fi
	POH_PATH=$PWD
	POH_PATH_ESCAPED=$(echo $POH_PATH | sed -e 's/\//\\\//g')
}

function oh_check_and_go {
	if [ ! -f "$POH_PATH/$OH_DIR/bin/OH-gui.jar" ]; then
		echo "Warning - OH not found. Do you want to download it? (120 MB)"
		get_confirmation;
		read -p "Enter subdirectory for installation (default poh-1.11.beta) -> " OH_SUBDIR
		if [ -z $OH_SUBDIR ]; then
			OH_SUBDIR="poh-1.11.beta"
			echo "Using $OH_SUBDIR"
		fi
		# Downloading oh
		echo "Downloading Open Hospital"
		if [ ! -d $POH_PATH/$OH_SUBDIR ]; then
			git clone https://github.com/mizzioisf/openhospital-client $OH_SUBDIR
		fi
		# set new POH_PATH
		POH_PATH=$POH_PATH/$OH_SUBDIR/
		export POH_PATH;
		#cd $POH_PATH
		git pull
		echo "Download completed!"
	fi
	if [ -x "$POH_PATH/oh.sh" ]; then
		echo "oh.sh found!"
		echo "Starting $POH_PATH/oh.sh..."
		$POH_PATH/oh.sh $SCRIPT_ARGS
		exit 0;
	fi
	echo "POH installation not working. Exiting."
	exit 1;
}

# list of arguments expected in user the input
#OPTIND=1 # Reset in case getopts has been used previously in the shell.
#OPTSTRING=":hr:"

# function to parse input
#while getopts ${OPTSTRING} opt; do
#	case ${opt} in
#	h)	# help
#		script_usage;
#		;;
#	r)	# restore 
#        	echo "Restoring Portable Open Hospital installation...."
#		set_path;
#		;;
#	esac
#done
######################## Script start ########################

# check distro
if [ -z ${OH_DISTRO+x} ]; then
		echo "Error - OH_DISTRO not defined [client - portable]"
	exit 1
fi

# check user
if [ $(id -u) -eq 0 ]; then
	echo "Error - do not run this script as root. Exiting."
	exit 1
fi

######## Environment setup

echo "Starting OH TEST - $OH_DISTRO..."

set_path;
oh_check_and_go;

# go back to starting directory
cd $CURRENT_DIR
