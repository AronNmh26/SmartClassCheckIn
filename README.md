# Smart Class Check-in App

A Flutter app for university class attendance and reflection. Students check in with GPS and QR, share a quick mood and topic expectation, and complete a short reflection after class.

## Features
- Modern home dashboard with hero header, stats, and quick actions
- Step-by-step check-in and finish flows with progress feedback
- GPS location capture
- QR code scanning with manual entry fallback
- Pre-class mood and topic prompts
- Post-class reflection and feedback
- Local data storage using SharedPreferences

## Setup
1. Install Flutter: https://docs.flutter.dev/get-started/install
2. From the project root, fetch dependencies:

```bash
flutter pub get
```

## Run
- Mobile or desktop:

```bash
flutter run
```

- Web (Chrome):

```bash
flutter run -d chrome
```

## Build Web
```bash
flutter build web
```

## Deploy to Firebase Hosting
1. Initialize Hosting (public directory: `build/web`, SPA: Yes).
2. Deploy:

```bash
firebase deploy --only hosting
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
<key>NSLocationAlwaysAndWhenInUseUsageDescription</key>
<string>Location access is required to verify classroom check-in.</string>
```

## Notes
- Data is stored locally for this MVP (no cloud sync).
- Web location requires HTTPS and browser permission.
- If iOS permission is permanently denied, enable it in Settings.
