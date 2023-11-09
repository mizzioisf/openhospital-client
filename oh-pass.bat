@echo off
REM # Open Hospital (www.open-hospital.org)
REM # Copyright © 2006-2023 Informatici Senza Frontiere (info@informaticisenzafrontiere.org)
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
REM # along with this program. If not, see <https://www.gnu.org/licenses/>.
REM #

REM ################### Script configuration ###################
REM
REM set LEGACYMODE=on to start with legacy oh.bat script
REM
REM launch oh.bat -h to see available options
REM 
REM -> default startup script called is oh.ps1 (powershell) <-
REM 

set LEGACYMODE="off"

REM ############################################################
REM check for legacy mode

REM ###### Functions and script start
goto :init

:header
	echo.
	echo  Open Hospital startup script
	echo  %__BAT_NAME% v%__SCRIPTVERSION%
	echo.
	goto :eof

:usage
	echo USAGE:
	echo   %__BAT_NAME% [-option]
	echo.
	echo.  -h, -?, --help              shows this help
	goto :eof

:init
	set "__SCRIPTVERSION=1.0"
	set "__BAT_FILE=%~0"
	set "__BAT_PATH=%~dp0"
	set "__BAT_NAME=%~nx0"

:parse
	if "%~1"=="" goto :main

	if /i "%~1"=="/?"	call :header & call :usage & goto :end
	if /i "%~1"=="-?"	call :header & call :usage & goto :end
	if /i "%~1"=="-h"	call :header & call :usage & goto :end
	if /i "%~1"=="-help"	call :header & call :usage & goto :end
	if /i "%~1"=="--help"	call :header & call :usage & goto :end


	shift
	goto :parse

:main
	REM ################### oh.ps1 ###################
	REM default startup script called: oh.ps1

REM	echo Starting OH with oh.ps1...

	REM launch powershell script

REM ############################# Legacy oh.bat ############################

echo Password reset mode - Starting OH with oh.bat...

REM ################### Open Hospital Configuration ###################
REM #                                                   
REM #                   ___Warning___                   
REM #
REM # __this configuration parameters work ONLY for legacy mode__
REM #                                                   
REM # _for normal startup, please edit oh.ps1__
REM #
REM ###################
set OH_PATH=%~dps0

REM # set log level to INFO | DEBUG - default set to INFO
set LOG_LEVEL=INFO

REM ##################### Database configuration #######################
set DATABASE_SERVER=localhost
set DATABASE_PORT=3306
set DATABASE_ROOT_PW=tmp2021oh111
set DATABASE_NAME=oh
set DATABASE_USER=isf
set DATABASE_PASSWORD=isf123

REM #######################  OH configuration  #########################
REM # path and directories
set OH_DIR="oh"
set OH_SINGLE_USER="no"
set CONF_DIR="data\conf"
set DATA_DIR="data\db"
set LOG_DIR="data\log"
set SQL_DIR="sql"
set SQL_EXTRA="sql\extra"
set TMP_DIR="tmp"

REM # logging
set LOG_FILE=startup.log
set OH_LOG_FILE=openhospital.log

set SQL_RESET_ADMIN_PASS=reset_admin_pass.sql
REM #-> DB_CREATE_SQL default is set to create_all_en.sql - set to "create_all_demo.sql" for demo or create_all_[lang].sql for language
REM
REM -- reset admin password to 'Admin2022test!' without quotes.
REM UPDATE OH_USER SET US_PASSWD = '$2a$10$52y.1Y7ig9B6SQJy4hpPn.RscBZs7rh7fljh3GtC5RC8txi1O29NS' WHERE (US_ID_A = 'admin');


REM set MYSQL_DIR=mariadb-10.6.5-win%ARCH%
set MYSQL_DIR=mariadb-10.6.15-win%ARCH%


REM start /b /min /wait %OH_PATH%\%MYSQL_DIR%\bin\mysql.exe -u root -p%DATABASE_ROOT_PW% --host=%DATABASE_SERVER% --port=%DATABASE_PORT% -e "CREATE USER '%DATABASE_USER%'@'localhost' IDENTIFIED BY '%DATABASE_PASSWORD%'; CREATE DATABASE %DATABASE_NAME% CHARACTER SET utf8; GRANT ALL PRIVILEGES ON %DATABASE_NAME%.* TO '%DATABASE_USER%'@'localhost' IDENTIFIED BY '%DATABASE_PASSWORD%';" >> %OH_PATH%\%LOG_DIR%\%LOG_FILE% 2>&1



	echo "Resetting admin pass..."

	start /b /min /wait %OH_PATH%\%MYSQL_DIR%\bin\mysql.exe -u root -p%DATABASE_ROOT_PW% --host=%DATABASE_SERVER% --port=%DATABASE_PORT% -e "UPDATE OH_USER SET US_PASSWD = ''fc8252c8dc55839967c58b9ad755a59b61b67c13227ddae4bd3f78a38bf394f7 WHERE (US_ID_A = 'admin');"

	if ERRORLEVEL 1 (goto error)
	cd /d %OH_PATH%
	echo Password changed

goto end

:error
	echo Error resetting password, exiting.
	cd /d %OH_PATH%
	goto end

:end
	call :cleanup
	exit /B

:cleanup
	REM The cleanup function is only really necessary if you
	REM are _not_ using SETLOCAL.
	set "__SCRIPTVERSION="
	set "__BAT_FILE="
	set "__BAT_PATH="
	set "__BAT_NAME="
	set "LEGACYMODE="

	goto :eof

