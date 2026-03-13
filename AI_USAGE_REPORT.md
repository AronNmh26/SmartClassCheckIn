# AI Usage Report

## Project
- Name: Smart Class Check-in App
- Repo: https://github.com/AronNmh26/SmartClassCheckIn.git
- Date: 2026-03-13

## Purpose of AI Assistance
- Helped configure Flutter tooling on Windows
- Guided Firebase Hosting deployment for Flutter Web
- Set up Git and pushed project to GitHub

## Summary of Work Completed
- Verified Flutter installation and added `C:\flutter\bin` to PATH for current session and user
- Built Flutter web output (`build/web`)
- Initialized Firebase Hosting and corrected `firebase.json` public directory to `build/web`
- Deployed to Firebase Hosting
- Installed Git and initialized repository
- Added `.firebase/` and `public/` to `.gitignore` to avoid committing generated artifacts
- Committed and pushed to GitHub

## Commands Executed (High Level)
- Flutter
  - `flutter --version`
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

## External Services Used
- Firebase Hosting (deployment target)
- GitHub (source control hosting)

## Limitations / Notes
- WebAssembly compatibility warnings were observed for some web plugins; these do not block standard web builds.
- Firebase Hosting initialized to `public` initially; corrected to `build/web` for Flutter web output.

## Output URLs
- Firebase Hosting: https://smart-class-check-in-app-2602e.web.app

## Responsible Use Notes
- The AI suggested commands and applied configuration changes based on user confirmation.
- No secrets or credentials were stored in the repository by the AI.
