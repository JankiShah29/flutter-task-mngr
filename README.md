# interview_test

A Flutter task management app for creating, viewing, and updating tasks.

## App Overview

This app is built with Flutter and uses Firebase for authentication and task storage.
It provides user registration, login, a dashboard with a quote, and a task list where users can add, edit, complete, and delete tasks.

## Main Screens

- **Register**: Create a new account with email, password, and confirm password.
- **Login**: Sign in using registered credentials.
- **Dashboard**: Shows a daily quote and a button to navigate to the task list.
- **Tasks List**: Displays tasks in a styled card list, allows marking tasks as completed/pending, editing, and deleting.
- **Create Task**: Add a new task or edit an existing one with title, description, and date.

## How the App Works

1. **Registration and Login**
   - Users register with email and password.
   - After registration, users are redirected to the login screen.
   - Successful login navigates to the dashboard.

2. **Dashboard**
   - Fetches and displays a motivational quote from an API.
   - Provides a button to open the task list.

3. **Task List**
   - Loads tasks from Firebase using `TaskDbService`.
   - Shows each task with title, date, description, and status badge.
   - Users can edit a task, toggle its completion status, or delete it.

4. **Create / Edit Task**
   - Users can enter a title, description, and select a date.
   - Tasks can be created or updated and saved back to Firebase.
   - The updated task is returned to the list and refreshed in-place.

## Project Structure

- `lib/main.dart` - App entry point.
- `lib/screens/` - Screen widgets for authentication, dashboard, task list, and task creation.
- `lib/models/` - Data model definitions, including tasks and quote objects.
- `lib/services/` - Firebase and API services for auth, tasks, and external quote API calls.
- `lib/widgets/` - Reusable UI components like buttons, input fields, and auth helper widgets.

## Run the App

1. Install Flutter and set up your environment:
   - https://docs.flutter.dev/get-started/install
2. Open the project folder in your IDE.
3. Run dependency install:
   ```bash
   flutter pub get
   ```
4. Launch on a connected device or emulator:
   ```bash
   flutter run
   ```

## Notes

- Ensure Firebase is configured correctly via `firebase_options.dart` and platform-specific files.
- The app expects Firebase authentication and a task database service to be available.
- If the Firebase or API keys are not configured, some features may not work fully.
