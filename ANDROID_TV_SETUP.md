# Android TV Setup Guide

## ✅ Completed Configuration

### 1. Android Manifest Configuration
The `android/app/src/main/AndroidManifest.xml` has been updated with:
- ✅ Leanback support declaration (`android.software.leanback`)
- ✅ Touchscreen not required (`android.hardware.touchscreen`)
- ✅ TV launcher intent filter (`LEANBACK_LAUNCHER`)
- ✅ Banner reference for TV home screen

### 2. TV Banner
- ✅ Created placeholder banner at `android/app/src/main/res/drawable/banner.xml`
- ⚠️ **TODO**: Replace with actual 320x180 px PNG image named `banner.png`

## 📋 Next Steps

### 1. Replace Banner Image
Create a proper banner image:
- Size: 320x180 pixels
- Format: PNG
- Location: `android/app/src/main/res/drawable/banner.png`
- Delete the placeholder `banner.xml` after adding the PNG

### 2. Add D-pad Navigation Support
For better TV remote control support, add these packages to `pubspec.yaml`:

```yaml
dependencies:
  # For D-pad navigation
  flutter_android_tv_text_field: ^1.0.0  # Better text input for TV
  # OR
  dpad: ^0.1.0  # D-pad navigation helper
```

Then run:
```bash
flutter pub get
```

### 3. Design Considerations for TV
- Use larger touch targets (minimum 48x48 dp)
- Ensure all interactive elements are focusable
- Test navigation with D-pad (up, down, left, right)
- Avoid default `TextField` widgets - use TV-compatible alternatives
- Design for 10-foot viewing distance (larger text, clear contrast)

### 4. Build and Deploy

#### Build APK
```bash
flutter build apk
```

The APK will be generated at: `build/app/outputs/apk/release/app-release.apk`

#### Install on Android TV

**Option 1: ADB (Recommended)**
```bash
# Connect TV via USB or network
adb connect <TV_IP_ADDRESS>:5555

# Install APK
adb install build/app/outputs/apk/release/app-release.apk
```

**Option 2: USB Drive**
1. Copy APK to USB drive
2. Enable "Unknown sources" in TV settings
3. Use a file manager app on TV to install

**Option 3: Android Studio**
1. Connect TV with USB debugging enabled
2. Run directly from Android Studio

### 5. Testing Checklist
- [ ] App appears in TV launcher
- [ ] Banner displays correctly on TV home screen
- [ ] All screens navigable with D-pad
- [ ] Text input works with TV remote
- [ ] Focus indicators are visible
- [ ] UI elements are readable from distance
- [ ] No touch-only interactions

## 🔧 Troubleshooting

### App doesn't appear in TV launcher
- Check LEANBACK_LAUNCHER intent filter is present
- Verify banner image exists and is referenced correctly

### Navigation issues
- Implement proper focus management
- Use `FocusNode` and `FocusScope` for custom navigation
- Consider using TV navigation packages

### Text input problems
- Replace default `TextField` with `flutter_android_tv_text_field`
- Test with TV remote keyboard

## 📚 Useful Resources
- [Android TV Developer Guide](https://developer.android.com/training/tv)
- [Flutter TV Apps](https://flutter.dev/docs/development/platform-integration/android/tv)
- [D-pad Navigation Package](https://pub.dev/packages/dpad)
