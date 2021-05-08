# ![](./oh.ico) OH - Open Hospital Portable | Client 

Open Hospital (https://www.open-hospital.org/en/) is a free and open source
software for healthcare data management. Its portable version (Open Hospital
Portable) allows you to take along with you Open Hospital and run it on
any computer, keeping the data you have saved. With OH, we also hope to
reach the goal to make Open Hospital easily installable so that even somebody
with no experience of Java or MySQL can try or use it.

OH allows to use Open Hospital on a computer, easily move the installation on
another computer or even run it from a USB stick or drive. All you have to do
is to copy the root installation directory of POH to your favourite path, where
the program and the data will be kept. OH uses its own version of the Java Virtual
Machine and the MySQL server and everything is contained in the root
installation directory. OH is released under the GNU GPL 3.0 License.

The Linux version has been tested on different distributions and versions,
including Ubuntu 16.04 i386 (32bit) and up to Ubuntu 20.10 x64 (64bit).
The Windows version has been tested on Windows 10.

**This repo is experimental and is used to test the latest Open Hospital releases and features. Use at your own risk !**

# Running OH - Ultra-quickstart

**on Linux:**

To download and launch the Open Hospital package contained in this distribution open a shell and type (or copy and paste):

```
bash <(wget -qO- https://raw.githubusercontent.com/mizzioisf/openhospital-client/main/go.sh)
```

# Running OH - Quickstart

Common to all architectures:

*(see poh downloads on sourceforce for full release packages)*

**via git - latest version**

- clone the repository
```
git clone https://github.com/mizzioisf/openhospital-client
```
- browse to the directory:
```
cd openhospital-client
```

**on Linux:**

- start OH by running **./oh.sh**
- to see available options, run **./oh.sh -h**

```
 ---------------------------------------------------------
|                                                         |
|                   Open Hospital | OH                    |
|                                                         |
 ---------------------------------------------------------
 lang en | arch x86_64

 Usage: oh.sh [ -lang en|fr|it|es|pt ] 

   -C    start OH in CLIENT mode (Client / Server configuration)
   -d    start OH in DEBUG mode
   -D    start OH in DEMO mode
   -G    setup GSM
   -h    show this help
   -l    set language: en|fr|it|es|pt
   -s    save OH database
   -r    restore OH database
   -t    test database connection (CLIENT mode only)
   -v    show OH software version and configuration
   -X    clean OH installation

```

--------------------
**on Windows:**

- double click on the **oh.bat** batch file and choose among available options:

```
 ---------------------------------------------------------
|                                                         |
|                   Open Hospital | OH                    |
|                                                         |
 ---------------------------------------------------------
lang en | arch x86_64

Usage: oh.ps1 [ -lang en|fr|it|es|pt ] 
              [ -distro PORTABLE|CLIENT ]
              [ -debug INFO|DEBUG ] 

 C    start OH - CLIENT mode (Client / Server configuration)
 d    start OH in DEBUG mode
 D    start OH in DEMO mode
 G    setup GSM
 l    set language: en|fr|it|es|pt
 s    save OH database
 r    restore OH database
 t    test database connection (Client mode only)
 v    show OH software version and configuration
 X    clean OH installation
 q    quit
```
Note: The oh.bat launches the oh.ps1 startup file automatically.
The script offers an interactive menu that can be used to setup and choose how to run Open Hospital.

**On Windows, to manually run oh.ps1 (powershell script):**

- right-click on **oh.ps1** -> Properties -> General -> Security
- select "Unblock"
- right click on **oh.ps1** and select "Run with Powershell"
- choose among available options

It s also possible to start Open Hospital with the legacy batch file (old oh.bat):
- open cmd.exe and run **.\oh.bat -legacymode** 
- to see available options, open a cmd.exe window and run **.\oh.bat -h**

# Default directory structure

The scripts take care of creating all the needed data directories and configuration files
Everything is also parametric and user adjustable in the scripts with variables (or via command line options).
The default is now clean, simple and **common to all distros:**

```
/oh -> Open Hospital distribution
/sql -> containing the SQL creation scripta
/etc -> configuration files for database (MySQL)
```
Created at runtime:
```
/tmp 
/data
data/db
data/log
data/dicom_storage
```
External software package downloaded at first run:

```
Mariadb 10.2.37 server
OpenJDK JRE 11
```

# Known issues

**Linux**

- If you get this error:

```
Error on creating OH Database error while loading shared libraries: libncurses.so.5.
```

You have to install the ncurses librares, on Ubuntu:

```
sudo apt-get install libncurses5
```

- If you get this error:
```
Error Initializing MySQL database on port 3306 error while loading shared libraries: libaio.so.1. I had to install it manually and re-launch the script.
```

You have to install the libaio libraries, on Ubuntu:

```
sudo apt-get install libaio1 
```

- If you select languages en-fr-it, a ICD10 patologies subset is loaded at startup, languages es-pt don't.

**Windows**

Dicom functionalities are only available on 32bit JAVA environment. If DICOM is needed, 32bit jre is mandatory.
If you need DICOM on Windows 64 bit set **DICOM_ENABLE="true"** in the script.

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
- You might also be required to enable access to oh.ps1 on Windows Firewall.


If you are using the legacy version, you might to download and unzip java ad mysql manually.

- download and unzip Java:
```
wget  https://github.com/AdoptOpenJDK/openjdk11-binaries/releases/download/jdk-11.0.9.1%2B1/OpenJDK11U-jre_x64_windows_hotspot_11.0.9.1_1.zip
unzip OpenJDK11U-jre_x64_windows_hotspot_11.0.9.1_1.zip
```
- download and unzip mysql (mariadb):
```
wget  https://downloads.mariadb.com/MariaDB/mariadb-10.2.37/winx64-packages/mariadb-10.2.37-winx64.zip
unzip mariadb-10.2.37-winx64.zip
```

# New oh.sh / oh.ps1

In order to have a complete, easy to support and extensible solution to run Open Hospital on Linux, oh.sh has been rewritten, also adding a few possible useful user functions.
For the same reason, a completely new powershell script has been writtend for Windows: oh.ps1 (run by oh.bat).

I have widely tested and they seems to be working well (Ubuntu 20.04 64bit /  Windows 10 64bit), solving also a few old outstanding bugs (mysql not always starting or shutting down, wrong socket references, hard coded values, etc. etc.)

A short description of changes for the Linux version (mostly the same behavior and options are applicable to the windows oh.ps1 version):

- Complete overhaul of the code, reworked the entire scripts
- Everything is now based on functions and parametric variables
- Menu based, interactive options for many operations: see **./oh.sh -h** (or see below for short description)
- **Unified script** for:
    Portable 64bit (default) and 32bit (with automatic architecture detection)
    Open Hospital client (no more separated startup.sh is needed ;-) (**it is now possible to package every linux distro, client/portable/32 or 64 bit with a single package**)
- **New**: Language support (both via variable in the script or user input option: **oh.sh -l fr**)
- **New**: Demo database support (See oh.sh -D)
- **New**: Client mode support (see oh.sh -C)
- **New**: Save (see oh.sh -s) / Restore (oh.sh -r) database, available also for Portable mode !
- **New**: GSM setup integrated via -G command line option - setupGSM.sh (https://github.com/informatici/openhospital-gui/blob/develop/SetupGSM.sh) is obsolete now
- **New**: debug mode -> set log4.properties to DEBUG mode (default is INFO)
- **New**: manual config mode (set MANUAL_CONFIG=on in script) -> mysql and oh configuration files are not generated automatically or overwritten, useful for testing
- **New**: test database connection option (see oh.sh -t)
- **New**: displayes software versions and current configuration (see oh.sh -v)
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
- Added support for **MariaDB** - (tested with mariadb-10.2.37) (OH seems faster and more responsive)
- Updated MySQL db and user creation syntax (now compatible with MySQL 8 - unsupported)
- Fixed _a_few_ bugs ;-)


For more informations see:
https://github.com/informatici/openhospital/pull/149

https://github.com/informatici/openhospital/pull/143

https://github.com/informatici/openhospital/pull/142

And also:
https://github.com/informatici/openhospital-core/pull/241


Comments, suggestions and requests are welcome !



Bugs, issues and feature requests should be reported on
our repository on GitHub: https://github.com/informatici/openhospital

*last updated: 09.05.2021*

