echo off
Title Bundle FDS and Smokeview for 64 bit OSX
Rem Batch file used to bundle a 64 bit OSX of FDS/Smokeview

set envfile="%userprofile%\fds_smv_env.bat"
IF EXIST %envfile% GOTO endif_envexist
echo ***Fatal error.  The environment setup file %envfile% does not exist. 
echo Create a file named %envfile% and use SMV/scripts/fds_smv_env_template.bat
echo as an example.
echo.
echo Aborting now...
pause>NUL
goto:eof

:endif_envexist

Rem location of batch files used to set up Intel compilation environment

call %envfile%

set bundledir=FDS_%fds_version%-SMV_%smv_version%_osx64
plink %osx_logon% %linux_svn_root%/Utilities/Scripts/BUNDLE_osx64.sh %linux_svn_root% %bundledir% %osx_hostname% %fds_edition%  %fds_version% %smv_version% %fdssmv_major_version%

set manifest=%svn_root%\Utilities\uploads\manifest_osx_64.html
echo Downloading manifest
erase %manifest%
pscp %osx_logon%:manifest_osx_64.html %manifest%
start explorer %manifest%

echo Downloading compressed archive to:
echo   %svn_root%\Utilities\uploads\%bundledir%.sh
pscp %osx_logon%:%linux_svn_root%/Utilities/uploads/%bundledir%.sh %svn_root%/Utilities/uploads/.

pause
