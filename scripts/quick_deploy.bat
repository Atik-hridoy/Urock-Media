@echo off
REM Quick deploy without pause - for rapid testing
flutter build apk --debug && "%LOCALAPPDATA%\Android\sdk\platform-tools\adb.exe" -s emulator-5554 install -r build\app\outputs\flutter-apk\app-debug.apk && "%LOCALAPPDATA%\Android\sdk\platform-tools\adb.exe" -s emulator-5554 shell am start -n com.example.urock_media_movie_app/.MainActivity
