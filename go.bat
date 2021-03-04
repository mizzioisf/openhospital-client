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

REM set OH_DISTRO="PORTABLE|CLIENT"
REM set DEMO_MODE="off"

REM # Language setting - default set to en
REM set OH_LANGUAGE=en fr es it pt
set OH_LANGUAGE=en

REM # set debug level to INFO | DEBUG - default set to INFO
set DEBUG_LEVEL=INFO

REM launch powershell script

echo Launching oh.ps1...

powershell.exe  -ExecutionPolicy Bypass ./oh.ps1
