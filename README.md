# ![](./doc/media/OH-icon.png) OH - Open Hospital Portable | Client 

OH - Open Hospital (https://www.open-hospital.org/) is a free and open-source Electronic Health Record (EHR) software application.
Open Hospital is deployed as a desktop application that can be used in a standalone, single user mode (PORTABLE mode)
or in a client / server network configuration (CLIENT mode), where multiple clients and users connect to the same database server.

OH is developed in Java and it is based on open-source tools and libraries; it runs on any computer, requires low resources and is designed to work without an internet connection.

Open Hospital is the first of a set of software applications that ISF - Informatici Senza Frontiere (https://www.informaticisenzafrontiere.org/) has developed to support the information management and the activities of hospitals and health centers in the simplest manner possible, by providing tools for the administrative operations (like registering patients, manage laboratory analysis and pharmaceutical stocks) and to produce detailed statistics and reports.
It was first deployed in 2006 at the St. Luke Hospital in Angal (Uganda) and it is now used in dozens of different locations around the world.

When OH is used in PORTABLE mode, it is easily possible to move the installation on another computer or even run it from a USB stick or drive.
All you have to do is to copy the root installation directory of OH to your favourite folder, where the program and all the data are kept.
OH uses its own version of the Java Virtual Machine (JRE) and the MariaDB/MySQL server.
OH is released under the GNU GPL 3.0 License.

The Linux version has been tested on different distributions and versions, including Ubuntu 16.04 i386 (32bit) and up to Ubuntu 22.04 x64 (64bit).
The Windows version has been tested on Windows 7/10/11 (64bit)

**This repo is experimental and is used to test the latest Open Hospital releases and features. Use at your own risk !**

**New ! Updated to 1.12-dev Open Hospital pre-release!**

# Running OH - Ultra-quickstart

**on Linux:**

To download and launch the Open Hospital package contained in this distribution open a shell and type (or copy and paste):

```
bash <(wget -qO- https://raw.githubusercontent.com/mizzioisf/openhospital-client/main/go.sh)
```

# Dowloading OH - Releases

[**Official download page**](https://www.open-hospital.org/download)

[**Download latest release from github**](https://github.com/informatici/openhospital/releases/latest) 

# Dowloading OH - this repo

- clone the repository with git:
```
git clone https://github.com/mizzioisf/openhospital-client
```
- browse to the directory:
```
cd openhospital-client
```

# Running OH - Quickstart

## Common to all Operating Systems / architectures

- Download Open Hospital package for the desired architecture
- Unzip/untar the package
- Browse to the extracted folder

## Linux

- start OH by running **./oh.sh**
- to see available options, run **./oh.sh -h**

```
 -----------------------------------------------------------------
|                                                                 |
|                       Open Hospital | OH                        |
|                                                                 |
 -----------------------------------------------------------------
 arch x86_64 | lang en | mode PORTABLE | log level INFO | Demo off
 -----------------------------------------------------------------
 Usage: oh.sh [ -l en|fr|es|it|pt|ar ] 

   -C    set OH in CLIENT mode
   -P    set OH in PORTABLE mode
   -S    set OH in SERVER (Portable) mode
   -l    set language: en|fr|es|it|pt|ar
   -s    save OH configuration
   -X    clean/reset OH installation
   -v    show configuration
   -q    quit

   --------------------- 
    advanced options

   -e    export/save OH database
   -r    restore OH database
   -d    toggle log level INFO/DEBUG
   -G    setup GSM
   -D    initialize OH with Demo data
   -i    initialize/install OH database
   -m    configure database connection manually
   -t    test database connection (CLIENT mode only)
   -u    create Desktop shortcut

   -h    show help
```

## Windows

- double click on the **oh.bat** batch file and choose among available options:

```
 -----------------------------------------------------------------
|                                                                 |
|                       Open Hospital | OH                        |
|                                                                 |
 -----------------------------------------------------------------
 arch x86_64 | lang en | mode PORTABLE | log level INFO | Demo off
 -----------------------------------------------------------------

 Usage: oh.ps1 [ -lang en|fr|it|es|pt|ar ] 
               [ -mode PORTABLE|CLIENT ]
               [ -loglevel INFO|DEBUG ] 
               [ -interactive on|off ]
               [ -generate_config on|off ]

    C    set OH in CLIENT mode
    P    set OH in PORTABLE mode
    S    set OH in SERVER (Portable) mode
    l    set language: en|fr|es|it|pt|ar
    s    save OH configuration
    X    clean/reset OH installation
    v    show configuration
    q    quit

   --------------------- 
    advanced options

    e    export/save OH database
    r    restore OH database
    d    toggle log level INFO/DEBUG
    G    setup GSM
    D    initialize OH with Demo data
    i    initialize/install OH database
    m    configure database connection manually
    t    test database connection (CLIENT mode only)
    u    create Desktop shortcut with current params

    h    show help
```

Note: The **oh.bat** launches the **oh.ps1** startup file automatically.
The script presents the interactive menu that can be used to setup and choose how to run Open Hospital.

-> To manually run **oh.ps1** (powershell script):

- right-click on **oh.ps1** -> Properties -> General -> Security
- select "Unblock"
- right click on **oh.ps1** and select "Run with Powershell"
- if asked for permission to execute the script select "Allow"
- choose among available options

It might be necessary to set the correct permissions / exclusions also in the Windows Security Center, to allow OH to communicate on
the MySQL / MariaDB local TCP port.

-> To run oh.ps1 directly from command line:

```
powershell.exe -ExecutionPolicy Bypass -File  ./oh.ps1 [options]
```

-> To run oh.ps1 with command line options (example):

```
./oh.ps1 -lang it -mode PORTABLE -loglevel DEBUG -interactive off -generate_config on
```

# Options 

- **C**    set Open Hospital to start in CLIENT mode, usually when an external database server is used (Client / Server configuration)
- **P**    set Open Hospital to start in PORTABLE mode, where data is saved locally
- **S**    set Open Hospital to start in SERVER mode: the local portable instance of MariaDB is launched to act as a portable database server
- **l**    set local language: en|fr|it|es|pt|ar
- **s**    save / write / reenerate OH configuration files (oh/rsc/\*.properties) and exit
- **X**    clean/reset OH installation by deleting all data and configuration files -> **use with caution** <-
- **v**    show Open Hospital external software version and configuration
- **q**    quit (windows only)

### Advanced options

- **e**    export / save / dump the Open Hospital database in sql format
- **r**    restore Open Hospital database from backup or external sql file: user will be prompted for input sql file
- **d**    toggle log level between INFo and DEBUG - useful to execute OH in debug mode in order to log errors or bugs with more extended informations to log file
- **G**    setup GSM modem to enable sms interaction
- **D**    initialize OH database with Demo data - loads a demo database in order to test the software 
- **i**    initialize / install OH database
- **m**    configure OH database connection settings manually
- **t**    test database connection to the configured database server (Client mode only)
- **u**    create Desktop shortcut with current params (Windows only)
- **h**    show help 

# Script configuration

Some advanced options can be configured manually by editing the scripts (oh.sh and oh.ps1 - do not modify oh.bat unless legacymode is used) and setting the specific script variables.
This might also be useful to set different combinations of options (language, debug level, ...) for specific needs.

### OH directory path
```
############## OH general configuration - change at your own risk :-) ##############
#
# -> OH_PATH is the directory where Open Hospital files are located
# OH_PATH="c:\Users\OH\OpenHospital\oh-1.11"
```
### (Windows only) Enable interactive mode
```
# Interactive mode
# set INTERACTIVE_MODE to "off" to launch oh.ps1 without calling the user
# interaction menu (script_menu). Useful if automatic startup of OH is needed.
# In order to use this mode, setup all the OH configuration variables in the script
# or pass arguments via command line.
$script:INTERACTIVE_MODE="on"
```
### Config file generation

It is possibile to set the WRITE_CONFIG_FILES option to "on" to regenerate the OH configuration files at startup (this is also possibile by selecting the *g* script option).
The default is set to off, so the configuration files are not regenerated and overwritten at every startup. This is useful for production environment where the configuration is fixed.

```
# set WRITE_CONFIG_FILES=on "on" to force generation / overwriting of configuration files:
# data/conf/my.cnf and oh/rsc/*.properties files will be regenerated from the original .dist files
# with the settings defined in this script.
#
# Default is set to "off": configuration files will not be generated or overwritten if already present.
#
WRITE_CONFIG_FILES="off" # linux
$script:WRITE_CONFIG_FILES="off" # windows
```

### Distribution type - CLIENT | PORTABLE | SERVER

```
#######################  OH configuration  #########################
OH_MODE=PORTABLE # set functioning mode to CLIENT | PORTABLE | CLIENT # linux
$script:OH_MODE="PORTABLE" # windows
```
### Interface and software language:
```
# Language setting - default set to en
OH_LANGUAGE=en # fr es it pt ar # linux
$script:OH_LANGUAGE="en" # fr es it pt ar # windows
```
### Log level / debug mode
```
# set log level to INFO | DEBUG - default set to INFO
LOG_LEVEL=INFO # linux
$script:LOG_LEVEL="INFO" # windows
```
### Demo mode
```
# set DEMO_DATA to on to enable demo database loading - default set to off
# -> Warning -> __requires deletion of all portable data__
DEMO_DATA=off # linux
$script:DEMO_DATA="off" # windows
```
### Enable system wide JAVA
```
# set JAVA_BIN 
# Uncomment this if you want to use system wide JAVA
#JAVA_BIN=`which java` # linux
#$script:JAVA_BIN="C:\Program Files\JAVA\bin\java.exe" # windows
```
### Database configuration

If a database server hostname/address is specified (other then localhost), OH can be started in CLIENT mode and used in a client/server / LAN environment.
```
##################### Database configuration #######################
DATABASE_SERVER=localhost
DATABASE_PORT=3306
DATABASE_ROOT_PW="xxxxxxxxxx"
DATABASE_NAME=oh
DATABASE_USER=isf
DATABASE_PASSWORD="xxxxx"
```
### OH configuration
```
DICOM_MAX_SIZE="4M"
DICOM_STORAGE="FileSystemDicomManager" # SqlDicomManager
DICOM_DIR="data/dicom_storage"

# path and directories
OH_DIR="oh"
OH_DOC_DIR="../doc"
OH_SINGLE_USER="yes" # set "no" for multiuser
CONF_DIR="data/conf"
DATA_DIR="data/db"
PHOTO_DIR="data/photo"
BACKUP_DIR="data/dump"
LOG_DIR="data/log"
SQL_DIR="sql"
SQL_EXTRA_DIR="sql/extra"
TMP_DIR="tmp"

# logging
LOG_FILE=startup.log
OH_LOG_FILE=openhospital.log

# SQL creation files
DB_CREATE_SQL="create_all_en.sql" # default to en
DB_DEMO="create_all_demo.sql"

```
## Default directory structure

The scripts takes care of creating all the needed data directories and configuration files.
Everything is also parametric and user adjustable in the scripts with variables (or via command line options).
The default folder structure is now clean, simple and **common to all distros:**

```
/oh -> Open Hospital distribution
/sql -> containing the SQL creation scripts
/data/conf -> configuration files for database (MariaDB / MySQL)
```
Created at runtime:
```
/tmp 
data/db
data/dicom_storage
data/dump
data/log
data/photo
```
External software package downloaded at first run:

```
Mariadb 10.x.x server
Java JRE, Zulu or OpenJDK distribution
```

# Documentation

Administrator and User manuals are available in the **doc** folder.
Online versions of the manuals can be found on the [Open Hospital website](https://www.open-hospital.org/documentation)

# Other issues

If you experience problems in starting up the script, avoid long folder path and path with special characters / spaces in it.

## Linux

- If you get one of these errors:

```
Error on creating OH Database error while loading shared libraries: libncurses.so.5.

Error: MySQL root password not set! Exiting
```

You have to install the ncurses librares, on Ubuntu:

```
sudo apt-get install libncurses5
```

- If you get this error:
```
Error Initializing MySQL database on port 3306 error while loading shared libraries: libaio.so.1.
```

You have to install the libaio libraries, on Ubuntu:

```
sudo apt-get install libaio1 
```

- If you select languages en-fr-it, a ICD10 patologies subset is loaded at startup, languages es-pt don't.

## Windows

### Windows - create startup shortcut

Follow these instruction to create a Windows OH launch icon on desktop:

**Method 1 (with launch parameters configured in oh.ps1)**
- Rigth click on Desktop
- New Shortcut
- Browse to OH folder location and select oh.bat
- Assign a name to the shortcut
- Right click on the shortcut and select Properties
- Change icon
- Specify a different file
- Browse to OH folder location and select oh.ico
- Apply

**Method 2 (with launch parameters stored on execution command)**
- Rigth click on Desktop
- New Shortcut
- Browse to OH folder location and select oh.ps1
- Assign a name to the shortcut
- Right click on the shortcut and select Properties
- Change icon
- Specify a different file
- Browse to OH folder location and select oh.ico
- Modify Target with

```
C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe -ExecutionPolicy Bypass -File ./oh.ps1
```
- Apply
 
Option parameters can be added at the end of Target string separated by spaces, example:

```
C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe -ExecutionPolicy Bypass -File ./oh.ps1 -loglevel DEBUG
```

### Powershell configuration

Powershell minimun version 5.1 is required to run oh.ps1.
To install Powershell 5.1 go to https://www.microsoft.com/en-us/download/details.aspx?id=54616

If you get this error:

```
+ CategoryInfo : NotSpecified: (:) [], PSSecurityException
+ FullyQualifiedErrorId : RuntimeException or UnauthorizedAccess
```

- Start Windows PowerShell with the "Run as Administrator" option. Only members of the Administrators group on the computer can change the execution policy.
Enable running unsigned scripts by entering:
```
set-executionpolicy remotesigned
```
- You might also be required to enable access on Windows Firewall to oh.ps1 and/or to the TCP port used for the local database (PORTABLE mode).

## Windows - legacy mode

It's also possible to start Open Hospital with the legacy batch file (old oh.bat behaviour):
- open cmd.exe, browse to the OH installation directory and run **.\oh.bat -legacymode**
- to see available options in legacymode, run **.\oh.bat -h**

(*) If you are using oh.bat in legacy mode, you might have to download and unzip java ad mysql manually.

### Java
In order to download and unzip Java:

- Visit  https://cdn.azul.com/zulu/bin/
- download the latest **JRE** for your architecture:

**x64 - 64bit:** https://cdn.azul.com/zulu/bin/zulu11.62.17-ca-jre11.0.18-win_x64.zip

**x86 - 32bit:** https://cdn.azul.com/zulu/bin/zulu11.62.17-ca-jre11.0.18-win_i686.zip

- unzip the downloaded file into the base directory where OpenHospital has been placed.

### MariaDB
In order to download and unzip MariaDB:

- Visit https://mariadb.org/download/
- Select the Operating System: **Windows**
- Select package type: **ZIP file**
- Select CPU (architecture) **32 / 64**
- Download the zip file:

**x86 - 32bit:** https://archive.mariadb.org/mariadb-10.6.5/win32-packages/mariadb-10.6.5-win32.zip

**x64 - 64bit:** https://archive.mariadb.org/mariadb-10.6.11/winx64-packages/mariadb-10.6.11-winx64.zip

- unzip the downloaded file into the base directory where OpenHospital has been placed.

# oh.sh / oh.ps1 - features and development

In order to have a complete, easy to support and extensible solution to run Open Hospital on Linux, oh.sh has been rewritten, also adding a few possible useful user functions.
For the same reason, a completely new powershell script has been writtend for Windows: oh.ps1 (run by oh.bat).

A short description of changes for the Linux version (mostly the same behavior and options are applicable to the windows oh.ps1 version):

- Complete overhaul of the code, reworked the entire scripts
- Everything is now based on functions and parametric variables
- Menu based, interactive options for many operations: see **./oh.sh -h** (or see below for short description)
- **Unified script** for:
    Portable 64bit (default) and 32bit (with automatic architecture detection)
    Open Hospital client (no more separated startup.sh is needed ;-) (**it is now possible to package every linux distro, client/portable/32 or 64 bit with a single package**)

- **New** **Interactive menu**: it is possible to navigate through menu options
- **New**: Direct reading/writing of OH settings files for language and debug mode
- **New**: Desktop shortcut creation with icon (Windows and Linux)
- **New**: SERVER mode support (see oh.sh -S)
- **New**: Added "-m" option to configure OH manually
- **New**: Arabic Language support: **oh.sh -l ar**
- **New**: Full 64bit support on Windows, also for DICOM !
- **New**: Set default to MULTIUSER environment, so login mask is presented at startup
-----
- Language support (both via variable in the script or user input option: **oh.sh -l fr**)
- Demo database support (See oh.sh -D)
- Client mode support (see oh.sh -C)
- Save (see oh.sh -s) / Restore (oh.sh -r) database, available both for CLIENT and PORTABLE mode !
- GSM setup integrated via -G command line option - setupGSM.sh (https://github.com/informatici/openhospital-gui/blob/develop/SetupGSM.sh) is obsolete now
- debug mode -> set log4.properties to DEBUG mode (default is INFO)
- configuration file generation (set WRITE_CONFIG_FILES=on in script) -> mysql and oh configuration files are not generated automatically or overwritten, useful for production environment
- test database connection option (see oh.sh -t)
- displays software versions and current configuration (see oh.sh -v)
- write / generate config files (see oh.sh -w)
- install / initialize database (see oh.sh -i)
- Centralized variable managing (see related config file changes applied): now all (well, almost all, still some "isf" reference in SQL creation script...that will be removed ;-) references to database password, mysql host, etc. etc. are in the script and can be easily adapted / modified for any need
- More flexible execution and configuration options
- Automatic configuration files generation
- Everything is commented in the code and a brief output all operations is shown in console
- Startup, database and OH operations are logged to configurable output file
- Backward compatible with old versions and installations, no default behaviour change
- Unified and simplified subdirectories structure
- Added sql subdirectory to organize sql creation scripts
- Added various checks about correct settings of parameters and startup of services
- Added security controls (no more _rm -rf_ here and there :-)
- Added support for **MariaDB** for better security and performance
- Windows -> addedd support for path with spaces / special characters 
- Updated MySQL db and user creation syntax (now compatible with MySQL 8 - unsupported)
- Fixed _a_few_ bugs ;-)

*last updated: 2023.01.31*
