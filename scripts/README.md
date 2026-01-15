# TV Emulator Deployment Scripts

Quick scripts for deploying and testing on Android TV emulator.

## Scripts

### 1. `deploy_tv.bat` - Full Deployment
Complete deployment with detailed output and pause at end.

**Usage:**
```bash
scripts\deploy_tv.bat
```

**What it does:**
1. Builds debug APK
2. Installs on TV emulator (emulator-5554)
3. Clears logs
4. Launches app
5. Shows completion message

---

### 2. `quick_deploy.bat` - Rapid Testing
Fast deployment without pauses - perfect for rapid iteration.

**Usage:**
```bash
scripts\quick_deploy.bat
```

**What it does:**
- Builds → Installs → Launches (all in one command)
- No pauses, returns immediately

---

### 3. `view_logs.bat` - Live Logs
View live Flutter logs from TV emulator.

**Usage:**
```bash
scripts\view_logs.bat
```

**What it does:**
- Shows live Flutter logs
- Press Ctrl+C to stop

---

## Quick Commands

### Deploy and watch logs (two terminals):
**Terminal 1:**
```bash
scripts\deploy_tv.bat
```

**Terminal 2:**
```bash
scripts\view_logs.bat
```

### Rapid testing loop:
```bash
# Make code changes, then:
scripts\quick_deploy.bat
```

---

## Requirements

- Android TV emulator running (emulator-5554)
- ADB installed at: `%LOCALAPPDATA%\Android\sdk\platform-tools\adb.exe`
- Flutter SDK in PATH

---

## Troubleshooting

### Emulator not found
Make sure TV emulator is running:
```bash
flutter emulators --launch Television_4K
```

### Check connected devices
```bash
flutter devices
```

### Manual ADB commands
```bash
# List devices
adb devices

# Install APK
adb -s emulator-5554 install -r build\app\outputs\flutter-apk\app-debug.apk

# Launch app
adb -s emulator-5554 shell am start -n com.example.urock_media_movie_app/.MainActivity

# View logs
adb -s emulator-5554 logcat -s flutter:I
```
