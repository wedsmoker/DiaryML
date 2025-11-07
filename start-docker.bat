@echo off
setlocal enabledelayedexpansion
REM DiaryML Docker Startup Script for Windows
REM Detects your local IP and starts Docker container

echo ============================================================
echo DiaryML - Docker Startup
echo ============================================================
echo.

REM Detect local IP (looks for IPv4 starting with 192.168)
for /f "tokens=2 delims=:" %%a in ('ipconfig ^| findstr /c:"IPv4 Address"') do (
    set IP_TEMP=%%a
    set IP_TEMP=!IP_TEMP: =!
    echo !IP_TEMP! | findstr /b "192.168" >nul
    if !errorlevel! == 0 (
        set LOCAL_IP=!IP_TEMP!
        goto :found
    )
)

:found
if "%LOCAL_IP%"=="" (
    echo.
    echo WARNING: Could not auto-detect your local IP
    echo Find it with: ipconfig
    echo Look for "IPv4 Address" starting with 192.168
    echo.
    set /p LOCAL_IP="Enter your local IP (e.g., 192.168.1.100): "
)

echo.
echo Starting DiaryML Docker container...
docker-compose up -d

echo.
echo ============================================================
echo DiaryML is running!
echo ============================================================
echo.
echo   Desktop: http://localhost:8000
echo   Mobile:  http://%LOCAL_IP%:8000/api
echo.
echo   Enter the Mobile URL in your phone's DiaryML app
echo ============================================================
echo.
echo To stop: docker-compose down
echo To view logs: docker-compose logs -f diaryml
echo.
pause
