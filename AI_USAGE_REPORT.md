# AI Usage Report

## Project
- Name: Smart Class Check-in App
- Repo: https://github.com/AronNmh26/SmartClassCheckIn.git
- Date: 2026-03-13

## Purpose of AI Assistance
- Configure Flutter tooling on Windows
- Guide Firebase Hosting deployment for Flutter Web
- Set up Git and push project to GitHub
- Improve the app UI and update documentation

## Summary of Work Completed
- Verified Flutter installation and added `C:\flutter\bin` to PATH for current session and user
- Built Flutter web output (`build/web`)
- Initialized Firebase Hosting and corrected `firebase.json` public directory to `build/web`
- Deployed to Firebase Hosting multiple times after UI updates
- Installed Git, initialized the repo, and pushed to GitHub
- Added `.firebase/` and `public/` to `.gitignore` to avoid committing generated artifacts
- Updated the UI theme, home dashboard, and flow screens
- Added Google Fonts and refreshed typography
- Added iOS location permission keys to `Info.plist`
- Updated README and User Guide to match the new UI

## Commands Executed (High Level)
- Flutter
  - `flutter --version`
  - `flutter pub get`
  - `flutter build web`
  - `flutter run -d chrome`
- Firebase
  - `firebase init hosting`
  - `firebase deploy --only hosting`
- Git
  - `git init`
  - `git add .`
  - `git commit -m "Initial commit"`
  - `git branch -M main`
  - `git remote add origin <repo-url>`
  - `git push -u origin main`

## Files Modified or Created by AI
- `firebase.json` (set Hosting public directory to `build/web`)
- `.gitignore` (added `.firebase/` and `public/`)
- `lib/main.dart` (theme and font updates)
- `lib/screens/home_screen.dart` (new dashboard layout and header chips)
- `lib/screens/checkin_screen.dart` (refined step layout and progress)
- `lib/screens/finish_screen.dart` (refined step layout and progress)
- `lib/screens/qr_scan_screen.dart` (improved scan UI)
- `lib/widgets/mood_selector.dart` (new chip-based selector)
- `pubspec.yaml` (added `google_fonts` dependency)
- `ios/Runner/Info.plist` (added location permission strings)
- `README.md` and `UserGuide.md` (updated to match new UI)
- `AI_USAGE_REPORT.md` (this report)

## External Services Used
- Firebase Hosting (deployment target)
- GitHub (source control hosting)

## Limitations / Notes
- WebAssembly compatibility warnings were observed for some web plugins; these do not block standard web builds.
- Web location requires HTTPS and user permission.
- iOS location requires permission approval in Settings if previously denied.

## Output URLs
- Firebase Hosting: https://smart-class-check-in-app-2602e.web.app

## Responsible Use Notes
- The AI suggested commands and applied configuration changes based on user confirmation.
- No secrets or credentials were stored in the repository by the AI.
