@echo off
setlocal EnableExtensions EnableDelayedExpansion

set "USEJAVA_HOME=%~dp0.."
set "PS_SCRIPT=%USEJAVA_HOME%\scripts\usejava.ps1"

if "%~1"=="" goto help
if "%~1"=="help" goto help
if "%~1"=="list" goto list
if "%~1"=="active" goto active
if "%~1"=="doctor" goto doctor
if "%~1"=="default" goto default
if "%~1"=="add" goto add
if "%~1"=="remove" goto remove

goto switch

:help
powershell -NoProfile -ExecutionPolicy Bypass -Command ". '%PS_SCRIPT%'; usejava help"
goto finish

:list
powershell -NoProfile -ExecutionPolicy Bypass -Command ". '%PS_SCRIPT%'; usejava list"
goto finish

:active
echo.
echo Active Environment
echo -------------------------------------
echo JAVA_HOME  = %JAVA_HOME%
echo MAVEN_HOME = %MAVEN_HOME%
echo.
java -version
echo.
mvn -version
echo.
goto finish

:doctor
powershell -NoProfile -ExecutionPolicy Bypass -Command ". '%PS_SCRIPT%'; usejava doctor"
goto finish

:default
powershell -NoProfile -ExecutionPolicy Bypass -Command ". '%PS_SCRIPT%'; usejava default '%~2'"
goto finish

:add
powershell -NoProfile -ExecutionPolicy Bypass -Command ". '%PS_SCRIPT%'; usejava add '%~2' '%~3' '%~4'"
goto finish

:remove
powershell -NoProfile -ExecutionPolicy Bypass -Command ". '%PS_SCRIPT%'; usejava remove '%~2'"
goto finish

:switch
for /f "tokens=1,2 delims==" %%A in ('powershell -NoProfile -ExecutionPolicy Bypass -Command "$c=Get-Content '%USEJAVA_HOME%\config\versions.json' -Raw | ConvertFrom-Json; $v=$c.versions.PSObject.Properties['%~1']; if($v){ Write-Output ('JAVA_HOME=' + $v.Value.javaHome); Write-Output ('MAVEN_HOME=' + $v.Value.mavenHome) }"') do (
    if "%%A"=="JAVA_HOME" set "JAVA_HOME=%%B"
    if "%%A"=="MAVEN_HOME" set "MAVEN_HOME=%%B"
)

if "%JAVA_HOME%"=="" (
    echo Version not found: %~1
    echo Run: usejava list
    goto finish
)

if not exist "%JAVA_HOME%" (
    echo JAVA_HOME not found: %JAVA_HOME%
    goto finish
)

if not exist "%MAVEN_HOME%" (
    echo MAVEN_HOME not found: %MAVEN_HOME%
    goto finish
)

set "PATH=%JAVA_HOME%\bin;%MAVEN_HOME%\bin;%PATH%"

echo.
echo Switched to Java %~1
echo JAVA_HOME  = %JAVA_HOME%
echo MAVEN_HOME = %MAVEN_HOME%
echo.
java -version
echo.
mvn -version
echo.

:finish
endlocal & (
    set "JAVA_HOME=%JAVA_HOME%"
    set "MAVEN_HOME=%MAVEN_HOME%"
    set "PATH=%PATH%"
)