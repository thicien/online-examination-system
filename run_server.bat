@echo on
set "TOMCAT_HOME=C:\apache-tomcat-11.0.15-windows-x64\apache-tomcat-11.0.15"
set "PROJECT_DIR=d:\online-examination-system"

echo [1/8] Stopping Tomcat and cleaning up...
taskkill /F /IM java.exe >nul 2>&1
timeout /t 5 /nobreak >nul

if exist "%TOMCAT_HOME%\webapps\online-examination-system" (
    echo Deleting old directory...
    rmdir /S /Q "%TOMCAT_HOME%\webapps\online-examination-system"
)

if exist "%TOMCAT_HOME%\webapps\online-examination-system.war" (
    echo Deleting old WAR...
    del /F /Q "%TOMCAT_HOME%\webapps\online-examination-system.war"
)

if exist "%TOMCAT_HOME%\work\Catalina\localhost\online-examination-system" (
    echo Deleting Tomcat work directory...
    rmdir /S /Q "%TOMCAT_HOME%\work\Catalina\localhost\online-examination-system"
)

if exist "%TOMCAT_HOME%\temp" (
    echo Cleaning temp directory...
    del /F /Q "%TOMCAT_HOME%\temp\*"
)

:: Verify deletion - Critical Step
if exist "%TOMCAT_HOME%\webapps\online-examination-system.war" (
    echo [ERROR] Failed to delete WAR file! It is locked by another process.
    echo Please manually delete: %TOMCAT_HOME%\webapps\online-examination-system.war
    pause
    exit /b
)

echo [2/8] Compiling...
call "%PROJECT_DIR%\compile.bat"
if %ERRORLEVEL% NEQ 0 (
    echo compilation failed.
    pause
    exit /b
)

echo [3/8] Deploying application...
:: Create directory first
if not exist "%TOMCAT_HOME%\webapps\online-examination-system" (
    mkdir "%TOMCAT_HOME%\webapps\online-examination-system"
)

xcopy /E /I /H /Y /Q "%PROJECT_DIR%\src\main\webapp\*" "%TOMCAT_HOME%\webapps\online-examination-system\"
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] Copy failed!
    pause
    exit /b
)

echo [4/8] Verifying deployment...
if not exist "%TOMCAT_HOME%\webapps\online-examination-system\WEB-INF\classes\com\oes\dao\UserDao.class" (
    echo [ERROR] UserDao.class missing in deployment!
    pause
    exit /b
)

echo [5/8] Starting Tomcat...
cd /d "%TOMCAT_HOME%\bin"
start startup.bat

echo [6/8] Done. Please wait for Tomcat to start.
echo http://localhost:8080/online-examination-system/
pause
