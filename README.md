# Smart Class Check-in & Learning Reflection App

A simple Flutter MVP that lets university students check in to class, verify presence using GPS and QR scanning, and submit short learning reflections.

## Features
- Home screen with Check-in and Finish Class flows
- GPS location capture
- QR code scanning
- Pre-class mood + topic prompts
- Post-class reflection + feedback
- Local data storage using SharedPreferences

## Installation
1. Install Flutter: https://docs.flutter.dev/get-started/install
2. From the project root, fetch dependencies:

```bash
flutter pub get
```

## How to Run the App
1. Ensure you have a device or emulator running.
2. Run the app:

```bash
flutter run
```

## Platform Permissions
This app needs camera and location access for QR scanning and GPS.

### Android
Add these permissions to `android/app/src/main/AndroidManifest.xml`:

```xml
<uses-permission android:name="android.permission.CAMERA" />
<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
<uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />
```

### iOS
Add these keys to `ios/Runner/Info.plist`:

```xml
<key>NSCameraUsageDescription</key>
<string>Camera access is required to scan class QR codes.</string>
<key>NSLocationWhenInUseUsageDescription</key>
<string>Location access is required to verify classroom check-in.</string>
```

## Notes
- Data is stored locally for the MVP (no Firebase sync yet).
- QR code payload is treated as a simple class/session ID string.
