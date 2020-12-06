@echo off
REM # Open Hospital (www.open-hospital.org)
REM # Copyright Â© 2006-2020 Informatici Senza Frontiere (info@informaticisenzafrontiere.org)
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
REm #


@echo off
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
SET MYSQL_SERVER=localhost
SET MYSQL_PORT=3306
set MYSQL_ROOT_PW=root123
SET DATABASE_NAME=oh
SET DATABASE_USER=isf
SET DATABASE_PASSWORD=isf123

SET DICOM_MAX_SIZE="4M"

SET OH_DIR="oh"
SET SQL_DIR="sql"
SET MYSQL_SOCKET="var/run/mysqld/mysql.sock"
SET MYSQL_DATA_DIR="var/lib/mysql/"
SET DB_CREATE_SQL="create_all_en.sql"
REM default to create_all_en.sql - set to "create_all_demo.sql" for demo or create_all_[lang].sql for language

REM ######## MySQL Software
REM # MariaDB
REM curl http://ftp.bme.hu/pub/mirrors/mariadb/mariadb-10.2.36/winx64-packages/mariadb-10.2.36-winx64.zip -o mariadb-10.2.36-winx64.zip
REM MYSQL_URL="https://downloads.mariadb.com/MariaDB/mariadb-10.2.36/bintar-linux-x86_64"
REM http://ftp.kaist.ac.kr/mysql/Downloads/MySQL-5.7/mysql-5.7.31-winx64.zip

set MYSQL_DIR=mariadb-10.2.36-winx64
REM set MYSQL_DIR=mysql-5.7.31-winx64

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

REM ### SETUP mysql configuration
echo f | xcopy %OH_PATH%\etc\mysql\my.cnf.dist %OH_PATH%\etc\mysql\my.cnf /y
%REPLACE_PATH%\replace.exe MYSQL_PORT %MYSQL_PORT% -- %OH_PATH%\etc\mysql\my.cnf
%REPLACE_PATH%\replace.exe MYSQL_PORT %MYSQL_PORT% -- %OH_PATH%\etc\mysql\my.cnf
%REPLACE_PATH%\replace.exe OH_PATH_SUBSTITUTE %OH_PATH% -- %OH_PATH%\etc\mysql\my.cnf
%REPLACE_PATH%\replace.exe MYSQL_DISTRO %MYSQL_DIR% -- %OH_PATH%\etc\mysql\my.cnf
%REPLACE_PATH%\replace.exe DICOM_SIZE %DICOM_MAX_SIZE% -- %OH_PATH%\etc\mysql\my.cnf

REM ### SETUP dicom.properties
echo f | xcopy %OH_PATH%\%OH_DIR%\rsc\dicom.properties.dist %OH_PATH%\%OH_DIR%\rsc\dicom.properties /y
%REPLACE_PATH%\replace.exe OH_PATH_SUBSTITUTE %OH_PATH% -- %OH_PATH%\%OH_DIR%\rsc\dicom.properties
%REPLACE_PATH%\replace.exe DICOM_SIZE %DICOM_MAX_SIZE% -- %OH_PATH%\%OH_DIR%\rsc\dicom.properties

REM ### SETUP database.properties
echo "jdbc.url=jdbc:mysql://%MYSQL_SERVER%:%MYSQL_PORT%/%DATABASE_NAME%" > %OH_PATH%\oh\rsc\database.properties
echo "jdbc.username=%DATABASE_USER%" >> %OH_PATH%\oh\rsc\database.properties
echo "jdbc.password=%DATABASE_PASSWORD%" >> %OH_PATH%\oh\rsc\database.properties

REM ### SETUP generalData.properties
echo f | xcopy %OH_PATH%\%OH_DIR%\rsc\generalData.properties.dist %OH_PATH%\%OH_DIR%\rsc\generalData.properties /y
%REPLACE_PATH%\replace.exe OH_SET_LANGUAGE %OH_LANGUAGE% -- %OH_PATH%\%OH_DIR%\rsc\generalData.properties

REM ### SETUP log4j.properties
echo f | xcopy %OH_PATH%\%OH_DIR%\rsc\log4j.properties.dist %OH_PATH%\%OH_DIR%\rsc\log4j.properties /y
%REPLACE_PATH%\replace.exe DBPORT %MYSQL_PORT% -- %OH_PATH%\%OH_DIR%\rsc\log4j.properties
%REPLACE_PATH%\replace.exe DBSERVER %MYSQL_SERVER% -- %OH_PATH%\%OH_DIR%\rsc\log4j.properties
%REPLACE_PATH%\replace.exe DBUSER %DATABASE_USER% -- %OH_PATH%\%OH_DIR%\rsc\log4j.properties
%REPLACE_PATH%\replace.exe DBPASS %DATABASE_PASSWORD% -- %OH_PATH%\%OH_DIR%\rsc\log4j.properties
%REPLACE_PATH%\replace.exe DEBUG_LEVEL %DEBUG_LEVEL% -- %OH_PATH%\%OH_DIR%\rsc\log4j.properties


IF EXIST %OH_PATH%\sql\%DB_CREATE_SQL% (
	echo "Initializing MySQL database on port %MYSQL_PORT%..."

	echo "Removing data..."
 	REM remove databases
	rmdir /s /q %OH_PATH%\%MYSQL_DATA_DIR%
	mkdir %OH_PATH%\%MYSQL_DATA_DIR%
	del /s /q %OH_PATH%\var\run\mysqld\*
	del /s /q %OH_PATH%\tmp
	
	IF  %MYSQL_DIR:~0,5% == maria (
		echo MariaDB
		start /b /min %OH_PATH%/%MYSQL_DIR%\bin\mysql_install_db.exe --datadir=%OH_PATH%\%MYSQL_DATA_DIR% --password=%MYSQL_ROOT_PW%
		timeout /t 3 /nobreak >nul
	)
	IF  %MYSQL_DIR:~0,5% == mysql (
		echo MySQL
		REM %OH_PATH%/%MYSQL_DIR/bin/mysqld --initialize-insecure --socket=%OH_PATH%/%MYSQL_SOCKET% --basedir=%OH_PATH%/%MYSQL_DIR% --datadir=%OH_PATH%/%MYSQL_DATA_DIR%
	)
	IF ERRORLEVEL 1 (goto END)
	
	echo Starting MySQL....
	start /b /min %OH_PATH%\%MYSQL_DIR%\bin\mysqld.exe --defaults-file=%OH_PATH%\etc\mysql\my.cnf --tmpdir=%OH_PATH%\tmp --standalone --console
	timeout /t 3 /nobreak >nul
	IF ERRORLEVEL 1 (goto END)
	
	echo Importing database schema %DB_CREATE_SQL%...
	%OH_PATH%\%MYSQL_DIR%\bin\mysql.exe -u root -p%MYSQL_ROOT_PW% --host=%MYSQL_SERVER% --port=%MYSQL_PORT% -e "CREATE SCHEMA %DATABASE_NAME%; CREATE USER '%DATABASE_USER%'@'localhost' IDENTIFIED BY '%DATABASE_PASSWORD%'; GRANT ALL PRIVILEGES ON %DATABASE_NAME%.* TO '%DATABASE_USER%'@'localhost' IDENTIFIED BY '%DATABASE_PASSWORD%';"
	
	cd /d %OH_PATH%\sql
	%OH_PATH%\%MYSQL_DIR%\bin\mysql.exe --local-infile=1 -u root -p%MYSQL_ROOT_PW% --host=%MYSQL_SERVER% --port=%MYSQL_PORT% %DATABASE_NAME% < "%OH_PATH%\sql\%DB_CREATE_SQL%"
	IF ERRORLEVEL 1 (goto END)
	echo Database imported!

	rename "%OH_PATH%\sql\create_all_en.sql" create_all_en.sql.imported
) ELSE (
	echo Missing sql database creation script or Database already initialized, trying to start...
	echo Starting MySQL....
	start /b /min %OH_PATH%\%MYSQL_DIR%\bin\mysqld.exe --defaults-file=%OH_PATH%\etc\mysql\my.cnf --tmpdir=%OH_PATH%\tmp --standalone --console
	IF ERRORLEVEL 1 (goto END)
)


REM ### SETUP OH configuration

set OH_HOME=%OH_PATH%\oh
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

REM #### Start Open Hospital

cd /d %OH_PATH%\%OH_DIR%
%OH_PATH%\%JAVA_DIR%\bin\java.exe -Dlog4j.configuration=%OH_PATH%\%OH_DIR%\rsc\log4j.properties -showversion -Dsun.java2d.dpiaware=false -Djava.library.path=%OH_PATH%\%OH_DIR%\lib\native\Windows -cp %CLASSPATH% org.isf.menu.gui.Menu

REM # Shutting down MySQL

start /b %OH_PATH%\%MYSQL_DIR%\bin\mysqladmin --user=root --password=%MYSQL_ROOT_PW% --host=%MYSQL_SERVER% --port=%MYSQL_PORT% shutdown

cd /d %OH_PATH%\
echo Done !

REM :function_clean_database
REM 	echo "Warning: do you want to remove all data and database ?"
REM 	REM get_confirmation;
REM	echo "Removing data..."
REM 	REM remove databases
REM	del /s /q %OH_PATH%\%MYSQL_DATA_DIR%\*
REM	del /s /q %OH_PATH%\var\run\mysqld\*
REM	del /s /q %OH_PATH%\tmp
REM EXIT /B 0

:END
echo Error initializing the DB.
cd /d %OH_PATH%
pause
