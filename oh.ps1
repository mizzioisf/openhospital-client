#!/snap/bin/pwsh
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
#set -o errexit -o pipefail -o noclobber -o nounset

######## Open Hospital - Portable Open Hospital Configuration
# POH_PATH is the directory where Portable OpenHospital files are located
# POH_PATH=/usr/local/PortableOpenHospital

$OH_DISTRO="portable"
#OH_DISTRO="client"
$DEMO_MODE="off"

# Language setting - default set to en
#OH_LANGUAGE=en fr es it pt
#OH_LANGUAGE=it

# set debug level to INFO | DEBUG - default set to INFO
#DEBUG_LEVEL=INFO

######## Software configuration - change at your own risk :-)
# Database
$MYSQL_SERVER="127.0.0.1"
$MYSQL_PORT=3306
$DATABASE_NAME="oh"
$DATABASE_USER="isf"
$DATABASE_PASSWORD="isf123"

$DICOM_MAX_SIZE="4M"

$OH_DIR="oh"
$SQL_DIR="sql"
$MYSQL_SOCKET="var/run/mysqld/mysql.sock"
$MYSQL_DATA_DIR="var/lib/mysql/"
$DB_DEMO="create_all_demo.sql"
$DATE=`date +%Y-%m-%d_%H-%M-%S`

######## Define architecture

#ARCH=`uname -m`
$ARCH=x86_64
$JAVA_ARCH=64

#case $ARCH in
#	x86_64|amd64|AMD64)
#		JAVA_ARCH=64
#		;;
#	i[3456789]86|x86|i86pc)
#		JAVA_ARCH=32
#		;;
#	*)
#		write-host "Unknown architecture $(uname -m)"
#		exit 1
#		;;
#esac

######## MySQL Software
# MariaDB
$MYSQL_URL="https://downloads.mariadb.com/MariaDB/mariadb-10.2.36/bintar-linux-x86_64"
$MYSQL_DIR="mariadb-10.2.36-linux-$ARCH"
# MySQL
#MYSQL_DIR="mysql-5.7.30-linux-glibc2.12-$ARCH"
#MYSQL_URL="https://downloads.mysql.com/archives/get/p/23/file"
$EXT="tar.gz"

######## JAVA Software
######## JAVA 64bit - default architecture
### JRE 8 - openlogic
#JAVA_DISTRO="openlogic-openjdk-jre-8u262-b10-linux-x64"
#JAVA_URL="https://builds.openlogic.com/downloadJDK/openlogic-openjdk-jre/8u262-b10/"
#JAVA_DIR="openlogic-openjdk-jre-8u262-b10-linux-64"

### JRE 11 - zulu
#JAVA_DISTRO="zulu11.43.21-ca-jre11.0.9-linux_x64"
#JAVA_URL="https://cdn.azul.com/zulu/bin"
#JAVA_DIR="zulu11.43.21-ca-jre11.0.9-linux_x64"

### JRE 11 - openjdk
$JAVA_URL="https://github.com/AdoptOpenJDK/openjdk11-binaries/releases/download/jdk-11.0.9%2B11.1"
$JAVA_DISTRO="OpenJDK11U-jre_x64_linux_hotspot_11.0.9_11"
$JAVA_DIR="jdk-11.0.9+11-jre"

######## JAVA 32bit
if ( $JAVA_ARCH = 32 ) {
	# Setting JRE 32 bit
	
	### JRE 8 - openlogic 32bit
	#JAVA_DISTRO="openlogic-openjdk-8u262-b10-linux-x32"
	#JAVA_URL="https://builds.openlogic.com/downloadJDK/openlogic-openjdk/8u262-b10/"
	#JAVA_DIR="openlogic-openjdk-8u262-b10-linux-32"

	### JRE 8 - zulu 32bit
	JAVA_DISTRO="zulu8.50.0.21-ca-jre8.0.272-linux_i686"
	JAVA_URL="https://cdn.azul.com/zulu/bin/"
	JAVA_DIR="zulu8.50.0.21-ca-jre8.0.272-linux_i686"

	### JRE 11 32bit
	#JAVA_DISTRO="zulu11.43.21-ca-jre11.0.9-linux_i686"
	#JAVA_URL="https://cdn.azul.com/zulu/bin/"
	#JAVA_DIR="zulu11.43.21-ca-jre11.0.9-linux_i686"
}

######## set JAVA_BIN
# Uncomment this if you want to use system wide JAVA
#JAVA_BIN=`which java`

# name of this shell script
SCRIPT_NAME=$(basename "$0")

######################## DO NOT EDIT BELOW THIS LINE ########################

######## User input / option parsing

function script_usage {
	# show help
	write-host ""
	write-host " Portable Open Hospital Client - OH"
	write-host ""
	write-host " Usage: $SCRIPT_NAME [-option]"
	write-host ""
	write-host "   -l    en|fr|it|es|pt   --> set language [default set to en]"
	write-host ""
	write-host "   -s    save OH database"
	write-host "   -r    restore OH database"
	write-host "   -c    clean POH installation"
	write-host "   -d    start POH in debug mode"
	write-host "   -C    start Open Hospital - Client / Server mode"
	write-host "   -t    test database connection (Client mode only)"
	write-host "   -v    show POH version information"
	write-host "   -D    start POH in Demo mode"
	write-host "   -G    Setup GSM"
	write-host "   -h    show this help"
	write-host ""
	exit 0
}

######## Functions

function get_confirmation {
$choice = Read-Host -Prompt "(y/n)? "
switch ("$choice") {
	"y"  { "yes"; break }
	"n"  { "Exiting."; exit 0 }
	default {"Invalid choice. Exiting."; exit 1; }
	}
}

function set_path {
	# set current dir
	CURRENT_DIR=$PWD
	# set POH_PATH if not defined
	if ( $POH_PATH ) {
#		write-host "Warning: POH_PATH not found - using current directory"
		POH_PATH=$CURRENT_DIR
		if ( $POH_PATH/$SCRIPT_NAME -and ( Test-Path $POH_PATH/$SCRIPT_NAME )) {
			write-host "Error - oh.sh not found in the current PATH. Please cd the directory where POH was unzipped or set up POH_PATH properly."
			exit 1
		}
	}
	POH_PATH_ESCAPED=$(write-host $POH_PATH | sed -e 's/\//\\\//g')
}

function set_language {
	# Set OH interface languange - set default to en
	if ( $OH_LANGUAGE ) {
		OH_LANGUAGE=en
	}	
#	switch ( "$OH_LANGUAGE" ) {
#		en|fr|it|es|pt) 
			# set database creation script in chosen language
			DB_CREATE_SQL="create_all_$OH_LANGUAGE.sql"
#			;;
#		*)
#			write-host "Invalid option: $OH_LANGUAGE. Exiting."
#			exit 1
#		;;
#	}
}

function java_lib_setup {
	# NATIVE LIB setup
	switch ( $JAVA_ARCH ) {
		64 { NATIVE_LIB_PATH=$POH_PATH/$OH_DIR/lib/native/Linux/amd64 }
		32 { NATIVE_LIB_PATH=$POH_PATH/$OH_DIR/lib/native/Linux/i386 }
	}

	# CLASSPATH setup
	OH_CLASSPATH=$POH_PATH/$OH_DIR/bin/OH-gui.jar
	OH_CLASSPATH=${OH_CLASSPATH}:$POH_PATH/$OH_DIR/bundle
	OH_CLASSPATH=${OH_CLASSPATH}:$POH_PATH/$OH_DIR/rpt

	DIRLIBS=$POH_PATH/$OH_DIR/lib/*.jar
#	for i in ${DIRLIBS}
	foreach ( $i in ${DIRLIBS} ) {
		OH_CLASSPATH="$i":$OH_CLASSPATH
	}
}

function java_check {
if ( $JAVA_BIN -and ( Test-Path $JAVA_BIN )) {
	JAVA_BIN=$POH_PATH/$JAVA_DIR/bin/java
}

if ( ! $JAVA_BIN -and ( Test-Path $JAVA_BIN )) {
	if ( ! "$POH_PATH/$JAVA_DISTRO.$EXT" ) {
		write-host "Warning - JAVA not found. Do you want to download it? (50 MB)"
		get_confirmation;
		# Downloading openjdk binaries
		write-host "Downloading $JAVA_DISTRO..."
		wget -P $POH_PATH/ $JAVA_URL/$JAVA_DISTRO.$EXT
	}
	write-host "Unpacking $JAVA_DISTRO..."
	tar xf $POH_PATH/$JAVA_DISTRO.tar.gz -C $POH_PATH/
	# check for java binary
	if ( "$POH_PATH/$JAVA_DIR/bin/java" -and ( Test-Path "$POH_PATH/$JAVA_DIR/bin/java" )) {
		write-host "Java unpacked successfully!"
		JAVA_BIN=$POH_PATH/$JAVA_DIR/bin/java
		write-host "Java found!"
	else 
		write-host "Error unpacking Java. Exiting."
		exit 1
	}
	write-host "Removing downloaded file..."
	rm $POH_PATH/$JAVA_DISTRO.$EXT
	write-host "Done!"
else
	write-host "JAVA found!"
	write-host "Using $JAVA_DIR"
}
}

function mysql_check {
	if ( ! "$POH_PATH/$MYSQL_DIR" ) {
		if ( "$POH_PATH/$MYSQL_DIR.$EXT" -and ( Test-Path "$POH_PATH/$MYSQL_DIR.$EXT" )) {
			write-host "Warning - MySQL not found. Do you want to download it? (630 MB)"
			get_confirmation;
			# Downloading mysql binary
			write-host "Downloading $MYSQL_DIR..."
			wget -P $POH_PATH/ $MYSQL_URL/$MYSQL_DIR.$EXT
		}
		write-host "Unpacking $MYSQL_DIR..."
		tar xf $POH_PATH/$MYSQL_DIR.$EXT -C $POH_PATH/
		if ( "$POH_PATH/$MYSQL_DIR/bin/mysqld_safe"  -and ( Test-Path "$POH_PATH/$MYSQL_DIR/bin/mysqld_safe"  )) {
			write-host "MySQL unpacked successfully!"
		}
		else {
			write-host "Error unpacking MySQL. Exiting."
			exit 1
		}
		write-host "Removing downloaded file..."
		rm $POH_PATH/$MYSQL_DIR.$EXT
		write-host "Done!"
		else {	
			write-host "MySQL found!"
			write-host "Using $MYSQL_DIR"
		}
	}
}

function config_database {
	# Find a free TCP port to run MySQL starting from the default port
	write-host "Looking for a free TCP port for MySQL database..."
#	while ( $(ss -tna | awk '{ print $4 }' | grep ":$MYSQL_PORT") ); do
#		MYSQL_PORT=$(expr $MYSQL_PORT + 1)
#	done
	MYSQL_PORT=$($MYSQL_PORT + 1)
	write-host "Found TCP port $MYSQL_PORT!"

	# Creating MySQL configuration
	write-host "Generating MySQL config file..."
#	[ -f $POH_PATH/etc/mysql/my.cnf ] && mv -f $POH_PATH/etc/mysql/my.cnf $POH_PATH/etc/mysql/my.cnf.old
	sed -e "s/DICOM_SIZE/$DICOM_MAX_SIZE/g" -e "s/OH_PATH_SUBSTITUTE/$POH_PATH_ESCAPED/g" -e "s/MYSQL_PORT/$MYSQL_PORT/" -e "s/MYSQL_DISTRO/$MYSQL_DIR/g" $POH_PATH/etc/mysql/my.cnf.dist > $POH_PATH/etc/mysql/my.cnf
}

function inizialize_database {
	# Recreate directory structure
	mkdir -p $POH_PATH/$MYSQL_DATA_DIR
	mkdir -p $POH_PATH/var/run/mysqld
	mkdir -p $POH_PATH/var/log/mysql
	# Inizialize MySQL
	write-host "Initializing MySQL database on port $MYSQL_PORT..."
	switch ("$MYSQL_DIR") {
		"mysql" {
			"$POH_PATH/$MYSQL_DIR/bin/mysqld --initialize-insecure --socket=$POH_PATH/$MYSQL_SOCKET --basedir=$POH_PATH/$MYSQL_DIR --datadir=$POH_PATH/$MYSQL_DATA_DIR"
			}
		"mariadb" {
			"$POH_PATH/$MYSQL_DIR/scripts/mysql_install_db --socket=$POH_PATH/$MYSQL_SOCKET --basedir=$POH_PATH/$MYSQL_DIR --datadir=$POH_PATH/$MYSQL_DATA_DIR  --auth-root-authentication-method=normal"
			}
	}

	if ( $? -ne 0 ){
		write-host "Error: MySQL initialization failed! Exiting."
		exit 2
	}
}

function start_database {
	write-host "Starting MySQL server... "
	"$POH_PATH/$MYSQL_DIR/bin/mysqld_safe --defaults-file=$POH_PATH/etc/mysql/my.cnf"
	if ( $? -ne 0 ) {
		write-host "Error: Database not started! Exiting."
		exit 2
	}
	# Wait till the MySQL socket file is created
	# while ( -e $POH_PATH/$MYSQL_SOCKET ); do sleep 1; done
	# # Wait till the MySQL tcp port is open
	# until nc -z $MYSQL_SERVER $MYSQL_PORT; do sleep 1; done
	write-host "MySQL server started! "
}

function import_database () {
	write-host "Creating OH Database..."
	# Create OH database and user
	"$POH_PATH/$MYSQL_DIR/bin/mysql -u root -h $MYSQL_SERVER --port=$MYSQL_PORT -e \
       	CREATE DATABASE $DATABASE_NAME; CREATE USER '$DATABASE_USER'@'localhost' IDENTIFIED BY '$DATABASE_PASSWORD'; \
	CREATE USER '$DATABASE_USER'@'%' IDENTIFIED BY '$DATABASE_PASSWORD'; GRANT ALL PRIVILEGES ON $DATABASE_NAME.* TO '$DATABASE_USER'@'localhost'; \
	GRANT ALL PRIVILEGES ON $DATABASE_NAME.* TO '$DATABASE_USER'@'%' ; "

	# Create OH database structure
	write-host "Importing database schema $DB_CREATE_SQL..."
	cd $POH_PATH/$SQL_DIR
	"$POH_PATH/$MYSQL_DIR/bin/mysql --local-infile=1 -u root -h $MYSQL_SERVER --port=$MYSQL_PORT $DATABASE_NAME < $POH_PATH/$SQL_DIR/$DB_CREATE_SQL"
	if ( $? -ne 0 ) {
		write-host "Error: Database not imported! Exiting."
		shutdown_database;
		exit 2
	}
	write-host "Database imported!"
}

function dump_database {
	# Save OH database if existing
	if ( -x "$POH_PATH/$MYSQL_DIR/bin/mysqldump" ) {
		write-host "Dumping MySQL database..."
		# $POH_PATH/$MYSQL_DIR/bin/mysqldump --no-create-info --skip-extended-insert -h $MYSQL_SERVER --port=$MYSQL_PORT -u root $DATABASE_NAME > $POH_PATH/$SQL_DIR/mysqldump_$DATE.sql
		"$POH_PATH/$MYSQL_DIR/bin/mysqldump --skip-extended-insert -h $MYSQL_SERVER --port=$MYSQL_PORT -u root $DATABASE_NAME > $POH_PATH/$SQL_DIR/mysqldump_$DATE.sql"
		if ( $? -ne 0 ) {
			write-host "Error: Database not dumped! Exiting."
			shutdown_database;
			exit 2
		}
	else {
		write-host "Error: No mysqldump utility found! Exiting."
		shutdown_database;
		exit 2
	}
	}
	write-host "MySQL dump file $SQL_DIR/mysqldump_$DATE.sql completed!"
}

function shutdown_database {
	write-host "Shutting down MySQL..."
	"$POH_PATH/$MYSQL_DIR/bin/mysqladmin --host=$MYSQL_SERVER --port=$MYSQL_PORT --user=root shutdown"
	# Wait till the MySQL socket file is removed
#	while ( -e $POH_PATH/$MYSQL_SOCKET ); do sleep 1; done
}

function clean_database {
	write-host "Warning: do you want to remove all data and database ?"
	get_confirmation;
	write-host "Removing data..."
	# remove databases
	rm -rf $POH_PATH/$MYSQL_DATA_DIR/*
	rm -ff $POH_PATH/var/run/mysqld/*
}

function test_database_connection {
	# Test connection to the OH MySQL database
	write-host "Testing database connection..."
	DBTEST=$($POH_PATH/$MYSQL_DIR/bin/mysql --host=$MYSQL_SERVER --port=$MYSQL_PORT --user=$DATABASE_USER --password=$DATABASE_PASSWORD -e "USE $DATABASE_NAME" >/dev/null 2>&1; write-host "$?" )
	if ( $DBTEST -eq 0 ) {
		write-host "Database connection successfully established!"
	}
	else {
		write-host "Error: can't connect to database! Exiting."
		exit 2
	}
}

function clean_files {
	# clean all generated files - leave only .dist files
	write-host "Warning: do you want to remove all configuration and log files ?"
	get_confirmation;
	write-host "Removing files..."
	rm -f $POH_PATH/etc/mysql/my.cnf
	rm -f $POH_PATH/etc/mysql/my.cnf.old
	rm -f $POH_PATH/var/log/mysql/*
	rm -f $POH_PATH/$OH_DIR/rsc/generalData.properties
	rm -f $POH_PATH/$OH_DIR/rsc/generalData.properties.old
	rm -f $POH_PATH/$OH_DIR/rsc/database.properties
	rm -f $POH_PATH/$OH_DIR/rsc/database.properties.old
	rm -f $POH_PATH/$OH_DIR/rsc/log4j.properties
	rm -f $POH_PATH/$OH_DIR/rsc/log4j.properties.old
	rm -f $POH_PATH/$OH_DIR/rsc/dicom.properties
	rm -f $POH_PATH/$OH_DIR/rsc/dicom.properties.old
	rm -f $POH_PATH/$OH_DIR/logs/*
}


######## Pre-flight checks

# check user running the script
if ( $(id -u) -eq 0 ) {
	write-host "Error - do not run this script as root. Exiting."
	exit 1
}

# debug level - set default to INFO
if ( -z ${DEBUG_LEVEL+x} ) {
	DEBUG_LEVEL="INFO"
}	

######## Environment setup

set_path;
set_language;

######## User input

# list of arguments expected in user the input
$OPTIND=1 # Reset in case getopts has been used previously in the shell.
$OPTSTRING=":h?rcsdCtGDvl:"

# function to parse input
param ($opt)
	write-host $opt 	
	switch ( "$opt" ) {
	"h"	{ # help
		 script_usage; 
		}
	"r"	{ # restore
        	write-host "Restoring Portable Open Hospital database...."
		clean_database;
		# ask user for database to restore
		$DB_CREATE_SQL = Read-Host -Prompt "Enter SQL dump/backup file that you want to restore - (in sql/ subdirectory) -> "
		if ( -f $POH_PATH/$SQL_DIR/$DB_CREATE_SQL ) {
		        write-host "Found $SQL_DIR/$DB_CREATE_SQL, restoring it..."
			}
		else {
			write-host "No SQL file found! Exiting."
			exit 2
		}
        	write-host "Restore ready!"
		}

	"c"	{ # clean
        	write-host "Cleaning Portable Open Hospital installation..."
		clean_files;
		clean_database;
        	write-host "Done!"
		exit 0
		}
	"d"	{ # debug 
        	write-host "Starting Portable Open Hospital in debug mode..."
		DEBUG_LEVEL=DEBUG
		write-host "Debug level set to $DEBUG_LEVEL"
		}
	"s"	{ # save database 
		# checking if data exist
		if ( -d $POH_PATH/$MYSQL_DATA_DIR/$DATABASE_NAME ) {
			mysql_check;
			config_database;
			start_database;
	        	write-host "Saving Portable Open Hospital database..."
			dump_database;
			shutdown_database;
	        	write-host "Done!"
			exit 0
		}
		else {
	        	write-host "Error: no data found! Exiting."
			exit 1
		}
		}
	"C"	{ # start in client mode 
		OH_DISTRO=client
		}
	"l"	{ # set language 
		OH_LANGUAGE=$OPTARG
		set_language;
		}
	"t"	{ # test database connection 
		if ( $OH_DISTRO = portable ) {
			write-host "Only for client mode. Exiting."
			exit 1
		}
		test_database_connection;
		exit 0
		}
	"G"	{ # set up GSM 
		write-host "Setting up GSM..."
		java_check;
		java_lib_setup;
		cd $POH_PATH/$OH_DIR
#		"$JAVA_BIN -Djava.library.path=${NATIVE_LIB_PATH} -classpath $OH_CLASSPATH org.isf.utils.sms.SetupGSM "$@""
		"$JAVA_BIN -Djava.library.path=${NATIVE_LIB_PATH} -classpath $OH_CLASSPATH org.isf.utils.sms.SetupGSM "
		exit 0;
		}
	"D"	{ # demo mode 
        	write-host "Starting Portable Open Hospital in demo mode..."
		OH_DISTRO=portable
		DEMO_MODE="on"
		}
	"v"	{ # show versions 
        	write-host "Architecture is $ARCH"
		write-host "Open Hospital is configured in $OH_DISTRO mode"
		write-host "Language is set to $OH_LANGUAGE"
		write-host "Demo mode is set to $DEMO_MODE"
        	write-host "Software versions:"
		source $POH_PATH/$OH_DIR/rsc/version.properties
        	write-host "Open Hospital version" $VER_MAJOR.$VER_MINOR.$VER_RELEASE
        	write-host "MySQL version: $MYSQL_DIR"
        	write-host "JAVA version:"
		write-host $JAVA_DISTRO
		exit 0
		}
#	"?"	# default
#		default {"Invalid choice. Exiting."; exit 1; }
		default { write-host "Invalid option: -${OPTARG}. See $SCRIPT_NAME -h for help"; exit 1; }
}

######################## Script start ########################

# check distro
if ( -z ${OH_DISTRO+x} ) {
	write-host "Error - OH_DISTRO not defined [client - portable]! Exiting."
	exit 1
}

# check demo mode
if ( $DEMO_MODE = "on" ) {
	if ( Test-Path $POH_PATH/$SQL_DIR/$DB_DEMO ) {
	        write-host "Found SQL demo database, starting OH in demo mode..."
		DB_CREATE_SQL=$DB_DEMO
	}
	else {
	      	write-host "Error: no $DB_DEMO found! Exiting."
		exit 1
	}
}

write-host "Starting Open Hospital in $OH_DISTRO mode..."
write-host "POH_PATH set to $POH_PATH"
write-host "POH language is set to $OH_LANGUAGE"

# check for java
java_check;

# setup java lib
java_lib_setup;

######## Database setup

# Start MySQL and create database
if ( $OH_DISTRO = portable ) {
	# Check for MySQL software
	mysql_check;
	# Config MySQL
	config_database;
	# Check if OH database already exists
	if ( Test-Path $POH_PATH/$MYSQL_DATA_DIR/$DATABASE_NAME ) {
		# Prepare MySQL
		inizialize_database;
		# Start MySQL
		start_database;	
		# Create database and load data
		import_database;
	}
	else {
		# Starting MySQL
		start_database;
	}
}

# test database
test_database_connection;

write-host "Setting up OH configuration files..."

######## DICOM setup
#[ -f $POH_PATH/$OH_DIR/rsc/dicom.properties ] && mv -f $POH_PATH/$OH_DIR/rsc/dicom.properties $POH_PATH/$OH_DIR/rsc/dicom.properties.old
sed -e "s/DICOM_SIZE/$DICOM_MAX_SIZE/" -e "s/OH_PATH_SUBSTITUTE/$POH_PATH_ESCAPED/g" $POH_PATH/$OH_DIR/rsc/dicom.properties.dist > $POH_PATH/$OH_DIR/rsc/dicom.properties

######## log4j.properties setup
#[ -f $POH_PATH/$OH_DIR/rsc/log4j.properties ] && mv -f $POH_PATH/$OH_DIR/rsc/log4j.properties $POH_PATH/$OH_DIR/rsc/log4j.properties.old
sed -e "s/DBPORT/$MYSQL_PORT/" -e "s/DBSERVER/$MYSQL_SERVER/" -e "s/DBUSER/$DATABASE_USER/" -e "s/DBPASS/$DATABASE_PASSWORD/" -e "s/DEBUG_LEVEL/$DEBUG_LEVEL/" $POH_PATH/$OH_DIR/rsc/log4j.properties.dist > $POH_PATH/$OH_DIR/rsc/log4j.properties

######## database.properties setup 
#[ -f $POH_PATH/$OH_DIR/rsc/database.properties ] && mv -f $POH_PATH/$OH_DIR/rsc/database.properties $POH_PATH/$OH_DIR/rsc/database.properties.old
write-host "jdbc.url=jdbc:mysql://{$MYSQL_SERVER}:$MYSQL_PORT/$DATABASE_NAME" > $POH_PATH/$OH_DIR/rsc/database.properties
write-host "jdbc.username=$DATABASE_USER" >> $POH_PATH/$OH_DIR/rsc/database.properties
write-host "jdbc.password=$DATABASE_PASSWORD" >> $POH_PATH/$OH_DIR/rsc/database.properties

######## generalData.properties language setup 
# set language in OH config file
#[ -f $POH_PATH/$OH_DIR/rsc/generalData.properties ] && mv -f $POH_PATH/$OH_DIR/rsc/generalData.properties $POH_PATH/$OH_DIR/rsc/generalData.properties.old
sed -e "s/OH_SET_LANGUAGE/$OH_LANGUAGE/" $POH_PATH/$OH_DIR/rsc/generalData.properties.dist > $POH_PATH/$OH_DIR/rsc/generalData.properties

######## Open Hospital start

write-host "Starting Open Hospital..."

cd $POH_PATH/$OH_DIR

# OH GUI launch
#$JAVA_BIN -Dsun.java2d.dpiaware=false -Djava.library.path=${NATIVE_LIB_PATH} -classpath $OH_CLASSPATH org.isf.menu.gui.Menu 2>&1 > /dev/null
"$JAVA_BIN -Dsun.java2d.dpiaware=false -Djava.library.path=${NATIVE_LIB_PATH} -classpath $OH_CLASSPATH org.isf.menu.gui.Menu 2>&1 > /dev/null"

write-host "Exiting Open Hospital..."

if ( $OH_DISTRO = portable ) {
	shutdown_database;
}

# go back to starting directory
cd $CURRENT_DIR

# exiting
write-host "Done!"
exit 0
