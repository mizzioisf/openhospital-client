REM # Open Hospital (www.open-hospital.org)
REM # Copyright © 2006-2020 Informatici Senza Frontiere (info@informaticisenzafrontiere.org)
REM #
REM # Open Hospital is a free and open source software for healthcare data management.


@echo off
set OH_PATH=%~dps0


REM ### Software configuration - change at your own risk :-)
REM # Database
SET MYSQL_SERVER="127.0.0.1"
SET MYSQL_PORT=3306
SET DATABASE_NAME="oh"
SET DATABASE_USER="isf"
SET DATABASE_PASSWORD="isf123"

SET DICOM_MAX_SIZE="4M"

SET OH_DIR="oh"
SET SQL_DIR="sql"
SET MYSQL_SOCKET="var/run/mysqld/mysql.sock"
SET MYSQL_DATA_DIR="var/lib/mysql/"
REM #DB_CREATE_SQL="create_all_en.sql" # default to create_all_en.sql
SET DB_DEMO="create_all_demo.sql"
SET DATE=`date +%Y-%m-%d_%H-%M-%S`

REM ######## MySQL Software
REM # MariaDB
REM curl http://ftp.bme.hu/pub/mirrors/mariadb/mariadb-10.2.36/winx64-packages/mariadb-10.2.36-winx64.zip -o mariadb-10.2.36-winx64.zip
REM MYSQL_URL="https://downloads.mariadb.com/MariaDB/mariadb-10.2.36/bintar-linux-x86_64"
REM http://ftp.kaist.ac.kr/mysql/Downloads/MySQL-5.7/mysql-5.7.31-winx64.zip

REM set MYSQL_DIR=mariadb-10.2.36-winx64
set MYSQL_DIR=mysql-5.7.31-winx64

REM # MySQL
REM #MYSQL_DIR="mysql-5.7.30-linux-glibc2.12-$ARCH"
REM #MYSQL_URL="https://downloads.mysql.com/archives/get/p/23/file"
REM EXT="tar.gz"


REM ####### JAVA Software
REM ######## JAVA 64bit - default architecture
REM ### JRE 8 - openlogic
REM #JAVA_DISTRO="openlogic-openjdk-jre-8u262-b10-linux-x64"
REM #JAVA_URL="https://builds.openlogic.com/downloadJDK/openlogic-openjdk-jre/8u262-b10/"
REM #JAVA_DIR="openlogic-openjdk-jre-8u262-b10-linux-64"

REM ### JRE 11 - zulu
REM #JAVA_DISTRO="zulu11.43.21-ca-jre11.0.9-linux_x64"
REM #JAVA_URL="https://cdn.azul.com/zulu/bin"
REM #JAVA_DIR="zulu11.43.21-ca-jre11.0.9-linux_x64"

REM ### JRE 11 - openjdk
set JAVA_URL="https://github.com/AdoptOpenJDK/openjdk11-binaries/releases/download/jdk-11.0.9.1%2B1/"
set JAVA_DISTRO="OpenJDK11U-jre_x64_windows_hotspot_11.0.9.1_1"
set JAVA_DIR="jdk-11.0.9.1+1-jre"


set REPLACE_PATH=%OH_PATH%\%MYSQL_DIR%\bin
set freePort=
set startPort=%MYSQL_PORT%

REM setup dicom
FOR /F "tokens=2,2 delims==" %%i IN ('findstr /i "dicom.max.size" %OH_PATH%oh\rsc\dicom.properties.dist') DO (
  set dicom_size=%%i
)
if "%dicom_size%" equ "" (
	set dicom_size=4M
)


REM set mysql port
:SEARCHPORT
netstat -o -n -a | find "LISTENING" | find ":%startPort% " > NUL
if "%ERRORLEVEL%" equ "0" (
  echo "port unavailable %startPort%"
  set /a startPort +=1
  GOTO :SEARCHPORT
) ELSE (
  echo "port available %startPort%"
  set freePort=%startPort%
  GOTO :FOUNDPORT
)

:FOUNDPORT
echo "MySQL will listen on the free port %freePort%"

cd /d %OH_PATH%\oh\rsc
echo f | xcopy dicom.properties.dist dicom.properties /y
%REPLACE_PATH%\replace.exe OH_PATH_SUBSTITUTE %OH_PATH% -- dicom.properties
%REPLACE_PATH%\replace.exe DICOM_SIZE %DICOM_MAX_SIZE% -- dicom.properties
REM %REPLACE_PATH%\replace.exe "^x5c" "^x2f" -- dicom.properties

REM ### SETUP database.properties
REM  database.properties setup 
REM [ -f $OH_PATH/$OH_DIR/rsc/database.properties ] && mv -f $OH_PATH/$OH_DIR/rsc/database.properties $OH_PATH/$OH_DIR/rsc/database.properties.old

echo "jdbc.url=jdbc:mysql://%MYSQL_SERVER%:%MYSQL_PORT%\%DATABASE_NAME%" > %OH_PATH%\oh\rsc\database.properties
echo "jdbc.username=%DATABASE_USER%" >> %OH_PATH%\oh\rsc\database.properties
echo "jdbc.password=%DATABASE_PASSWORD%" >> %OH_PATH%\oh\rsc\database.properties

REM echo f | xcopy database.properties.sample database.properties /y
REM %REPLACE_PATH%\replace.exe MYSQL_PORT %freePort% -- database.properties



echo f | xcopy log4j.properties.dist log4j.properties /y
%REPLACE_PATH%\replace.exe MYSQL_PORT %freePort% -- log4j.properties


:function clean_database
	echo "Warning: do you want to remove all data and database ?"
	REM	get_confirmation;
	echo "Removing data..."
	REM remove databases
	del /s /q %OH_PATH%\%MYSQL_DATA_DIR%\*
	del /s /q %OH_PATH%\var\run\mysqld
	del /s /q %OH_PATH%\tmp
REM EXIT /B 0

REM CALL :clean_database

REM function inizialize_database {
REM # Recreate directory structure

REM	mkdir -p %OH_PATH%\%MYSQL_DATA_DIR%
REM	mkdir -p %OH_PATH%\var\run\mysqld
REM	mkdir -p %OH_PATH%\var\log\mysql

REM	# Inizialize MySQL
REM 	echo "Initializing MySQL database on port $MYSQL_PORT..."
REM 	case "$MYSQL_DIR" in 
REM 		*mysql*)
REM 			$POH_PATH/$MYSQL_DIR/bin/mysqld --initialize-insecure --socket=$POH_PATH/$MYSQL_SOCKET --basedir=$POH_PATH/$MYSQL_DIR --datadir=$POH_PATH/$MYSQL_DATA_DIR 2>&1 > /dev/null
REM 			;;
REM		*mariadb*)
REM 			$POH_PATH/$MYSQL_DIR/scripts/mysql_install_db --socket=$POH_PATH/$MYSQL_SOCKET --basedir="$POH_PATH/$MYSQL_DIR" --datadir="$POH_PATH/$MYSQL_DATA_DIR" \
REM 			--auth-root-authentication-method=normal 2>&1 > /dev/null
REM			;;
REM 	esac
REM
REM
REM	if [ $? -ne 0 ]; then
REM		echo "Error: MySQL initialization failed! Exiting."
REM		exit 2
REM	fi
REM }

cd /d %OH_PATH%
echo f | xcopy %OH_PATH%\etc\mysql\my.cnf.dist %OH_PATH%\etc\mysql\my.cnf /y
%REPLACE_PATH%\replace.exe MYSQL_PORT %freePort% -- %OH_PATH%\etc\mysql\my.cnf
%REPLACE_PATH%\replace.exe MYSQL_PORT %freePort% -- %OH_PATH%\etc\mysql\my.cnf
%REPLACE_PATH%\replace.exe OH_PATH_SUBSTITUTE %OH_PATH% -- %OH_PATH%\etc\mysql\my.cnf
%REPLACE_PATH%\replace.exe MYSQL_DISTRO %MYSQL_DIR% -- %OH_PATH%\etc\mysql\my.cnf
REM %REPLACE_PATH%\replace.exe "^x5c" "^x2f" -- my.cnf 

IF EXIST "%OH_PATH%\sql\create_all_en.sql" (
	echo Initializing database...
REM	%OH_PATH%\%MYSQL_DIR%\bin\mysqld --initialize-insecure --tmpdir=%OH_PATH%\tmp --basedir=%OH_PATH%\%MYSQL_DIR% --datadir=%OH_PATH%\%MYSQL_DATA_DIR% --log_syslog=0

REM
REM %OH_PATH%\%MYSQL_DIR%\scripts\mysql_install_db --socket=%OH_PATH%/%MYSQL_SOCKET% --basedir="%OH_PATH%\%MYSQL_DIR" --datadir="%OH_PATH%\%MYSQL_DATA_DIR%" --auth-root-authentication-method=normal


  IF ERRORLEVEL 1 (goto END)
  start /b /min %OH_PATH%\%MYSQL_DIR%\bin\mysqld.exe --defaults-file=%OH_PATH%\etc\mysql\my.cnf --tmpdir=%OH_PATH%\tmp --standalone --console --log_syslog=0
  %OH_PATH%\%MYSQL_DIR%\bin\mysql.exe -u root --port=%freePort% -e "CREATE SCHEMA oh; GRANT ALL ON oh.* TO 'isf'@'localhost' IDENTIFIED BY 'isf123'; GRANT ALL ON oh.* TO 'isf'@'%' IDENTIFIED BY 'isf123';"
  cd %OH_PATH%\sql
  %OH_PATH%\%MYSQL_DIR%\bin\mysql.exe -u root --port=%freePort% oh < "%OH_PATH%\sql\create_all_en.sql"
  IF ERRORLEVEL 1 (goto END)
  echo Database initialized.
REM 
REM DEL %OH_PATH%\sql\create_all_en.sql
) ELSE (
  echo "Missing sql database creation script or Database already initialized"
  start /b /min %OH_PATH%\%MYSQL_DIR%\bin\mysqld --tmpdir=%OH_PATH%\tmp --standalone --console --basedir=%OH_PATH%\%MYSQL_DIR% --datadir=%OH_PATH%\%MYSQL_DATA_DIR% --log_syslog=0
)

set OH_HOME=%OH_PATH%oh

set OH_BIN=%OH_HOME%\bin
set OH_LIB=%OH_HOME%\lib
set OH_BUNDLE=%OH_HOME%\bundle
set OH_REPORT=%OH_HOME%\rpt

set CLASSPATH=%OH_BIN%

SETLOCAL ENABLEDELAYEDEXPANSION

FOR %%A IN (%OH_LIB%\*.jar) DO (
	set CLASSPATH=!CLASSPATH!;%%A
)
set CLASSPATH=%CLASSPATH%;%OH_BIN%\OH-gui.jar
set CLASSPATH=%CLASSPATH%;%OH_BUNDLE%
set CLASSPATH=%CLASSPATH%;%OH_REPORT%

echo %CLASSPATH%

REM start Open Hospital

cd /d %OH_PATH%oh\
%OH_PATH%\%JAVA_DIR%\bin\java.exe -Dlog4j.configuration=%OH_PATH%oh/rsc/log4j.properties -showversion -Dsun.java2d.dpiaware=false -Djava.library.path=%OH_PATH%oh\lib\native\Windows -cp %CLASSPATH% org.isf.menu.gui.Menu
start /b %OH_PATH%\%MYSQL_DIR%\bin\mysqladmin --user=root --password= --port=%freePort% shutdown
exit

:END
echo Error initializing the DB.
pause
