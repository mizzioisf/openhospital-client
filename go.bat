@echo off
REM # Open Hospital (www.open-hospital.org)
REM # Copyright © 2006-2021 Informatici Senza Frontiere (info@informaticisenzafrontiere.org)
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

REM launch powershell script

REM :header
REM    echo %__NAME% v%__VERSION%
REM    echo This is Open Hospital launch script
REM    echo.
REM    goto :eof

IF "%1"=="legacy" GOTO LEGACY


echo Launching oh.ps1...

powershell.exe  -ExecutionPolicy Bypass -File  ./oh.ps1

:LEGACY

echo Starting OH with legacy oh.bat...

:END
   REM call :cleanup
    exit /B
