@echo off
set "TOMCAT_HOME=C:\apache-tomcat-11.0.15-windows-x64\apache-tomcat-11.0.15"
set "PROJECT_DIR=d:\online-examination-system"

echo [1/6] Checking ports...
netstat -ano | findstr :8080
if %ERRORLEVEL%==0 (
    echo Port 8080 is in use, attempting to kill java.exe...
    taskkill /F /IM java.exe
)

echo [2/6] Stopping Tomcat (just in case)...
call "%TOMCAT_HOME%\bin\shutdown.bat" >nul 2>&1
timeout /t 3 /nobreak >nul

echo [3/6] Cleaning previous deployment...
if exist "%TOMCAT_HOME%\webapps\online-examination-system" (
    rmdir /S /Q "%TOMCAT_HOME%\webapps\online-examination-system"
)
if exist "%TOMCAT_HOME%\webapps\online-examination-system.war" (
    del /F /Q "%TOMCAT_HOME%\webapps\online-examination-system.war"
)

echo [4/6] Copying new WAR file...
copy "%PROJECT_DIR%\online-examination-system.war" "%TOMCAT_HOME%\webapps\"
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] Failed to copy WAR file! Exiting.
    pause
    exit /b
)

echo [5/6] Starting Tomcat...
cd "%TOMCAT_HOME%\bin"
start startup.bat

echo [6/6] Done! Server launched in new window.
echo Please wait 10-15 seconds for startup to finish.
echo Then go to: http://localhost:8080/online-examination-system/
pause
