@echo off
setlocal EnableExtensions EnableDelayedExpansion

set "USEJAVA_HOME=%~dp0.."
set "CONFIG_FILE=%USEJAVA_HOME%\config\versions.conf"

set "CMD=%~1"

if "%CMD%"=="" goto help
if "%CMD%"=="help" goto help
if "%CMD%"=="-h" goto help
if "%CMD%"=="--help" goto help
if "%CMD%"=="list" goto list
if "%CMD%"=="active" goto active
if "%CMD%"=="add" goto add
if "%CMD%"=="remove" goto remove

goto switch

:help
echo.
echo Java Maven Switcher v2
echo.
echo Usage:
echo   usejava ^<version^>                  Switch Java/Maven version
echo   usejava list                         List configured versions
echo   usejava active                       Show active Java/Maven
echo   usejava add ^<version^> ^<jdk^> ^<mvn^>  Add new version
echo   usejava remove ^<version^>           Remove version
echo   usejava help                         Show help
echo.
echo Examples:
echo   usejava 17
echo   usejava add 21 "C:\Program Files\Java\jdk-21" "C:\Program Files\Maven\apache-maven-3.9.11"
echo   usejava remove 8
echo.
goto finish

:list
echo.
echo Configured Java/Maven Versions:
echo --------------------------------
for /f "usebackq tokens=1,2,3 delims=|" %%A in ("%CONFIG_FILE%") do (
    echo %%A | findstr /b "#" >nul
    if errorlevel 1 (
        if not "%%A"=="" (
            echo %%A
            echo   JAVA_HOME  = %%B
            echo   MAVEN_HOME = %%C
            echo.
        )
    )
)
goto finish

:active
echo.
echo Active Environment:
echo JAVA_HOME  = %JAVA_HOME%
echo MAVEN_HOME = %MAVEN_HOME%
echo.
java -version
echo.
mvn -version
echo.
goto finish

:add
set "VERSION=%~2"
set "JDK_PATH=%~3"
set "MVN_PATH=%~4"

if "%VERSION%"=="" (
    echo Usage: usejava add ^<version^> ^<JAVA_HOME^> ^<MAVEN_HOME^>
    goto finish
)

if "%JDK_PATH%"=="" (
    echo Usage: usejava add ^<version^> ^<JAVA_HOME^> ^<MAVEN_HOME^>
    goto finish
)

if "%MVN_PATH%"=="" (
    echo Usage: usejava add ^<version^> ^<JAVA_HOME^> ^<MAVEN_HOME^>
    goto finish
)

findstr /b /c:"%VERSION%|" "%CONFIG_FILE%" >nul
if not errorlevel 1 (
    echo Version already exists: %VERSION%
    goto finish
)

echo %VERSION%^|%JDK_PATH%^|%MVN_PATH%>>"%CONFIG_FILE%"
echo Added Java version: %VERSION%
goto finish

:remove
set "VERSION=%~2"

if "%VERSION%"=="" (
    echo Usage: usejava remove ^<version^>
    goto finish
)

findstr /b /c:"%VERSION%|" "%CONFIG_FILE%" >nul
if errorlevel 1 (
    echo Version not found: %VERSION%
    goto finish
)

break > "%CONFIG_FILE%.tmp"

for /f "usebackq delims=" %%L in ("%CONFIG_FILE%") do (
    echo %%L | findstr /b /c:"%VERSION%|" >nul
    if errorlevel 1 (
        echo %%L>>"%CONFIG_FILE%.tmp"
    )
)

move /y "%CONFIG_FILE%.tmp" "%CONFIG_FILE%" >nul
echo Removed Java version: %VERSION%
goto finish

:switch
set "TARGET=%CMD%"
set "FOUND=false"

for /f "usebackq tokens=1,2,3 delims=|" %%A in ("%CONFIG_FILE%") do (
    if "%%A"=="%TARGET%" (
        set "FOUND=true"
        set "JAVA_HOME=%%B"
        set "MAVEN_HOME=%%C"
    )
)

if "%FOUND%"=="false" (
    echo Version not found: %TARGET%
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
echo Switched to Java %TARGET%
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