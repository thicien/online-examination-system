@echo on
set "TOMCAT_HOME=C:\apache-tomcat-11.0.15-windows-x64\apache-tomcat-11.0.15"
set "PROJECT_DIR=d:\online-examination-system"
set "SRC_DIR=%PROJECT_DIR%\src\main\java"
set "WEB_INF=%PROJECT_DIR%\src\main\webapp\WEB-INF"
set "CLASSES_DIR=%WEB_INF%\classes"
set "LIB_DIR=%WEB_INF%\lib"

echo [1/4] Setting up environment...
cd /d "%PROJECT_DIR%"

echo [2/4] Cleaning old classes...
if exist "%CLASSES_DIR%" (
    echo Deleting %CLASSES_DIR%...
    rmdir /S /Q "%CLASSES_DIR%"
)
mkdir "%CLASSES_DIR%"

echo [3/4] Listing source files...
dir /s /b "%SRC_DIR%\*.java" > sources.txt
echo Source files found:
type sources.txt

echo [4/4] Compiling...
javac -d "%CLASSES_DIR%" -cp "%TOMCAT_HOME%\lib\servlet-api.jar;%TOMCAT_HOME%\lib\jsp-api.jar;%LIB_DIR%\*" @sources.txt

if %ERRORLEVEL% EQU 0 (
    echo Compilation Successful!
) else (
    echo [ERROR] Compilation Failed!
    exit /b 1
)
