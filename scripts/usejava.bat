@echo off
setlocal EnableExtensions

REM Java + Maven Version Switcher for Windows CMD

set "JDK8=C:\Program Files\Java\jdk1.8.0_202"
set "JDK17=C:\Program Files\Java\jdk-17"

set "MAVEN363=C:\Program Files\Maven\apache-maven-3.6.3"
set "MAVEN3911=C:\Program Files\Maven\apache-maven-3.9.11"

if "%~1"=="8" (
    set "JAVA_HOME=%JDK8%"
    set "MAVEN_HOME=%MAVEN363%"
    goto update
)

if "%~1"=="17" (
    set "JAVA_HOME=%JDK17%"
    set "MAVEN_HOME=%MAVEN3911%"
    goto update
)

echo Usage: usejava 8 ^| 17
exit /b 1

:update

if not exist "%JAVA_HOME%" (
    echo ERROR: JAVA_HOME not found: %JAVA_HOME%
    exit /b 1
)

if not exist "%MAVEN_HOME%" (
    echo ERROR: MAVEN_HOME not found: %MAVEN_HOME%
    exit /b 1
)

set "PATH=%JAVA_HOME%\bin;%MAVEN_HOME%\bin;%PATH%"

echo.
echo =====================================
echo Active Java + Maven Environment
echo =====================================
echo JAVA_HOME  = %JAVA_HOME%
echo MAVEN_HOME = %MAVEN_HOME%
echo.

java -version
echo.
mvn -version
echo.

endlocal & (
    set "JAVA_HOME=%JAVA_HOME%"
    set "MAVEN_HOME=%MAVEN_HOME%"
    set "PATH=%PATH%"
)