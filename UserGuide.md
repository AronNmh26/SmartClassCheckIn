# User Guide

This guide explains how to use the Smart Class Check-in App.

## Start the app
1. Install Flutter: https://docs.flutter.dev/get-started/install
2. From the project root, run:

```bash
flutter pub get
flutter run
```

## Home screen
The home screen includes:
- A welcome header and quick overview
- Today stats for check-ins and completions
- Quick Actions to start Check-in or Finish Class
- A short How It Works checklist

## Check-in flow
1. Tap **Check-in**.
2. Tap **Capture GPS Location**.
3. Tap **Scan Class QR Code** and scan the class QR.
4. Enter the previous class topic and expected topic.
5. Select a mood.
6. Tap **Submit Check-in**.

## Finish class flow
1. Tap **Finish Class**.
2. Tap **Capture GPS Location**.
3. Tap **Scan Class QR Code** and scan the class QR.
4. Enter what you learned and optional feedback.
5. Tap **Submit Completion**.

## Troubleshooting
- If location is permanently denied on iOS, go to **Settings > Privacy & Security > Location Services > Smart Class Checkin** and allow **While Using the App**.
- The web app needs HTTPS and browser permission to access location.
