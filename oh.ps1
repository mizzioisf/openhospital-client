#!/snap/bin/pwsh
#%SystemRoot%\system32\WindowsPowerShell\v1.0\powershell.exe
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


Set-Variable -Name POH_PATH -Option AllScope
Set-Variable -Name OH_DISTRO -Option AllScope
Set-Variable -Name OH_LANGUAGE -Option AllScope
Set-Variable -Name JAVA_BIN -Option AllScope
Set-Variable -Name MYSQL_DIR -Option AllScope
Set-Variable -Name MYSQL_DATA_DIR -Option AllScope
Set-Variable -Name MYSQL_SOCKET -Option AllScope
Set-Variable -Name DATABASE_NAME -Option AllScope
Set-Variable -Name CURRENT_DIR -Option AllScope
Set-Variable -Name OH_CLASSPATH -Option AllScope
Set-Variable -Name NATIVE_LIB_PATH -Option AllScope

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
$DATE= Get-Date

######## Define architecture

#ARCH=`uname -m`
$ARCH="x86_64"
$JAVA_ARCH="64"

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
$MYSQL_URL="http://ftp.bme.hu/pub/mirrors/mariadb/mariadb-10.2.36/winx64-packages/mariadb-10.2.36-winx64.zip"
$MYSQL_DIR="mariadb-10.2.36-winx64"
# MySQL
#MYSQL_DIR="mysql-5.7.30-linux-glibc2.12-$ARCH"
#MYSQL_URL="https://downloads.mysql.com/archives/get/p/23/file"
$EXT="zip"

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

$JAVA_URL="https://github.com/AdoptOpenJDK/openjdk11-binaries/releases/download/jdk-11.0.9.1%2B1/"
$JAVA_DISTRO="OpenJDK11U-jre_x64_windows_hotspot_11.0.9.1_1"
$JAVA_DIR="jdk-11.0.9.1+1-jre"


######## JAVA 32bit
if ( $JAVA_ARCH -eq "32" ) {
	# Setting JRE 32 bit
	
	### JRE 8 - openlogic 32bit
	#JAVA_DISTRO="openlogic-openjdk-8u262-b10-linux-x32"
	#JAVA_URL="https://builds.openlogic.com/downloadJDK/openlogic-openjdk/8u262-b10/"
	#JAVA_DIR="openlogic-openjdk-8u262-b10-linux-32"

	### JRE 8 - zulu 32bit
	$JAVA_DISTRO="zulu8.50.0.21-ca-jre8.0.272-linux_i686"
	$JAVA_URL="https://cdn.azul.com/zulu/bin/"
	$JAVA_DIR="zulu8.50.0.21-ca-jre8.0.272-linux_i686"

	### JRE 11 32bit
	#JAVA_DISTRO="zulu11.43.21-ca-jre11.0.9-linux_i686"
	#JAVA_URL="https://cdn.azul.com/zulu/bin/"
	#JAVA_DIR="zulu11.43.21-ca-jre11.0.9-linux_i686"
}

######## set JAVA_BIN # Uncomment this if you want to use system wide JAVA
#JAVA_BIN=`which java`

# name of this shell script
# Determine script location for PowerShell
$SCRIPT_DIR = Split-Path $script:MyInvocation.MyCommand.Path
$SCRIPT_NAME = $MyInvocation.MyCommand.Name
Write-Host "Current script directory is $SCRIPT_DIR"
Write-Host "Current script $SCRIPT_NAME"


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
	$CURRENT_DIR=Get-Location | select -ExpandProperty Path
	write-host $CURRENT_DIR
	# set POH_PATH if not defined
	if ( ! $POH_PATH ) {
		write-host "Warning: POH_PATH not found - using current directory"
		$POH_PATH="$CURRENT_DIR"
		if ( ! (Test-Path -Path "$POH_PATH/$SCRIPT_NAME") ) {
			write-host "Error - $SCRIPT_NAME not found in the current PATH. Please cd the directory where POH was unzipped or set up POH_PATH properly."
			exit 1
		}
	}
#	$POH_PATH_ESCAPED=$(write-host $POH_PATH | sed -e 's/\//\\\//g'")
#	$POH_PATH_ESCAPED=$POH_PATH
}

function set_language {
	# Set OH interface languange - set default to en
	if ( ! $OH_LANGUAGE ) {
		$OH_LANGUAGE="en"
	}	
#	switch ( "$OH_LANGUAGE" ) {
#		en|fr|it|es|pt) 
			# set database creation script in chosen language
			$DB_CREATE_SQL="create_all_$OH_LANGUAGE.sql"
#			;;
#		*)
#			write-host "Invalid option: $OH_LANGUAGE. Exiting."
#			exit 1
#		;;
#	}
}

function java_lib_setup {
	# NATIVE LIB setup
	switch ( "$JAVA_ARCH" ) {
		"64" { $NATIVE_LIB_PATH="$POH_PATH\$OH_DIR\lib\native\Win64" }
		"32" { $NATIVE_LIB_PATH="$POH_PATH\$OH_DIR\lib\native\Windows" }
	}

	# CLASSPATH setup
	$OH_CLASSPATH="$POH_PATH\$OH_DIR\bin\OH-gui.jar"
	$OH_CLASSPATH="${OH_CLASSPATH}:$POH_PATH\$OH_DIR\bundle"
	$OH_CLASSPATH="${OH_CLASSPATH}:$POH_PATH\$OH_DIR\rpt"

#FOR %%A IN (%OH_LIB%\*.jar) DO (
#        set CLASSPATH=!CLASSPATH!;%%A
#)


	$DIRLIBS="$POH_PATH\$OH_DIR\lib"
	write-host "---->>> $DIRLIBS"
#	for i in ${DIRLIBS}
#	gci -file -r *.pdf
	foreach ( $i in ${DIRLIBS} ) {
		$OH_CLASSPATH="{$OH_CLASSPATH}:{$i}"
		write-host "---------$OH_CLASSPATH"
	}
}

function java_check {
if ( $JAVA_BIN -and ( Test-Path -Path $JAVA_BIN )) {
	$JAVA_BIN="$POH_PATH/$JAVA_DIR/bin/java.exe"
}

write-host "--------$JAVA_BIN"

#if ( !($JAVA_BIN) ) {
#if ( ! (Test-Path $JAVA_BIN )) {
	if ( ! "$POH_PATH/$JAVA_DISTRO.$EXT" ) {
		write-host "Warning - JAVA not found. Do you want to download it? (50 MB)"
		get_confirmation;
		# Downloading openjdk binaries
		write-host "Downloading $JAVA_DISTRO..."
#		wget -P $POH_PATH/ $JAVA_URL/$JAVA_DISTRO.$EXT
	}
	write-host "Unpacking $JAVA_DISTRO..."
	#Expand-Archive "$POH_PATH\$JAVA_DISTRO.$EXT" -DestinationPath $POH_PATH/
	# Expand-Archive "$POH_PATH\$JAVA_DISTRO.$EXT"
	# check for java binary
	if ( Test-Path -Path "$POH_PATH/$JAVA_DIR/bin/java.exe" ) {
		write-host "Java unpacked successfully!"
		$JAVA_BIN="$POH_PATH/$JAVA_DIR/bin/java.exe"
		write-host "Java found!"
	}
	else {
		write-host "Error unpacking Java. Exiting."
		exit 1
	}
	write-host "Removing downloaded file..."
	#rm $POH_PATH/$JAVA_DISTRO.$EXT
	write-host "Done!"
	#else 
	write-host "JAVA found!"
	write-host "Using $JAVA_DIR"
}
#}
#}

function mysql_check {
	if ( ! "$POH_PATH/$MYSQL_DIR" ) {
		if ( "$POH_PATH/$MYSQL_DIR.$EXT" -and ( Test-Path -Path "$POH_PATH/$MYSQL_DIR.$EXT" )) {
			write-host "Warning - MySQL not found. Do you want to download it? (630 MB)"
			get_confirmation;
			# Downloading mysql binary
			write-host "Downloading $MYSQL_DIR..."
#			wget -P $POH_PATH/ $MYSQL_URL/$MYSQL_DIR.$EXT
		}
		write-host "Unpacking $MYSQL_DIR..."
		unzip $POH_PATH/$MYSQL_DIR.$EXT -C $POH_PATH/
		if ( "$POH_PATH/$MYSQL_DIR/bin/mysqld_safe.exe"  -and ( Test-Path -Path "$POH_PATH/$MYSQL_DIR/bin/mysqld_safe.exe"  )) {
			write-host "MySQL unpacked successfully!"
		}
		else {
			write-host "Error unpacking MySQL. Exiting."
			exit 1
		}
		write-host "Removing downloaded file..."
		# rm $POH_PATH/$MYSQL_DIR.$EXT
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
	$MYSQL_PORT=$($MYSQL_PORT + 1)
	write-host "Found TCP port $MYSQL_PORT!"

	# Creating MySQL configuration
	write-host "Generating MySQL config file..."
#	[ -f $POH_PATH/etc/mysql/my.cnf ] && mv -f $POH_PATH/etc/mysql/my.cnf $POH_PATH/etc/mysql/my.cnf.old
	(Get-Content "$POH_PATH\etc/mysql\my.cnf.dist").replace("DICOM_SIZE","$DICOM_MAX_SIZE") | Set-Content "$POH_PATH\etc\mysql\my.cnf"
	(Get-Content "$POH_PATH\etc/mysql\my.cnf").replace("OH_PATH_SUBSTITUTE","$POH_PATH") | Set-Content "$POH_PATH\etc\mysql\my.cnf"
	(Get-Content "$POH_PATH\etc/mysql\my.cnf").replace("MYSQL_PORT","$MYSQL_PORT") | Set-Content "$POH_PATH\etc\mysql\my.cnf"
	(Get-Content "$POH_PATH\etc/mysql\my.cnf").replace("MYSQL_DISTRO","$MYSQL_DIR") | Set-Content "$POH_PATH\etc\mysql\my.cnf"

#	sed -e "s/DICOM_SIZE/$DICOM_MAX_SIZE/g" -e "s/OH_PATH_SUBSTITUTE/$POH_PATH_ESCAPED/g" -e "s/MYSQL_PORT/$MYSQL_PORT/" -e "s/MYSQL_DISTRO/$MYSQL_DIR/g" $POH_PATH/etc/mysql/my.cnf.dist > $POH_PATH/etc/mysql/my.cnf
}

function inizialize_database {
	# Recreate directory structure
	#mkdir -p $POH_PATH/$MYSQL_DATA_DIR
	#mkdir -p $POH_PATH/var/run/mysqld
	#mkdir -p $POH_PATH/var/log/mysql
	del "$POH_PATH/var/lib/mysql/*"
	# Inizialize MySQL
	write-host "Initializing MySQL database on port $MYSQL_PORT..."
	write-host "-------------- $MYSQL_DIR..."
	switch -Regex ( $MYSQL_DIR ) {
		"mysql" {
		write-host "MYSQL"
			Start-Process "$POH_PATH\$MYSQL_DIR\bin\mysqld.exe" -ArgumentList ("--initialize-insecure --socket=$POH_PATH\$MYSQL_SOCKET --basedir=$POH_PATH\$MYSQL_DIR --datadir=$POH_PATH\$MYSQL_DATA_DIR") -NoNewWindow; break
			}
		"mariadb" {
		write-host "MARIADB"
#			Start-Process -FilePath "$POH_PATH\$MYSQL_DIR\bin\mysql_install_db.exe" -ArgumentList ("--socket=$POH_PATH\$MYSQL_SOCKET --basedir=$POH_PATH\$MYSQL_DIR --datadir=$POH_PATH\$MYSQL_DATA_DIR  --auth-root-authentication-method=normal") -Wait -NoNewWindow ; break
			Start-Process -FilePath "$POH_PATH\$MYSQL_DIR\bin\mysql_install_db.exe" -ArgumentList ("--datadir=$POH_PATH\$MYSQL_DATA_DIR") -Wait -NoNewWindow 			}
	}

#	if ( $? -ne 0 ){
#		write-host "Error: MySQL initialization failed! Exiting."
#		exit 2
#	}
}

function start_database {
	write-host "Starting MySQL server... "
#	"$POH_PATH/$MYSQL_DIR/bin/mysqld_safe --defaults-file=$POH_PATH\etc\mysql\my.cnf"

	Start-Process -FilePath "$POH_PATH\$MYSQL_DIR\bin\mysqld.exe" -ArgumentList ("--defaults-file=$POH_PATH\etc\mysql\my.cnf --tmpdir=$POH_PATH\tmp --standalone --console") -NoNewWindow  -RedirectStandardOutput '.\console.out' -RedirectStandardError '.\console.err'
	#Start-Process -FilePath "$POH_PATH\$MYSQL_DIR\bin\mysqld.exe" -ArgumentList ("--defaults-file=$POH_PATH\etc\mysql\my.cnf", "--tmpdir=$POH_PATH\tmp", "--standalone", "--console", "--log_syslog=0")


#	 Start-Process java -ArgumentList '-jar', 'MyProgram.jar' ` -RedirectStandardOutput '.\console.out' -RedirectStandardError '.\console.err'
	 #start /b /min %OH_PATH%\%MYSQL_DIR%\bin\mysqld --tmpdir=%OH_PATH%\tmp --standalone --console --log_syslog=0
#	 %OH_PATH%\%MYSQL_DIR%\bin\mysqld --tmpdir=%OH_PATH%\tmp --standalone --console --log_syslog=0

#	if ( $? -ne 0 ) {
#		write-host "Error: Database not started! Exiting."
#		exit 2
#	}

	# Wait till the MySQL socket file is created
	# while ( -e $POH_PATH/$MYSQL_SOCKET ); do sleep 1; done
	# # Wait till the MySQL tcp port is open
	# until nc -z $MYSQL_SERVER $MYSQL_PORT; do sleep 1; done
	write-host "MySQL server started! "
}

function import_database () {
	write-host "Creating OH Database..."
	# Create OH database and user
	Start-Process -FilePath "$POH_PATH\$MYSQL_DIR\bin\mysql.exe" -ArgumentList ("-u root -h $MYSQL_SERVER --port=$MYSQL_PORT -e ""CREATE DATABASE $DATABASE_NAME; `
	CREATE USER \'$DATABASE_USER\'@\'localhost\' IDENTIFIED BY \'$DATABASE_PASSWORD\'; `
	CREATE USER \'$DATABASE_USER\'\@\'\%\' IDENTIFIED BY \'$DATABASE_PASSWORD\'; GRANT ALL PRIVILEGES ON $DATABASE_NAME.* TO \'$DATABASE_USER\'@\'localhost\'; `
	GRANT ALL PRIVILEGES ON $DATABASE_NAME.* TO \'$DATABASE_USER\'\@\'\%\' ;""") -NoNewWindow

	# Create OH database structure
	write-host "Importing database schema $DB_CREATE_SQL..."
	cd $POH_PATH/$SQL_DIR
	Start-Process -FilePath "$POH_PATH/$MYSQL_DIR/bin/mysql.exe" -ArgumentList ("--local-infile=1 -u root -h $MYSQL_SERVER --port=$MYSQL_PORT $DATABASE_NAME < $POH_PATH/$SQL_DIR/$DB_CREATE_SQL") -NoNewWindow
#	if ( $? -ne 0 ) {
#		write-host "Error: Database not imported! Exiting."
#		shutdown_database;
#		exit 2
#	}
	write-host "Database imported!"
}

function dump_database {
	# Save OH database if existing
	if ( -x "$POH_PATH/$MYSQL_DIR/bin/mysqldump.exe" ) {
		write-host "Dumping MySQL database..."
		# $POH_PATH/$MYSQL_DIR/bin/mysqldump.exe --no-create-info --skip-extended-insert -h $MYSQL_SERVER --port=$MYSQL_PORT -u root $DATABASE_NAME > $POH_PATH/$SQL_DIR/mysqldump_$DATE.sql
		"$POH_PATH/$MYSQL_DIR/bin/mysqldump.exe --skip-extended-insert -h $MYSQL_SERVER --port=$MYSQL_PORT -u root $DATABASE_NAME > $POH_PATH/$SQL_DIR/mysqldump_$DATE.sql"
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
	Start-Process -FilePath "$POH_PATH/$MYSQL_DIR/bin/mysqladmin.exe" -ArgumentList ("--host=$MYSQL_SERVER --port=$MYSQL_PORT --user=root shutdown") -NoNewWindow
	# Wait till the MySQL socket file is removed
#	while ( -e $POH_PATH/$MYSQL_SOCKET ); do sleep 1; done
}

function clean_database {
	write-host "Warning: do you want to remove all data and database ?"
	get_confirmation;
	write-host "Removing data..."
	# remove databases
	del "$POH_PATH/$MYSQL_DATA_DIR/*"
	Get-ChildItem -Path "$POH_PATH\$MYSQL_DATA_DIR\" | Remove-Item -Recurse -Confirm:$false
	Get-ChildItem -Path "$POH_PATH\var\run\mysqld\" | Remove-Item -Recurse -Confirm:$false
}

function test_database_connection {
	# Test connection to the OH MySQL database
	write-host "Testing database connection..."
#	$DBTEST=$("$POH_PATH/$MYSQL_DIR/bin/mysql.exe --host=$MYSQL_SERVER --port=$MYSQL_PORT --user=$DATABASE_USER --password=$DATABASE_PASSWORD -e USE $DATABASE_NAME;" )
#	if ( $DBTEST -eq 0 ) {
#		write-host "Database connection successfully established!"
#	}
#	else {
#		write-host "Error: can't connect to database! Exiting."
#		exit 2
#	}
}

function clean_files {
	# clean all generated files - leave only .dist files
	write-host "Warning: do you want to remove all configuration and log files ?"
	get_confirmation;
	write-host "Removing files..."

	Get-ChildItem -Path "$POH_PATH\etc\mysql\my.cnf" | Remove-Item -Recurse -Confirm:$false -ErrorAction Ignore
	Get-ChildItem -Path "$POH_PATH\etc\mysql\my.cnf.old" | Remove-Item -Recurse -Confirm:$false -ErrorAction Ignore
	Get-ChildItem -Path "$POH_PATH\var\log\mysql\*" | Remove-Item -Recurse -Confirm:$false -ErrorAction Ignore
	Get-ChildItem -Path "$POH_PATH\$OH_DIR\rsc\generalData.properties" | Remove-Item -Recurse -Confirm:$false -ErrorAction Ignore
	Get-ChildItem -Path "$POH_PATH\$OH_DIR\rsc\generalData.properties.old" | Remove-Item -Recurse -Confirm:$false -ErrorAction Ignore
	Get-ChildItem -Path "$POH_PATH\$OH_DIR\rsc\database.properties" | Remove-Item -Recurse -Confirm:$false -ErrorAction Ignore
	Get-ChildItem -Path "$POH_PATH\$OH_DIR\rsc\database.properties.old" | Remove-Item -Recurse -Confirm:$false -ErrorAction Ignore
	Get-ChildItem -Path "$POH_PATH\$OH_DIR\rsc\log4j.properties" | Remove-Item -Recurse -Confirm:$false -ErrorAction Ignore
	Get-ChildItem -Path "$POH_PATH\$OH_DIR\rsc\log4j.properties.old" | Remove-Item -Recurse -Confirm:$false -ErrorAction Ignore
	Get-ChildItem -Path "$POH_PATH\$OH_DIR\rsc\dicom.properties" | Remove-Item -Recurse -Confirm:$false -ErrorAction Ignore
	Get-ChildItem -Path "$POH_PATH\$OH_DIR\rsc\dicom.properties.old" | Remove-Item -Recurse -Confirm:$false -ErrorAction Ignore
	Get-ChildItem -Path "$POH_PATH\$OH_DIR\logs/*" | Remove-Item -Recurse -Confirm:$false -ErrorAction Ignore
}


######## Pre-flight checks

# check user running the script
#if ( $(id -u) -eq 0 ) {
#	write-host "Error - do not run this script as root. Exiting."
#	exit 1
#}

# debug level - set default to INFO
if ( ${DEBUG_LEVEL+x} ) {
	DEBUG_LEVEL="INFO"
}	

######## Environment setup

set_path;
set_language;

######## User input

# list of arguments expected in user the input
$OPTIND=1 # Reset in case getopts has been used previously in the shell.
$OPTSTRING=":h?rcsdCtGDvl:"


function parse_input {

# function to parse input
#
#param ($opt)

param
    (
        [Parameter(Mandatory)]
        [Alias("help")] 
        [string[]]$opt
    )
 
    Get-Content -h $opt
	write-host $param1
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
		$DEBUG_LEVEL="DEBUG"
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
		$OH_DISTRO="portable"
		$DEMO_MODE="on"
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
		default { write-host "Invalid option: -${OPTARG}. See $SCRIPT_NAME -h for help"; exit 1; }
	}
}

######################## Script start ########################

# check distro
if ( ${OH_DISTRO+x} ) {
	write-host "Error - OH_DISTRO not defined [client - portable]! Exiting."
	exit 1
}

# check demo mode

if ( $DEMO_MODE -eq "on" ) {
	if ( Test-Path -Path "$POH_PATH/$SQL_DIR/$DB_DEMO" ) {
	        write-host "Found SQL demo database, starting OH in demo mode..."
		$DB_CREATE_SQL=$DB_DEMO
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

clean_files; # TEMPORARY

######## Database setup

# Start MySQL and create database
if ( $OH_DISTRO -eq "portable" ) {
	# Check for MySQL software
	mysql_check;
	# Config MySQL
	config_database;
	# Check if OH database already exists
	if ( ! (Test-Path -Path "$POH_PATH\$MYSQL_DATA_DIR\$DATABASE_NAME" ) ) {
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
#test_database_connection;

write-host "Setting up OH configuration files..."

######## DICOM setup
#[ -f $POH_PATH/$OH_DIR/rsc/dicom.properties ] && mv -f $POH_PATH/$OH_DIR/rsc/dicom.properties $POH_PATH/$OH_DIR/rsc/dicom.properties.old
#
	
(Get-Content "$POH_PATH/$OH_DIR/rsc/dicom.properties.dist").replace("OH_PATH_SUBSTITUTE","$POH_PATH") | Set-Content "$POH_PATH/$OH_DIR/rsc/dicom.properties"
(Get-Content "$POH_PATH/$OH_DIR/rsc/dicom.properties").replace("DICOM_SIZE","$DICOM_MAX_SIZE") | Set-Content "$POH_PATH/$OH_DIR/rsc/dicom.properties"

######## log4j.properties setup
#[ -f $POH_PATH/$OH_DIR/rsc/log4j.properties ] && mv -f $POH_PATH/$OH_DIR/rsc/log4j.properties $POH_PATH/$OH_DIR/rsc/log4j.properties.old
#sed -e "s/DBPORT/$MYSQL_PORT/" -e "s/DBSERVER/$MYSQL_SERVER/" -e "s/DBUSER/$DATABASE_USER/" -e "s/DBPASS/$DATABASE_PASSWORD/" -e "s/DEBUG_LEVEL/$DEBUG_LEVEL/" $POH_PATH/$OH_DIR/rsc/log4j.properties.dist > $POH_PATH/$OH_DIR/rsc/log4j.properties

(Get-Content "$POH_PATH/$OH_DIR/rsc/log4j.properties.dist").replace("DB_PORT","$MYSQL_PORT") | Set-Content "$POH_PATH/$OH_DIR/rsc/log4j.properties"
(Get-Content "$POH_PATH/$OH_DIR/rsc/log4j.properties").replace("DBSERVER","$MYSQL_SERVER") | Set-Content "$POH_PATH/$OH_DIR/rsc/log4j.properties"
(Get-Content "$POH_PATH/$OH_DIR/rsc/log4j.properties").replace("DBUSER","$DATABASE_USER") | Set-Content "$POH_PATH/$OH_DIR/rsc/log4j.properties"
(Get-Content "$POH_PATH/$OH_DIR/rsc/log4j.properties").replace("DBPASS","$DATABASE_PASSWORD") | Set-Content "$POH_PATH/$OH_DIR/rsc/log4j.properties"
(Get-Content "$POH_PATH/$OH_DIR/rsc/log4j.properties").replace("DEBUG_LEVEL","$DEBUG_LEVE") | Set-Content "$POH_PATH/$OH_DIR/rsc/log4j.properties"

######## database.properties setup 
#[ -f $POH_PATH/$OH_DIR/rsc/database.properties ] && mv -f $POH_PATH/$OH_DIR/rsc/database.properties $POH_PATH/$OH_DIR/rsc/database.properties.old
Set-Content -Path $POH_PATH/$OH_DIR/rsc/database.properties -Value "jdbc.url=jdbc:mysql://{$MYSQL_SERVER}:$MYSQL_PORT/$DATABASE_NAME"
Add-Content -Path $POH_PATH/$OH_DIR/rsc/database.properties -Value "jdbc.username=$DATABASE_USER"
Add-Content -Path $POH_PATH/$OH_DIR/rsc/database.properties -Value "jdbc.password=$DATABASE_PASSWORD"

######## generalData.properties language setup 
# set language in OH config file
#[ -f $POH_PATH/$OH_DIR/rsc/generalData.properties ] && mv -f $POH_PATH/$OH_DIR/rsc/generalData.properties $POH_PATH/$OH_DIR/rsc/generalData.properties.old
(Get-Content "$POH_PATH/$OH_DIR/rsc/generalData.properties.dist").replace("OH_SET_LANGUAGE","$OH_LANGUAGE") | Set-Content "$POH_PATH/$OH_DIR/rsc/generalData.properties"

######## Open Hospital start

write-host "Starting Open Hospital..."

cd $POH_PATH/$OH_DIR

# OH GUI launch
#$JAVA_BIN -Dsun.java2d.dpiaware=false -Djava.library.path=${NATIVE_LIB_PATH} -classpath $OH_CLASSPATH org.isf.menu.gui.Menu 2>&1 > /dev/null
#

write-host "----javabin $JAVA_BIN"
write-host "----native $NATIVE_LIB_PATH"
write-host "----ohclasspath $OH_CLASSPATH"

#Start-Process -FilePath "$JAVA_BIN" -ArgumentList ("-Dsun.java2d.dpiaware=false -Djava.library.path=${NATIVE_LIB_PATH} -classpath $OH_CLASSPATH org.isf.menu.gui.Menu")
#Start-Process -FilePath "$JAVA_BIN" -ArgumentList ("-h") -Wait -NoNewWindow

Start-Process -FilePath "$JAVA_BIN" -ArgumentList ("-Dlog4j.configuration=$POH_PATH/oh/rsc/log4j.properties -Dsun.java2d.dpiaware=false -Djava.library.path=$NATIVE_LIB_PATH -classpath $OH_CLASSPATH org.isf.menu.gui.Menu") -Wait -NoNewWindow

#%OH_PATH%\%JAVA_DIR%\bin\java.exe -Dlog4j.configuration=%OH_PATH%oh/rsc/log4j.properties -showversion -Dsun.java2d.dpiaware=false -Djava.library.path=%OH_PATH%oh\lib\native\Windows -cp %CLASSPATH% org.isf.menu.gui.Menu


write-host "Exiting Open Hospital..."

if ( $OH_DISTRO -eq "portable" ) {
	shutdown_database;
}

# go back to starting directory
cd $CURRENT_DIR

# exiting
write-host "Done!"
exit 0
