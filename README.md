# Open Hospital Client - POH 

Open Hospital (https://www.open-hospital.org/en/) is a free and open source
software for healthcare data management. Its portable version (Portable Open
Hospital, POH) allows you to take along with you Open Hospital and run it on
any computer, keeping the data you have saved. With POH, we also hope to
reach the goal to make Open Hospital easily installable so that even somebody
with no experience of Java or MySQL can try or use it.

OH allows to use Open Hospital on a computer, easily move the installation on
another computer or even run it from a USB stick or drive. All you have to do
is to copy the root installation directory of POH to your favourite path, where
the program and the data will be kept. POH uses its own version of the Java Virtual
Machine and the MySQL server and everything is contained in the root
installation directory. POH is released under the GNU GPL 3.0 License.

The Linux version has been tested on different distributions and versions,
including Ubuntu 16.04 i386 (32bit) and up to Ubuntu 20.04 x64 (64bit).
The Windows version has been tested on Windows 10.

# Running POH - Ultra quickstart

on Linux:

 bash <(wget -qO- https://raw.githubusercontent.com/mizzioisf/openhospital-client/main/go.sh)

on Windows (standard batch file) :

 - dowload oh.bat
 - run it

on Windows (experimental powershell script) :

 - download oh.ps1
 - run it 

# Running POH - Quickstart

- unzip the package in any directory
- browse to the directory
- on Windows, start POH by double clicking on the oh.bat batch file
- on Linux, start POH by running ./oh.sh
- on Linux, to see available options, run ./oh.sh -h

# Running POH - Windows: oh.bat (cmd batch file)

- clone the repository: git clone https://github.com/mizzioisf/openhospital-client
- cd to the repo directory: cd openhospital-client
- download and unzip java:
```
wget  https://github.com/AdoptOpenJDK/openjdk11-binaries/releases/download/jdk-11.0.9.1%2B1/OpenJDK11U-jre_x64_windows_hotspot_11.0.9.1_1.zip
unzip OpenJDK11U-jre_x64_windows_hotspot_11.0.9.1_1.zip
```
- download and unzip mysql:
```
wget  https://downloads.mysql.com/archives/get/p/23/file/mysql-5.7.30-linux-glibc2.12-win64
unzip mysql-5.7.30-linux-glibc2.12-win64.zip
```
- run oh.bat

# Running POH - Windows: powershell (oh.ps1)

- clone the repository:
```
git clone https://github.com/mizzioisf/openhospital-client
```
- cd to the repo directory: cd openhospital-client
- run oh.ps1

# Default dir structure for all distributions:

We don't need to have or pack empty directories anymore: the scripts take care of crating everything, which is also parametric and user adjustable.
The default is now clean and simple and common to all distros:

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

# New oh.sh

In order to have a complete, easy to support and extensible solution to run Open Hospital on linux and Windows WSL, oh.sh has been rewritteng, also adding a few possible useful user functions.

I have widely tested it and it seems to be working well (Ubuntu 20.04 64bit), solving also a few old outstanding bugs (mysql not always starting or shutting down, wrong socket references, hard coded values, etc. etc.)

Description of changes:
- Complete overhaul of the code, reworked the entire script
- Everything is now based on functions and parametric variables
- Menu based, interactive options for many operations: see **./oh.sh -h** (or see below for short description)
- **Unified script** for:
    Portable 64bit (default) and 32bit (with automatic architecture detection)
    Open Hospital client (no more separated startup.sh is needed ;-) (**it is now possible to package every linux distro, client/portable/32 or 64 bit with a single package**)
- **New**: Language support (both via variable in the script or user input option: **oh.sh -l fr**)
- **New**: Demo database support (See oh.sh -D)
- **New**: Save / Restore database also for Portable distro !
- **New**: GSM setup integrated via -G command line option - setupGSM.sh (https://github.com/informatici/openhospital-gui/blob/develop/SetupGSM.sh) is obsolete now
- **New**: debug mode -> set log4.properties to DEBUG mode (default is INFO)
- **New**: manual config mode (set MANUAL_CONFIG=on in script) -> mysql and oh configuration files are not generated automatically or overwritten, useful for testing
- Centralized variable managing (see related config file changes applied): now all (well, almost all, still some "isf" reference in SQL creation script...that will be removed ;-) references to database password, mysql host, etc. etc. are in the script and can be easily adapted / modified for any need
- More flexible execution and configuration options
- Automation of configuration files generation
- Everything is commented in the code and a brief output all operations is shown in console
- Startup and database operations are logged to configurable output file
- Backward compatible with old versions and installations, no default behaviour change
- Added sql subdirectory to organize sql creation scripts
- Added various checks about correct settings of parameters and startup of services
- Added security controls (no more _rm -rf_ here and there :-)
- Added support for **MariaDB** - (tested with mariadb-10.2.36-linux-x86_64) (POH seems faster and more responsive)
- Updated MySQL db and user creation syntax (now compatible with MySQL 8 - unsupported)
- Fixed _a_few_ bugs ;-)

Still working on:
- Porting to powershell :-)


For more informations see:
https://github.com/informatici/openhospital/pull/149

https://github.com/informatici/openhospital/pull/143

https://github.com/informatici/openhospital/pull/142

And also:
https://github.com/informatici/openhospital-core/pull/241


Comments, suggestions and requests are welcome !

--------------------

```
 Portable Open Hospital Client - OH

 Usage: oh.sh [-option]

   -l    en|fr|it|es|pt   --> set language [default: oh.sh -l en]

   -s    save OH database
   -r    restore OH database
   -c    clean POH installation
   -d    start POH in debug mode
   -C    start Open Hospital - Client / Server mode
   -t    test database connection (Client mode only)
   -v    show POH version information
   -D    start POH in Demo mode
   -G    Setup GSM
   -h    show this help


```


Bugs, issues and feature requests should be reported on
our repository on GitHub: https://github.com/informatici/openhospital
