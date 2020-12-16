#%SystemRoot%\system32\WindowsPowerShell\v1.0\powershell.exe
#
#!/snap/bin/pwsh
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
# OH_PATH is the directory where Portable OpenHospital files are located
# OH_PATH=/usr/local/PortableOpenHospital

param (
    [Parameter(Mandatory=$true)][string]$opt
)

write-output $opt

$script:OH_DISTRO="portable"  # set distro to portable | client
$script:DEMO_MODE="off"

# Language setting - default set to en
#$script:OH_LANGUAGE=en fr es it pt
#$script:OH_LANGUAGE=it

# set debug level to INFO | DEBUG - default set to INFO
#$script:DEBUG_LEVEL=INFO

######## Software configuration - change at your own risk :-)
# Database
$script:MYSQL_SERVER=localhost
$script:MYSQL_PORT=3305
$script:MYSQL_ROOT_PW="root123"
$script:DATABASE_NAME=oh
$script:DATABASE_USER=isf
$script:DATABASE_PASSWORD="isf123"

$script:DICOM_MAX_SIZE="4M"

$script:OH_DIR=oh
$script:SQL_DIR=sql
$script:DATA_DIR="data/db"
$script:DICOM_DIR="data/dicom_storage"
$script:LOG_DIR="data/log"
$script:RUN_DIR=tmp
$script:BACKUP_DIR=sql

$script:DB_DEMO="create_all_demo.sql"
# date +%Y-%m-%d_%H-%M-%S
$script:DATE= Get-Date -Format "yyyy-MM-dd_HH-mm-ss"

######## Advanced options
## set MANUAL_CONFIG to "on" to setup configuration files manually
# my.cnf and all oh/rsc/*.properties files will not be generated or
# overwritten if already present
$script:MANUAL_CONFIG=off

######## Define architecture

$script:ARCH=$env:PROCESSOR_ARCHITECTURE

switch ( "$ARCH" ) {	
    "amd64" { $script:JAVA_ARCH=64; }
    "AMD64" { $script:JAVA_ARCH=64; }
    "x86_64" { $script:JAVA_ARCH=64; }
    ("486","586","686","x86","i86pc") { $script:JAVA_ARCH=64; }
	default {
	    write-host "Unknown architecture: $ARCH. Exiting."
		exit 1
	}
}
		write-host " architecture: $ARCH.."
		write-host " JAVA AR: $JAVA_ARCH. Exiting."
######## MySQL Software
# MariaDB
$script:MYSQL_URL="http://ftp.bme.hu/pub/mirrors/mariadb/mariadb-10.2.36/winx64-packages/"
$script:MYSQL_DIR="mariadb-10.2.36-winx64"
# MySQL
#MYSQL_DIR="mysql-5.7.30-linux-glibc2.12-$ARCH"
#MYSQL_URL="https://downloads.mysql.com/archives/get/p/23/file"
$script:EXT="zip"

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

$script:JAVA_URL="https://github.com/AdoptOpenJDK/openjdk11-binaries/releases/download/jdk-11.0.9.1%2B1/"
$script:JAVA_DISTRO="OpenJDK11U-jre_x64_windows_hotspot_11.0.9.1_1"
$script:JAVA_DIR="jdk-11.0.9.1+1-jre"


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
$script:SCRIPT_DIR = Split-Path $script:MyInvocation.MyCommand.Path
$script:SCRIPT_NAME = $MyInvocation.MyCommand.Name
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

################################################## SISTEMAREEEEEEEEEEEEEEE
	$script:CURRENT_DIR=Get-Location | select -ExpandProperty Path
	# set OH_PATH if not defined
	if ( ! $OH_OPATH ) {
		write-host "Warning: OH_PATH not found - using current directory"
		$script:OH_PATH=$CURRENT_DIR
		if ( ! (Test-Path "$OH_OPATH\$SCRIPT_NAME") ) {
			write-host "Error - $SCRIPT_NAME not found in the current PATH. Please cd the directory where POH was unzipped or set up OH_PATH properly." -ForegroundColor Yellow
			exit 1
		}
	}
#	$OH_OPATH_ESCAPED=$(write-host $OH_OPATH | sed -e 's/\//\\\//g'")
#	$OH_OPATH_ESCAPED=$OH_OPATH
}

function set_language {
	# Set OH interface languange - set default to en
	if ( ! $OH_LANGUAGE ) {
		$script:OH_LANGUAGE="en"
	}	
	switch ( "$OH_LANGUAGE" ) {
		{"en","fr","it","es","pt"} {
			# set database creation script in chosen language
			$script:DB_CREATE_SQL="create_all_$OH_LANGUAGE.sql"
            break
        }
    default {
        write-host "Invalid option: $OH_LANGUAGE. Exiting."
	    exit 1
        }
    }
}

function java_lib_setup {
	# NATIVE LIB setup
	switch ( "$JAVA_ARCH" ) {
		"64" { $script:NATIVE_LIB_PATH="$OH_OPATH\$OH_DIR\lib\native\Win64" }
		"32" { $script:NATIVE_LIB_PATH="$OH_OPATH\$OH_DIR\lib\native\Windows" }
	}

	# CLASSPATH setup


#FOR %%A IN (%OH_LIB%\*.jar) DO (
#        set CLASSPATH=!CLASSPATH!;%%A
#)

	$script:DIRLIBS="$OH_OPATH\$OH_DIR\lib"

#	for i in ${DIRLIBS}
#	gci -file -r *.pdf

	#foreach ( $i in ${DIRLIBS} ) {
	#	$OH_CLASSPATH="{$OH_CLASSPATH};{$i}"
	#	write-host "---------$OH_CLASSPATH"
	#}

    #SETLOCAL ENABLEDELAYEDEXPANSION

    #$list = Get-ChildItem -Path "$OH_OPATH\$OH_DIR\lib" -Recurse | % { $_.FullName } `
    $jarlist = Get-ChildItem -Path "$OH_OPATH\$OH_DIR\lib" | % { $_.FullName } `
        #Where-Object { $_.PSIsContainer -eq $false -and $_.Extension -eq '.jar' }
        Where-Object { $_.Extension -eq '.jar' }
        ForEach($n in $jarlist){
        $script:OH_CLASSPATH="$OH_CLASSPATH;$n"
        # $n.Name | Out-File -Append 'D:\Movielist.txt'
}
	#$script:OH_CLASSPATH="$OH_OPATH/$OH_DIR\bin\OH-gui.jar"
	$script:OH_CLASSPATH="$OH_CLASSPATH;$OH_OPATH\$OH_DIR\bin\OH-gui.jar"
	$script:OH_CLASSPATH="$OH_CLASSPATH;$OH_OPATH\$OH_DIR\bundle\"
	$script:OH_CLASSPATH="$OH_CLASSPATH;$OH_OPATH\$OH_DIR\rpt\"
	$script:OH_CLASSPATH="$OH_CLASSPATH;$OH_OPATH\$OH_DIR\rsc\"
    $script:OH_CLASSPATH="$OH_CLASSPATH;$OH_OPATH\$OH_DIR\lib\"
    #$script:OH_CLASSPATH="$OH_CLASSPATH;$OH_OPATH\$OH_DIR\bin\*"

}

function download_file ($download_url,$download_file){
write-host "Downloading $download_file from $download_url..."
    try {
        $wc = new-object System.Net.WebClient
        $wc.DownloadFile("$download_url\$download_file","$OH_OPATH\$download_file")
    }
    catch [System.Net.WebException],[System.IO.IOException] {
        "Unable to download $download_file from $download_url"
        exit 1;
    }
    catch {
        "An error occurred. Exiting."
        exit 1;
    }
}

function java_check {
    if ( !( $JAVA_BIN ) ) {
	    $script:JAVA_BIN="$OH_OPATH\$JAVA_DIR\bin\java.exe"
    }

    if ( !( Test-Path $JAVA_BIN ) ) {
        if ( !(Test-Path "$OH_OPATH\$JAVA_DISTRO.$EXT") ) {
    		write-host "Warning - JAVA not found. Do you want to download it? (50 MB)" -ForegroundColor Yellow
		    get_confirmation;
		    # Downloading openjdk binaries
            download_file "$JAVA_URL" "$JAVA_DISTRO.$EXT"
	    }
	    write-host "Unpacking $JAVA_DISTRO..."
        try {
            Expand-Archive "$OH_OPATH\$JAVA_DISTRO.$EXT" -DestinationPath $OH_OPATH\ -Force
        }
        catch {
            write-host "Error unpacking Java. Exiting." -ForegroundColor Red
		    exit 1
	    }
        write-host "Java unpacked successfully!"
    }
    # check for java binary
    if ( Test-Path "$OH_OPATH\$JAVA_DIR\bin\java.exe" ) {
        $script:JAVA_BIN="$OH_OPATH\$JAVA_DIR\bin\java.exe"
    }
    else {
        write-host "Error: JAVA not found. Exiting." -ForegroundColor Red
        exit 1
    }
    write-host "JAVA found!"
    write-host "Using $JAVA_BIN"
}

function mysql_check {
	if (  !( Test-Path "$OH_OPATH\$MYSQL_DIR" ) ) {
		if ( !( Test-Path "$OH_OPATH\$MYSQL_DIR.$EXT" ) ) {
			write-host "Warning - MySQL not found. Do you want to download it? (630 MB)" -ForegroundColor Yellow
			get_confirmation;
			# Downloading mysql binary
            download_file "$MYSQL_URL" "$MYSQL_DIR.$EXT" 
		}
		write-host "Unpacking $MYSQL_DIR..."
        try {
            Expand-Archive "$OH_OPATH\$MYSQL_DIR.$EXT" -DestinationPath $OH_OPATH\ -Force
        }
        catch {
			write-host "Error unpacking MySQL. Exiting." -ForegroundColor Red
			exit 1
		}
        write-host "MySQL unpacked successfully!"
    }
    # check for mysql binary
    if (Test-Path "$OH_OPATH\$MYSQL_DIR\bin\mysqld.exe") {
        write-host "MySQL found!"
	    write-host "Using $MYSQL_DIR"
	}
	else {
		write-host "Error: MySQL not found. Exiting." -ForegroundColor Red
		exit 1
	}
}

function config_database {
	# Find a free TCP port to run MySQL starting from the default port
	write-host "Looking for a free TCP port for MySQL database..."
#	while ( $(ss -tna | awk '{ print $4 }' | grep ":$MYSQL_PORT") ); do
#		MYSQL_PORT=$(expr $MYSQL_PORT + 1)
#	done
	$script:MYSQL_PORT=$($MYSQL_PORT + 1)
	write-host "Found TCP port $MYSQL_PORT!"

	# Creating MySQL configuration
	write-host "Generating MySQL config file..."
#	[ if Test-Path $OH_OPATH/etc/mysql/my.cnf ] && mv -f $OH_OPATH/etc/mysql/my.cnf $OH_OPATH/etc/mysql/my.cnf.old
	(Get-Content "$OH_OPATH/etc/mysql/my.cnf.dist").replace("DICOM_SIZE","$DICOM_MAX_SIZE") | Set-Content "$OH_OPATH/etc/mysql/my.cnf"
	(Get-Content "$OH_OPATH/etc/mysql/my.cnf").replace("OH_PATH_SUBSTITUTE","$OH_OPATH") | Set-Content "$OH_OPATH/etc/mysql/my.cnf"
	(Get-Content "$OH_OPATH/etc/mysql/my.cnf").replace("MYSQL_SERVER","$MYSQL_SERVER") | Set-Content "$OH_OPATH/etc/mysql/my.cnf"
	(Get-Content "$OH_OPATH/etc/mysql/my.cnf").replace("MYSQL_PORT","$MYSQL_PORT") | Set-Content "$OH_OPATH/etc/mysql/my.cnf"
	(Get-Content "$OH_OPATH/etc/mysql/my.cnf").replace("MYSQL_DISTRO","$MYSQL_DIR") | Set-Content "$OH_OPATH/etc/mysql/my.cnf"
	(Get-Content "$OH_OPATH/etc/mysql/my.cnf").replace("DATA_DIR","$DATA_DIR") | Set-Content "$OH_OPATH/etc/mysql/my.cnf"
	(Get-Content "$OH_OPATH/etc/mysql/my.cnf").replace("RUN_DIR","$RUN_DIR") | Set-Content "$OH_OPATH/etc/mysql/my.cnf"
	(Get-Content "$OH_OPATH/etc/mysql/my.cnf").replace("LOG_DIR","$LOG_DIR") | Set-Content "$OH_OPATH/etc/mysql/my.cnf"

#	sed -e "s/DICOM_SIZE/$DICOM_MAX_SIZE/g" -e "s/OH_PATH_SUBSTITUTE/$OH_OPATH_ESCAPED/g" -e "s/MYSQL_PORT/$MYSQL_PORT/" -e "s/MYSQL_DISTRO/$MYSQL_DIR/g" $OH_OPATH/etc/mysql/my.cnf.dist > $OH_OPATH/etc/mysql/my.cnf
}

function inizialize_database {
	# Recreate directory structure
	mkdir -p $OH_OPATH/$DATA_DIR
	mkdir -p $OH_OPATH/$RUN_DIR
	mkdir -p $OH_OPATH/$LOG_DIR
	mkdir -p $OH_OPATH/$DICOM_DIR
	mkdir -p $OH_OPATH/$BACKUP_DIR
    # Inizialize MySQL
	write-host "Initializing MySQL database on port $MYSQL_PORT..."
	switch -Regex ( $MYSQL_DIR ) {
		"mariadb" {
		write-host "MARIADB"
		#Start-Process -FilePath "$OH_OPATH\$MYSQL_DIR\bin\mysql_install_db.exe" -ArgumentList ("--datadir=$OH_OPATH\$MYSQL_DATA_DIR --auth-root-authentication-method=normal") -Wait -NoNewWindow  -RedirectStandardOutput '.\console1.out' -RedirectStandardError '.\console1.err'
		Start-Process -FilePath "$OH_OPATH\$MYSQL_DIR\bin\mysql_install_db.exe" -ArgumentList ("--datadir=$OH_OPATH\$DATA_DIR --password=$MYSQL_ROOT_PW") -Wait -NoNewWindow  -RedirectStandardOutput '.\console1.out' -RedirectStandardError '.\console1.err'			


#Start-Process -FilePath "$OH_OPATH\$MYSQL_DIR\bin\mysql_install_db.exe" -ArgumentList ("--datadir=$OH_OPATH\$DATA_DIR --password=$MYSQL_ROOT_PW") -Wait #
        	}
		"mysql" {
		write-host "MYSQL"
			Start-Process "$OH_OPATH\$MYSQL_DIR\bin\mysqld.exe" -ArgumentList ("--initialize-insecure --basedir=$OH_OPATH\$MYSQL_DIR --datadir=$OH_OPATH\$DATA_DIR") -NoNewWindow; break
		}
	}

#	if ( $? -ne 0 ){
#		write-host "Error: MySQL initialization failed! Exiting." -ForegroundColor Red
#		exit 2
#	}
}

function start_database {
	write-host "Starting MySQL server... "
#	"$OH_OPATH/$MYSQL_DIR/bin/mysqld_safe --defaults-file=$OH_OPATH\etc\mysql\my.cnf"

    #Start-Process -FilePath "$OH_OPATH\$MYSQL_DIR\bin\mysqld.exe" -ArgumentList ("--defaults-file=$OH_OPATH\etc\mysql\my.cnf --tmpdir=$OH_OPATH\tmp --standalone --console") -RedirectStandardOutput '.\console.out' -RedirectStandardError '.\console2.err'
	Start-Process -FilePath "$OH_OPATH\$MYSQL_DIR\bin\mysqld.exe" -ArgumentList ("--defaults-file=$OH_OPATH\etc\mysql\my.cnf --tmpdir=$OH_OPATH\tmp --standalone") -RedirectStandardOutput '.\console2.out' -RedirectStandardError '.\console2.err'
    sleep 2;

#	 Start-Process java -ArgumentList '-jar', 'MyProgram.jar' ` -RedirectStandardOutput '.\console.out' -RedirectStandardError '.\console3.err'
	 #start /b /min %OH_PATH%\%MYSQL_DIR%\bin\mysqld --tmpdir=%OH_PATH%\tmp --standalone --console --log_syslog=0
#	 %OH_PATH%\%MYSQL_DIR%\bin\mysqld --tmpdir=%OH_PATH%\tmp --standalone --console --log_syslog=0

#	if ( $? -ne 0 ) {
#		write-host "Error: Database not started! Exiting." -ForegroundColor Red
#		exit 2
#	}

	# Wait till the MySQL socket file is created
	# while ( -e $OH_OPATH/$MYSQL_SOCKET ); do sleep 1; done
	# # Wait till the MySQL tcp port is open
	# until nc -z $MYSQL_SERVER $MYSQL_PORT; do sleep 1; done
	write-host "MySQL server started! "
}

function set_database_root_pw {
     # If using MySQL root password need to be set
     switch -Regex ( $MYSQL_DIR ) {
		"mysql" {
            echo "Setting MySQL root password..."
        $SQLCOMMAND=@"
        -u root --skip-password -h $MYSQL_SERVER --port=$MYSQL_PORT --protocol=tcp -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PW';"
"@
        Start-Process -FilePath "$OH_OPATH/$MYSQL_DIR/bin/mysql.exe" -ArgumentList ("$SQLCOMMAND") -Wait -NoNewWindow  -RedirectStandardOutput '.\consolePW.out' -RedirectStandardError '.\consolePW.err'
        }
    }
}


function import_database {
	write-host "Creating OH Database..."
	# Create OH database and user
	
    #$script:SQL_CREATE="CREATE DATABASE $DATABASE_NAME; `

    #Start-Process -FilePath "$OH_OPATH\$MYSQL_DIR\bin\mysql.exe" -ArgumentList ("-u root -p$MYSQL_ROOT_PW -h $MYSQL_SERVER --port $MYSQL_PORT -e ""CREATE DATABASE $DATABASE_NAME; `
	#CREATE USER \'$DATABASE_USER\'@\'localhost\' IDENTIFIED BY \'$DATABASE_PASSWORD\'; `
	#CREATE USER \'$DATABASE_USER\'\@\'\%\' IDENTIFIED BY \'$DATABASE_PASSWORD\'; GRANT ALL PRIVILEGES ON $DATABASE_NAME.* TO \'$DATABASE_USER\'@\'localhost\'; `
	#GRANT ALL PRIVILEGES ON $DATABASE_NAME.* TO \'$DATABASE_USER\'\@\'\%\' ;")  -NoNewWindow -Wait -RedirectStandardOutput '.\console3.out' -RedirectStandardError '.\console3.err'
    
    $SQLCOMMAND=@"
    -u root -p$MYSQL_ROOT_PW -h $MYSQL_SERVER --port=$MYSQL_PORT --protocol=tcp -e "CREATE DATABASE $DATABASE_NAME; CREATE USER '$DATABASE_USER'@'localhost' IDENTIFIED BY '$DATABASE_PASSWORD'; CREATE USER '$DATABASE_USER'@'%' IDENTIFIED BY '$DATABASE_PASSWORD'; GRANT ALL PRIVILEGES ON $DATABASE_NAME.* TO '$DATABASE_USER'@'localhost'; GRANT ALL PRIVILEGES ON $DATABASE_NAME.* TO '$DATABASE_USER'@'%';"
"@
    Start-Process -FilePath "$OH_OPATH\$MYSQL_DIR\bin\mysql.exe" -ArgumentList ("$SQLCOMMAND") -NoNewWindow -Wait -RedirectStandardOutput '.\console3.out' -RedirectStandardError '.\console3.err'
    
    # Check for database creation script
    if ( Test-Path "$OH_OPATH\$SQL_DIR\$DB_CREATE_SQL" ) {
                Write-Host "Using SQL file $SQL_DIR\$DB_CREATE_SQL..."
                }
        else {
                Write-Host "No SQL file found! Exiting."
                shutdown_database;
                exit 2
        }

	# Create OH database structure
	write-host "Importing database schema $DB_CREATE_SQL..."
	
    cd $OH_OPATH\$SQL_DIR

    $SQLCOMMAND=@"
   --local-infile=1 -u root -p$MYSQL_ROOT_PW -h $MYSQL_SERVER --port=$MYSQL_PORT --protocol=tcp $DATABASE_NAME -e "source $OH_OPATH\$SQL_DIR\$DB_CREATE_SQL"
"@
    Start-Process -FilePath "$OH_OPATH\$MYSQL_DIR\bin\mysql.exe" -ArgumentList ("$SQLCOMMAND") -NoNewWindow -Wait -RedirectStandardOutput '.\console4.out' -RedirectStandardError '.\console4.err'
 
	write-host "Database imported!"
}

function dump_database {
	# Save OH database if existing
	if ( ( Test-Path "$OH_OPATH\$MYSQL_DIR\bin\mysqldump.exe" )) {
		write-host "Dumping MySQL database..."	
        $SQLCOMMAND=@"
    --skip-extended-insert -u root --password=$MYSQL_ROOT_PW -h $MYSQL_SERVER --port=$MYSQL_PORT --protocol=tcp $DATABASE_NaAME
"@
        Start-Process -FilePath "$OH_OPATH\$MYSQL_DIR\bin\mysqldump.exe" -ArgumentList ("$SQLCOMMAND") -RedirectStandardOutput "$OH_OPATH\$BACKUP_DIR\mysqldump_$DATE.sql"-NoNewWindow -Wait	
    }
    else {
	    write-host "Error: No mysqldump utility found! Exiting." -ForegroundColor Red
	    shutdown_database;
	    exit 2
    }
	write-host "MySQL dump file $BACKUP_DIR\mysqldump_$DATE.sql completed!"-ForegroundColor Green
}

function shutdown_database {
	write-host "Shutting down MySQL..."
	Start-Process -FilePath "$OH_OPATH\$MYSQL_DIR\bin\mysqladmin.exe" -ArgumentList ("-u root -p$MYSQL_ROOT_PW --host=$MYSQL_SERVER --port=$MYSQL_PORT --protocol=tcp shutdown") -NoNewWindow -Wait -RedirectStandardOutput '$OH_OPATH\console5.out' -RedirectStandardError '$OH_OPATH\console5.err'
	# Wait till the MySQL socket file is removed
#	while ( -e $OH_OPATH/$MYSQL_SOCKET ); do sleep 1; done
}

function clean_database {
	write-host "Warning: do you want to remove all data and database ?"
    get_confirmation;
    write-host "Killing mysql processes..."
    # stop mysqld zombies
    Get-Process mysqld -ErrorAction SilentlyContinue | Stop-Process -PassThru
	write-host "Removing data..."
	# remove databases
	$filetodel="$OH_OPATH\$DATA_DIR\*"; if (Test-Path $filetodel) { Remove-Item $filetodel -Recurse -Confirm:$false -ErrorAction Ignore }
	$filetodel="$OH_OPATH\$RUN_DIR\*"; if (Test-Path $filetodel) { Remove-Item $filetodel -Recurse -Confirm:$false -ErrorAction Ignore }
}

function test_database_connection {
	# Test connection to the OH MySQL database
	write-host "Testing database connection..."
    try {
	    Start-Process -FilePath ("$OH_OPATH\$MYSQL_DIR\bin\mysql.exe") -ArgumentList ("--host=$MYSQL_SERVER --port=$MYSQL_PORT --user=$DATABASE_USER --password=$DATABASE_PASSWORD --protocol=tcp -e USE $DATABASE_NAME;" ) -Wait -NoNewWindow
        write-host "Database connection successfully established!"
	}
    catch {
        Write-Host "Error: can't connect to database! Exiting." -ForegroundColor Red
	    exit 2
	}
}

function clean_files {
	# clean all generated files - leave only .dist files
	write-host "Warning: do you want to remove all configuration and log files ?"
	get_confirmation;
	write-host "Removing files..."

    $filetodel="$OH_OPATH\etc\mysql\my.cnf"; if (Test-Path $filetodel){ Remove-Item $filetodel -Recurse -Confirm:$false -ErrorAction Ignore }
	$filetodel="$OH_OPATH\etc\mysql\my.cnf.old"; if (Test-Path $filetodel) { Remove-Item $filetodel -Recurse -Confirm:$false -ErrorAction Ignore }
	$filetodel="$OH_OPATH\$LOG_DIR\*"; if (Test-Path $filetodel) { Remove-Item $filetodel -Recurse -Confirm:$false -ErrorAction Ignore }
	$filetodel="$OH_OPATH\$OH_DIR\rsc\generalData.properties"; if (Test-Path $filetodel) { Remove-Item $filetodel -Recurse -Confirm:$false -ErrorAction Ignore }
	$filetodel="$OH_OPATH\$OH_DIR\rsc\generalData.properties.old"; if (Test-Path $filetodel) { Remove-Item $filetodel -Recurse -Confirm:$false -ErrorAction Ignore }
	$filetodel="$OH_OPATH\$OH_DIR\rsc\database.properties"; if (Test-Path $filetodel) { Remove-Item $filetodel -Recurse -Confirm:$false -ErrorAction Ignore }
	$filetodel="$OH_OPATH\$OH_DIR\rsc\database.properties.old"; if (Test-Path $filetodel) { Remove-Item $filetodel -Recurse -Confirm:$false -ErrorAction Ignore }
	$filetodel="$OH_OPATH\$OH_DIR\rsc\log4j.properties"; if (Test-Path $filetodel) { Remove-Item $filetodel -Recurse -Confirm:$false -ErrorAction Ignore }
	$filetodel="$OH_OPATH\$OH_DIR\rsc\log4j.properties.old"; if (Test-Path $filetodel) { Remove-Item $filetodel -Recurse -Confirm:$false -ErrorAction Ignore }
	$filetodel="$OH_OPATH\$OH_DIR\rsc\dicom.properties"; if (Test-Path $filetodel) { Remove-Item $filetodel -Recurse -Confirm:$false -ErrorAction Ignore }
	$filetodel="$OH_OPATH\$OH_DIR\rsc\dicom.properties.old"; if (Test-Path $filetodel) { Remove-Item $filetodel -Recurse -Confirm:$false -ErrorAction Ignore }
	$filetodel="$OH_OPATH\$OH_DIR\logs\*"; if (Test-Path $filetodel) { Remove-Item $filetodel -Recurse -Confirm:$false -ErrorAction Ignore }
}


######## Pre-flight checks

# check user running the script
#if ( $(id -u) -eq 0 ) {
#	write-host "Error - do not run this script as root. Exiting."
#	exit 1
#}

# debug level - set default to INFO
if ( $DEBUG_LEVEL -ne $null ) {
	$script:DEBUG_LEVEL="INFO"
}	
######## Environment setup

set_path;
set_language;

######## User input

# list of arguments expected in user the input
#$OPTIND=1 # Reset in case getopts has been used previously in the shell.
#$OPTSTRING=":h?rcsdCtGDvl:"


# parse_input 

# function to parse input
#
#param ($opt)
#param
#    (
#        [Parameter(Mandatory)]
#        [Alias("help")] 
#        [string[]]$opt
#    )
 
    #Get-Content -h $opt
	#write-host "OOOOOOOOOOOOO $opt"
switch ( "$opt" ) {
	"h"	{ # help
        script_usage; 
		}
	"r"	{ # restore
       	write-host "Restoring Portable Open Hospital database...."
		clean_database;
		# ask user for database to restore
		$DB_CREATE_SQL = Read-Host -Prompt "Enter SQL dump/backup file that you want to restore - (in sql/ subdirectory) -> "
		if ( Test-Path "$OH_OPATH\$SQL_DIR\$DB_CREATE_SQL" ) {
		        write-host "Found $SQL_DIR\$DB_CREATE_SQL, restoring it..."
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
        Write-host "$OH_OPATH\$DATA_DIR\$DATABASE_NAME"
		if ( Test-Path "$OH_OPATH\$DATA_DIR\$DATABASE_NAME" ) {
			mysql_check;
			if ($MANUAL_CONFIG != on ) {
				config_database;
			}
			start_database;
        	write-host "Saving Portable Open Hospital database..."
			dump_database;
			shutdown_database;
        	write-host "Done!"
			exit 0
		}
		else {
	        	write-host "Error: no data found! Exiting." -ForegroundColor Red
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
		if ( $OH_DISTRO -eq "portable" ) {
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
		cd $OH_OPATH\$OH_DIR
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

#        Get-Content $OH_OPATH\$OH_DIR\rsc\version.properties | Where-Object {$_.length -gt 0} | Where-Object {!$_.StartsWith("#")} | ForEach-Object {
#        $var = $_.Split('=',2).Trim()
#        New-Variable -Scope Script -Name $var[0] -Value $var[1]
#        }
        #write-host "Open Hospital version" $VER_MAJOR.$VER_MINOR.$VER_RELEASE
        #write-host "Open Hospital version" $var[1] $var[3] $var[]

        write-host "MySQL version: $MYSQL_DIR"
        write-host "JAVA version:"
		write-host "$JAVA_DISTRO"
		exit 0
		}
	"a"	# test option to go on
		{ write-host "Going forward..."
        }
#	"?"	# default
		default { write-host "Invalid option: -${OPTARG}. See $SCRIPT_NAME -h for help"; exit 1; }
}


######################## Script start ########################

# check distro
if ( !( $OH_DISTRO -eq "portable" ) -And !( $OH_DISTRO -eq "client" ) ) {
	write-host "Error - OH_DISTRO not defined [client - portable]! Exiting." -ForegroundColor Red
	exit 1
}

# check demo mode

if ( $DEMO_MODE -eq "on" ) {
	if ( Test-Path -Path "$OH_OPATH\$SQL_DIR\$DB_DEMO" ) {
	        write-host "Found SQL demo database, starting OH in demo mode..."
		$DB_CREATE_SQL=$DB_DEMO
	}
	else {
	      	write-host "Error: no $DB_DEMO found! Exiting." -ForegroundColor Red
		exit 1
	}
}

write-host "Starting Open Hospital in $OH_DISTRO mode..."
write-host "OH_PATH set to $OH_OPATH"
write-host "POH language is set to $OH_LANGUAGE"

# check for java
java_check;

# setup java lib
java_lib_setup;

#clean_files; # TEMPORARY

######## Database setup

# Start MySQL and create database
if ( $OH_DISTRO -eq "portable" ) {
	# Check for MySQL software
	mysql_check;
	# Config MySQL
	config_database;
	# Check if OH database already exists
	if ( ! (Test-Path "$OH_OPATH\$DATA_DIR\$DATABASE_NAME" ) ) {
		# Prepare MySQL
		inizialize_database;
		# Start MySQL
        start_database;	
        # Set database root password
        set_database_root_pw;
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

if ($MANUAL_CONFIG != on ) {
write-host "Setting up OH configuration files..."

######## DICOM setup
#[ if Test-Path -Path $OH_OPATH/$OH_DIR/rsc/dicom.properties ] && mv -f $OH_OPATH/$OH_DIR/rsc/dicom.properties $OH_OPATH/$OH_DIR/rsc/dicom.properties.old
#
	
(Get-Content "$OH_OPATH/$OH_DIR/rsc/dicom.properties.dist").replace("OH_PATH_SUBSTITUTE","$OH_OPATH") | Set-Content "$OH_OPATH/$OH_DIR/rsc/dicom.properties"
(Get-Content "$OH_OPATH/$OH_DIR/rsc/dicom.properties").replace("DICOM_DIR","$DICOM_DIR") | Set-Content "$OH_OPATH/$OH_DIR/rsc/dicom.properties"
(Get-Content "$OH_OPATH/$OH_DIR/rsc/dicom.properties").replace("DICOM_SIZE","$DICOM_MAX_SIZE") | Set-Content "$OH_OPATH/$OH_DIR/rsc/dicom.properties"

######## log4j.properties setup
#[ if Test-Path -Path  $OH_OPATH/$OH_DIR/rsc/log4j.properties ] && mv -f $OH_OPATH/$OH_DIR/rsc/log4j.properties $OH_OPATH/$OH_DIR/rsc/log4j.properties.old
#sed -e "s/DBPORT/$MYSQL_PORT/" -e "s/DBSERVER/$MYSQL_SERVER/" -e "s/DBUSER/$DATABASE_USER/" -e "s/DBPASS/$DATABASE_PASSWORD/" -e "s/DEBUG_LEVEL/$DEBUG_LEVEL/" $OH_OPATH/$OH_DIR/rsc/log4j.properties.dist > $OH_OPATH/$OH_DIR/rsc/log4j.properties

(Get-Content "$OH_OPATH/$OH_DIR/rsc/log4j.properties.dist").replace("DBSERVER","$MYSQL_SERVER") | Set-Content "$OH_OPATH/$OH_DIR/rsc/log4j.properties"
(Get-Content "$OH_OPATH/$OH_DIR/rsc/log4j.properties").replace("DBPORT","$MYSQL_PORT") | Set-Content "$OH_OPATH/$OH_DIR/rsc/log4j.properties"
(Get-Content "$OH_OPATH/$OH_DIR/rsc/log4j.properties").replace("DBUSER","$DATABASE_USER") | Set-Content "$OH_OPATH/$OH_DIR/rsc/log4j.properties"
(Get-Content "$OH_OPATH/$OH_DIR/rsc/log4j.properties").replace("DBPASS","$DATABASE_PASSWORD") | Set-Content "$OH_OPATH/$OH_DIR/rsc/log4j.properties"
(Get-Content "$OH_OPATH/$OH_DIR/rsc/log4j.properties").replace("DEBUG_LEVEL","$DEBUG_LEVE") | Set-Content "$OH_OPATH/$OH_DIR/rsc/log4j.properties"

######## database.properties setup 
#[ if Test-Path -Path  $OH_OPATH/$OH_DIR/rsc/database.properties ] && mv -f $OH_OPATH/$OH_DIR/rsc/database.properties $OH_OPATH/$OH_DIR/rsc/database.properties.old
(Get-Content "$OH_OPATH/$OH_DIR/rsc/database.properties.dist").replace("DBSERVER","$MYSQL_SERVER") | Set-Content "$OH_OPATH/$OH_DIR/rsc/database.properties"
(Get-Content "$OH_OPATH/$OH_DIR/rsc/database.properties").replace("DBPORT","$MYSQL_PORT") | Set-Content "$OH_OPATH/$OH_DIR/rsc/database.properties"
(Get-Content "$OH_OPATH/$OH_DIR/rsc/database.properties").replace("DBNAME","$DATABASE_NAME") | Set-Content "$OH_OPATH/$OH_DIR/rsc/database.properties"
(Get-Content "$OH_OPATH/$OH_DIR/rsc/database.properties").replace("DBUSER","$DATABASE_USER") | Set-Content "$OH_OPATH/$OH_DIR/rsc/database.properties"
(Get-Content "$OH_OPATH/$OH_DIR/rsc/database.properties").replace("DBPASS","$DATABASE_PASSWORD") | Set-Content "$OH_OPATH/$OH_DIR/rsc/database.properties"

#Set-Content -Path $OH_OPATH/$OH_DIR/rsc/database.properties -Value "jdbc.url=jdbc:mysql://"$MYSQL_SERVER":$MYSQL_PORT/$DATABASE_NAME"
#Add-Content -Path $OH_OPATH/$OH_DIR/rsc/database.properties -Value "jdbc.username=$DATABASE_USER"
#Add-Content -Path $OH_OPATH/$OH_DIR/rsc/database.properties -Value "jdbc.password=$DATABASE_PASSWORD"

######## generalData.properties language setup 
# set language in OH config file
#[ if Test-Path -Path  $OH_OPATH/$OH_DIR/rsc/generalData.properties ] && mv -f $OH_OPATH/$OH_DIR/rsc/generalData.properties $OH_OPATH/$OH_DIR/rsc/generalData.properties.old
(Get-Content "$OH_OPATH/$OH_DIR/rsc/generalData.properties.dist").replace("OH_SET_LANGUAGE","$OH_LANGUAGE") | Set-Content "$OH_OPATH/$OH_DIR/rsc/generalData.properties"
}

######## Open Hospital start

write-host "Starting Open Hospital..."

cd $OH_OPATH/$OH_DIR

# OH GUI launch
#$JAVA_BIN -Dsun.java2d.dpiaware=false -Djava.library.path=${NATIVE_LIB_PATH} -classpath $OH_CLASSPATH org.isf.menu.gui.Menu 2>&1 > /dev/null
#

#write-host "----javabin $JAVA_BIN"
#write-host "----native $NATIVE_LIB_PATH"
#write-host "----ohclasspath $OH_CLASSPATH"

###Start-Process -FilePath "$JAVA_BIN" -ArgumentList ("-Dsun.java2d.dpiaware=false -Djava.library.path=${NATIVE_LIB_PATH} -classpath $OH_CLASSPATH org.isf.menu.gui.Menu")
####Start-Process -FilePath "$JAVA_BIN" -ArgumentList ("-h") -Wait -NoNewWindow

Start-Process -FilePath "$JAVA_BIN" -ArgumentList ("-Dlog4j.configuration=$OH_OPATH\oh\rsc\log4j.properties -Dsun.java2d.dpiaware=false -Djava.library.path='$NATIVE_LIB_PATH' -cp '$OH_CLASSPATH' org.isf.menu.gui.Menu") -Wait -NoNewWindow

# -RedirectStandardOutput "$OH_OPATH\OH.out" -RedirectStandardError "$OH_OPATH\OH.err"

###%OH_PATH%\%JAVA_DIR%\bin\java.exe -Dlog4j.configuration=%OH_PATH%oh/rsc/log4j.properties -showversion -Dsun.java2d.dpiaware=false -Djava.library.path=%OH_PATH%oh\lib\native\Windows -cp %CLASSPATH% org.isf.menu.gui.Menu

write-host "Exiting Open Hospital..."

if ( $OH_DISTRO -eq "portable" ) {
	shutdown_database;
}

# go back to starting directory
cd $CURRENT_DIR

# exiting
write-host "Done!"
exit 0
