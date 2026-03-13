# User Guide

This guide explains how to install and use the Smart Class Check-in & Learning Reflection App.

## How to install the app
1. Install Flutter from the official guide: https://docs.flutter.dev/get-started/install
2. From the project root, fetch dependencies:

```bash
flutter pub get
```

3. Run the app on a device or emulator:

```bash
flutter run
```

## How to add tasks
This MVP does not include a task feature. Instead, it captures **class check-ins** and **class completions**.

To add a check-in entry:
1. Open the app and tap **Check-in**.
2. Tap **Capture GPS Location**.
3. Tap **Scan Class QR Code** and scan the code.
4. Fill in the pre-class questions and mood.
5. Tap **Submit Check-in**.

To add a completion entry:
1. Open the app and tap **Finish Class**.
2. Tap **Capture GPS Location**.
3. Tap **Scan Class QR Code** and scan the code.
4. Fill in what you learned and optional feedback.
5. Tap **Submit Completion**.

## How to view tasks
This MVP does not include a task list or history screen. Saved check-ins and completions are stored locally in the background.

## How to mark tasks as completed
This MVP does not include tasks. To finish a class session, use **Finish Class** and submit the post-class reflection.
