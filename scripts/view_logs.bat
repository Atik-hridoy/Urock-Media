@echo off
echo ========================================
echo   TV Emulator Live Logs
echo ========================================
echo Press Ctrl+C to stop
echo.
"%LOCALAPPDATA%\Android\sdk\platform-tools\adb.exe" -s emulator-5554 logcat -s flutter:I
