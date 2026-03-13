# PRD.md

## 1. App Overview
Smart Class Check-in & Learning Reflection App is a mobile-first prototype that enables university students to check in to class, confirm participation, and submit short learning reflections. The app verifies presence and engagement using GPS location, QR code scans, and brief pre/post-class prompts.

## 2. Target Users
- University students attending in-person classes
- Instructors or teaching assistants who need lightweight attendance and reflection signals

## 3. Problem Statement
Universities need a simple, low-friction way to confirm that students are physically present in class and participating, while also capturing quick learning reflections without adding administrative burden.

## 4. Solution
Provide a two-step flow in a Flutter app:
- Before class: Students check in by scanning a QR code, capturing GPS and time, and answering short pre-class prompts.
- After class: Students finish class by scanning the QR code again, capturing GPS and time, and submitting a brief learning reflection and feedback.
Data is stored locally for the MVP and can be surfaced via a Firebase-hosted web component.

## 5. App Category
Education / Campus Productivity

## 6. Core Features (MVP)
- Home screen with entry points to Check-in and Finish Class
- Check-in flow
- Capture GPS location and timestamp
- Scan class QR code
- Pre-class questions: previous topic, expected topic, pre-class mood (1–5)
- Finish class flow
- Capture GPS location and timestamp
- Scan class QR code
- Post-class questions: what learned, feedback
- Local data storage for check-ins and completions (localStorage/SQLite)
- Basic validation to ensure required fields and successful GPS/QR capture

## 7. User Journey
1. Student opens app and sees Home screen.
2. Taps Check-in before class.
3. App captures GPS and time, scans class QR code.
4. Student completes pre-class prompts and submits.
5. At class end, student taps Finish Class.
6. App captures GPS and time, scans QR code again.
7. Student completes post-class prompts and submits.
8. Submission is stored locally and can be displayed or synced later.

## 8. Data Model
CheckIn
- id (string, UUID)
- studentId (string, optional for MVP)
- classId (string, derived from QR code)
- checkInTimestamp (datetime)
- gpsLat (number)
- gpsLng (number)
- prevTopic (string)
- expectedTopic (string)
- preMoodScore (int 1–5)

CheckOut
- id (string, UUID)
- studentId (string, optional for MVP)
- classId (string, derived from QR code)
- checkOutTimestamp (datetime)
- gpsLat (number)
- gpsLng (number)
- learnedToday (string)
- feedback (string)

QR Payload (example)
- classId
- sessionId (optional)
- date

Mood Scale
- 1: Very negative
- 2: Negative
- 3: Neutral
- 4: Positive
- 5: Very positive

## 9. Technology Stack
- Flutter (mobile plus optional web build)
- Firebase Hosting (deploy web demo or landing page)
- Local storage: SharedPreferences or SQLite (MVP)
- QR scanning: mobile_scanner or equivalent
- GPS: geolocator or equivalent

## 10. MVP Scope
Included:
- Three screens (Home, Check-in, Finish Class)
- GPS capture, QR scan, and form input
- Local storage of submissions
- Simple Firebase-hosted page (web build or landing page)

Excluded for MVP:
- Authentication and roles
- Instructor dashboards
- Real-time attendance validation
- Offline/online sync or analytics
- Advanced QR session management
