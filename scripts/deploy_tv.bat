@echo off
echo ========================================
echo   TV Emulator Debug Deployment
echo ========================================
echo.

echo [1/4] Building APK...
call flutter build apk --debug
if %errorlevel% neq 0 (
    echo ERROR: Build failed!
    pause
    exit /b %errorlevel%
)
echo ✓ Build completed
echo.

echo [2/4] Installing APK on TV emulator...
"%LOCALAPPDATA%\Android\sdk\platform-tools\adb.exe" -s emulator-5554 install -r build\app\outputs\flutter-apk\app-debug.apk
if %errorlevel% neq 0 (
    echo ERROR: Installation failed!
    pause
    exit /b %errorlevel%
)
echo ✓ Installation completed
echo.

echo [3/4] Clearing logs...
"%LOCALAPPDATA%\Android\sdk\platform-tools\adb.exe" -s emulator-5554 logcat -c
echo ✓ Logs cleared
echo.

echo [4/4] Launching app...
"%LOCALAPPDATA%\Android\sdk\platform-tools\adb.exe" -s emulator-5554 shell am start -n com.example.urock_media_movie_app/.MainActivity
echo ✓ App launched
echo.

echo ========================================
echo   Deployment Complete!
echo ========================================
echo.
echo To view logs, run: scripts\view_logs.bat
pause
