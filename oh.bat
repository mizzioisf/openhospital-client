@echo off
REM # Open Hospital (www.open-hospital.org)
REM # Copyright © 2006-2020 Informatici Senza Frontiere (info@informaticisenzafrontiere.org)
REM #
REM # Open Hospital is a free and open source software for healthcare data management.
REM #
REM # This program is free software: you can redistribute it and/or modify
REM # it under the terms of the GNU General Public License as published by
REM # the Free Software Foundation, either version 3 of the License, or
REM # (at your option) any later version.
REM #
REM # https://www.gnu.org/licenses/gpl-3.0-standalone.html
REM #
REM # This program is distributed in the hope that it will be useful,
REM # but WITHOUT ANY WARRANTY; without even the implied warranty of
REM # MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
REM # GNU General Public License for more details.
REM #
REM # You should have received a copy of the GNU General Public License
REM # along with this program. If not, see <http://www.gnu.org/licenses/>.
REM #

REM ################### Configuration ###################
set OH_PATH=%~dps0

set OH_DISTRO="portable"
REM set OH_DISTRO="client"
REM set DEMO_MODE="off"

REM # Language setting - default set to en
REM set OH_LANGUAGE=en fr es it pt
set OH_LANGUAGE=en

REM # set debug level to INFO | DEBUG - default set to INFO
set DEBUG_LEVEL=INFO

REM ### Software configuration - change at your own risk :-)
REM # Database
set MYSQL_SERVER=localhost
set MYSQL_PORT=3306
set MYSQL_ROOT_PW=root123
set DATABASE_NAME=oh
set DATABASE_USER=isf
set DATABASE_PASSWORD=isf123

set DICOM_MAX_SIZE="4M"

set OH_DIR=oh
set SQL_DIR=sql
set MYSQL_SOCKET="var/run/mysqld/mysql.sock"
set MYSQL_DATA_DIR="var/lib/mysql/"
set DB_CREATE_SQL="create_all_en.sql"
REM default to create_all_en.sql - set to "create_all_demo.sql" for demo or create_all_[lang].sql for language
set LOG_DIR="var\log"
set LOG_FILE="startup.log"

REM ######## MySQL Software
REM # MariaDB
REM MYSQL_URL=http://ftp.bme.hu/pub/mirrors/mariadb/mariadb-10.2.36/winx64-packages/mariadb-10.2.36-winx64.zip
REM http://ftp.kaist.ac.kr/mysql/Downloads/MySQL-5.7/mysql-5.7.31-winx64.zip
REM 
REM # MySQL
REM #MYSQL_DIR="mysql-5.7.30-linux-glibc2.12-$ARCH"
REM #MYSQL_URL="https://downloads.mysql.com/archives/get/p/23/file"

set MYSQL_DIR=mariadb-10.2.36-winx64
set MYSQL_DIR=mysql-5.7.31-winx64

REM ####### JAVA Software
REM ######## JAVA 64bit - default architecture
REM ### JRE 11 - openjdk
REM set JAVA_URL="https://github.com/AdoptOpenJDK/openjdk11-binaries/releases/download/jdk-11.0.9.1%2B1/"
REM set JAVA_DISTRO="OpenJDK11U-jre_x64_windows_hotspot_11.0.9.1_1"

set JAVA_DIR="jdk-11.0.9.1+1-jre"
set JAVA_BIN=%OH_PATH%\%JAVA_DIR%\bin\java.exe

set REPLACE_PATH=%OH_PATH%\%MYSQL_DIR%\bin

REM set mysql port
set startPort=%MYSQL_PORT%
:SEARCHPORT
netstat -o -n -a | find "LISTENING" | find ":%startPort% " > NUL
if "%ERRORLEVEL%" equ "0" (
	echo "port unavailable %startPort%"
	set /a startPort +=1
	GOTO :SEARCHPORT
) ELSE (
	echo "port available %startPort%"
	set MYSQL_PORT=%startPort%
	GOTO :FOUNDPORT
)
:FOUNDPORT
echo "Found TCP port %MYSQL_PORT% for MySQL !"

REM ### SETUP MySQL configuration
echo f | xcopy %OH_PATH%\etc\mysql\my.cnf.dist %OH_PATH%\etc\mysql\my.cnf /y > "%OH_PATH%\%LOG_DIR%\%LOG_FILE%" 2>&1
%REPLACE_PATH%\replace.exe OH_PATH_SUBSTITUTE %OH_PATH% -- %OH_PATH%\etc\mysql\my.cnf  >> "%OH_PATH%\%LOG_DIR%\%LOG_FILE%" 2>&1
%REPLACE_PATH%\replace.exe MYSQL_PORT %MYSQL_PORT% -- %OH_PATH%\etc\mysql\my.cnf >> "%OH_PATH%\%LOG_DIR%\%LOG_FILE%" 2>&1
%REPLACE_PATH%\replace.exe MYSQL_DISTRO %MYSQL_DIR% -- %OH_PATH%\etc\mysql\my.cnf >> "%OH_PATH%\%LOG_DIR%\%LOG_FILE%" 2>&1
%REPLACE_PATH%\replace.exe DICOM_SIZE %DICOM_MAX_SIZE% -- %OH_PATH%\etc\mysql\my.cnf >> "%OH_PATH%\%LOG_DIR%\%LOG_FILE%" 2>&1

REM ### SETUP dicom.properties
echo f | xcopy %OH_PATH%\%OH_DIR%\rsc\dicom.properties.dist %OH_PATH%\%OH_DIR%\rsc\dicom.properties /y >> "%OH_PATH%\%LOG_DIR%\%LOG_FILE%" 2>&1
%REPLACE_PATH%\replace.exe OH_PATH_SUBSTITUTE %OH_PATH% -- %OH_PATH%\%OH_DIR%\rsc\dicom.properties >> "%OH_PATH%\%LOG_DIR%\%LOG_FILE%" 2>&1
%REPLACE_PATH%\replace.exe DICOM_SIZE %DICOM_MAX_SIZE% -- %OH_PATH%\%OH_DIR%\rsc\dicom.properties >> "%OH_PATH%\%LOG_DIR%\%LOG_FILE%" 2>&1

REM ### SETUP database.properties
echo f | xcopy %OH_PATH%\%OH_DIR%\rsc\database.properties.dist %OH_PATH%\%OH_DIR%\rsc\database.properties /y >> "%OH_PATH%\%LOG_DIR%\%LOG_FILE%" 2>&1
%REPLACE_PATH%\replace.exe DBSERVER %MYSQL_SERVER% -- %OH_PATH%\%OH_DIR%\rsc\database.properties >> "%OH_PATH%\%LOG_DIR%\%LOG_FILE%" 2>&1
%REPLACE_PATH%\replace.exe DBPORT %MYSQL_PORT% -- %OH_PATH%\%OH_DIR%\rsc\database.properties >> "%OH_PATH%\%LOG_DIR%\%LOG_FILE%" 2>&1
%REPLACE_PATH%\replace.exe DBNAME %DATABASE_NAME% -- %OH_PATH%\%OH_DIR%\rsc\database.properties >> "%OH_PATH%\%LOG_DIR%\%LOG_FILE%" 2>&1
%REPLACE_PATH%\replace.exe DBUSER %DATABASE_USER% -- %OH_PATH%\%OH_DIR%\rsc\database.properties >> "%OH_PATH%\%LOG_DIR%\%LOG_FILE%" 2>&1
%REPLACE_PATH%\replace.exe DBPASS %DATABASE_PASSWORD% -- %OH_PATH%\%OH_DIR%\rsc\database.properties >> "%OH_PATH%\%LOG_DIR%\%LOG_FILE%" 2>&1

REM ### SETUP generalData.properties
echo f | xcopy %OH_PATH%\%OH_DIR%\rsc\generalData.properties.dist %OH_PATH%\%OH_DIR%\rsc\generalData.properties /y >> "%OH_PATH%\%LOG_DIR%\%LOG_FILE%" 2>&1
%REPLACE_PATH%\replace.exe OH_SET_LANGUAGE %OH_LANGUAGE% -- %OH_PATH%\%OH_DIR%\rsc\generalData.properties >> "%OH_PATH%\%LOG_DIR%\%LOG_FILE%" 2>&1

REM ### SETUP log4j.properties
echo f | xcopy %OH_PATH%\%OH_DIR%\rsc\log4j.properties.dist %OH_PATH%\%OH_DIR%\rsc\log4j.properties /y >> "%OH_PATH%\%LOG_DIR%\%LOG_FILE%" 2>&1
%REPLACE_PATH%\replace.exe DBSERVER %MYSQL_SERVER% -- %OH_PATH%\%OH_DIR%\rsc\log4j.properties >> "%OH_PATH%\%LOG_DIR%\%LOG_FILE%" 2>&1
%REPLACE_PATH%\replace.exe DBPORT %MYSQL_PORT% -- %OH_PATH%\%OH_DIR%\rsc\log4j.properties >> "%OH_PATH%\%LOG_DIR%\%LOG_FILE%" 2>&1
%REPLACE_PATH%\replace.exe DBUSER %DATABASE_USER% -- %OH_PATH%\%OH_DIR%\rsc\log4j.properties  >> "%OH_PATH%\%LOG_DIR%\%LOG_FILE%" 2>&1
%REPLACE_PATH%\replace.exe DBPASS %DATABASE_PASSWORD% -- %OH_PATH%\%OH_DIR%\rsc\log4j.properties >> "%OH_PATH%\%LOG_DIR%\%LOG_FILE%" 2>&1
%REPLACE_PATH%\replace.exe DEBUG_LEVEL %DEBUG_LEVEL% -- %OH_PATH%\%OH_DIR%\rsc\log4j.properties >> "%OH_PATH%\%LOG_DIR%\%LOG_FILE%" 2>&1


IF EXIST %OH_PATH%\sql\%DB_CREATE_SQL% (
	echo "Initializing MySQL database on port %MYSQL_PORT%..."

	echo "Removing data..."
 	REM remove databases
	rmdir /s /q %OH_PATH%\%MYSQL_DATA_DIR%
	mkdir %OH_PATH%\%MYSQL_DATA_DIR%
	del /s /q %OH_PATH%\var\run\mysqld\*
	del /s /q %OH_PATH%\tmp
	
	IF  %MYSQL_DIR:~0,5% == maria (
		echo Inizializing MariaDB...
		start /b /min /wait %OH_PATH%\%MYSQL_DIR%\bin\mysql_install_db.exe --datadir=%OH_PATH%\%MYSQL_DATA_DIR% --password=%MYSQL_ROOT_PW%  >> "%OH_PATH%\%LOG_DIR%\%LOG_FILE%" 2>&1
	)
	IF  %MYSQL_DIR:~0,5% == mysql (
		echo Inizializing MySQL...
		start /b /min /wait %OH_PATH%\%MYSQL_DIR%\bin\mysqld.exe --initialize-insecure --console --basedir="%OH_PATH%\%MYSQL_DIR%" --datadir="%OH_PATH%\%MYSQL_DATA_DIR%"
	)
	IF ERRORLEVEL 1 (goto END)

	echo Starting MySQL....
	start /b /min %OH_PATH%\%MYSQL_DIR%\bin\mysqld.exe --defaults-file=%OH_PATH%\etc\mysql\my.cnf --tmpdir=%OH_PATH%\tmp --standalone --console
	IF ERRORLEVEL 1 (goto END)
	timeout /t 2 /nobreak >nul
	
	REM # If using MySQL root password need to be set
	IF  %MYSQL_DIR:~0,5% == mysql (
		echo Setting MySQL root password...
		start /b /min /wait %OH_PATH%\%MYSQL_DIR%\bin\mysql.exe -u root --skip-password --host=%MYSQL_SERVER% --port=%MYSQL_PORT% -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '%MYSQL_ROOT_PW%';" >> %OH_PATH%\%LOG_DIR%\%LOG_FILE% 2>&1
	)
	
	echo Importing database schema %DB_CREATE_SQL%...
	start /b /min /wait %OH_PATH%\%MYSQL_DIR%\bin\mysql.exe -u root -p%MYSQL_ROOT_PW% --host=%MYSQL_SERVER% --port=%MYSQL_PORT% -e "CREATE DATABASE %DATABASE_NAME%; CREATE USER '%DATABASE_USER%'@'localhost' IDENTIFIED BY '%DATABASE_PASSWORD%'; GRANT ALL PRIVILEGES ON %DATABASE_NAME%.* TO '%DATABASE_USER%'@'localhost' IDENTIFIED BY '%DATABASE_PASSWORD%';" >> %OH_PATH%\%LOG_DIR%\%LOG_FILE% 2>&1
	
	cd /d %OH_PATH%\sql
	start /b /min /wait %OH_PATH%\%MYSQL_DIR%\bin\mysql.exe --local-infile=1 -u root -p%MYSQL_ROOT_PW% --host=%MYSQL_SERVER% --port=%MYSQL_PORT% %DATABASE_NAME% < "%OH_PATH%\sql\%DB_CREATE_SQL%"  >> "%OH_PATH%\%LOG_DIR%\%LOG_FILE%" 2>&1
	IF ERRORLEVEL 1 (goto END)
	echo Database imported!
	cd /d %OH_PATH%

	rename "%OH_PATH%\sql\%DB_CREATE_SQL%" "%DB_CREATE_SQL%.imported"  >>"%OH_PATH%\%LOG_DIR%\%LOG_FILE%" 2>&1
) ELSE (
	echo Missing sql database creation script or Database already initialized, trying to start...
	echo Starting MySQL....
	start /b /min %OH_PATH%\%MYSQL_DIR%\bin\mysqld.exe --defaults-file=%OH_PATH%\etc\mysql\my.cnf --tmpdir=%OH_PATH%\tmp --standalone --console
	IF ERRORLEVEL 1 (goto END)
)

REM ###### SETUP CLASSPATH #####

set CLASSPATH="%OH_PATH%\%OH_DIR%\lib"

SETLOCAL ENABLEDELAYEDEXPANSION

FOR %%A IN (%OH_PATH%\%OH_DIR%\lib\*.jar) DO (
	set CLASSPATH=!CLASSPATH!;%%A
)
set CLASSPATH="%CLASSPATH%;%OH_PATH%\%OH_DIR%\bin\OH-gui.jar"
set CLASSPATH="%CLASSPATH%;%OH_PATH%\%OH_DIR%\bundle"
set CLASSPATH="%CLASSPATH%;%OH_PATH%\%OH_DIR%\rpt"

REM # Set architecture
IF (%PROCESSOR_ARCHITECTURE%)==(AMD64) (set %NATIVE_LIB_PATH%=%OH_PATH%\%OH_DIR%\lib\native\Win64) ELSE (set %NATIVE_LIB_PATH%=%OH_PATH%\%OH_DIR%\lib\native\Windows)

REM ###### Start Open Hospital #####
cd /d %OH_PATH%\%OH_DIR%
%JAVA_BIN% -Dlog4j.configuration=%OH_PATH%\%OH_DIR%\rsc\log4j.properties -showversion -Dsun.java2d.dpiaware=false -Djava.library.path=%NATIVE_LIB_PATH% -cp %CLASSPATH% org.isf.menu.gui.Menu

REM # Shutting down MySQL

start /b /min /wait %OH_PATH%\%MYSQL_DIR%\bin\mysqladmin --user=root --password=%MYSQL_ROOT_PW% --host=%MYSQL_SERVER% --port=%MYSQL_PORT% shutdown >> %OH_PATH%\%LOG_DIR%\%LOG_FILE% 2>&1


cd /d %OH_PATH%\
echo Done !

:END
echo Error initializing the DB.
cd /d %OH_PATH%
