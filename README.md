# emvigo_machine_task

A Flutter app for user authentication and profile creation with Firebase integration.

## Architecture

The project follows a simple layered structure:

- `lib/views` contains the UI screens such as login, registration, and profile creation.
- `lib/controllers/auth_bloc` contains the authentication repository logic used by the app.
- `lib/models` defines the data models used throughout the app.
- `lib/widgets` contains reusable UI components such as custom text fields and filled buttons.
- `lib/constants` stores shared color and text constants.

This keeps the UI screens focused on presentation while the repository handles Firebase operations.

## Packages Used

The app uses the following main packages:

- `flutter` - Flutter SDK
- `firebase_core` - Firebase initialization
- `firebase_auth` - Authentication with Firebase
- `cloud_firestore` - Firestore database access
- `flutter_bloc` - State management support

## Setup Instructions

1. Install Flutter SDK on your machine.
2. Clone the project and open it in your IDE.
3. Run the following command to install dependencies:

   ```bash
   flutter pub get
   ```

4. Make sure Firebase is configured for your project.
   - Create a Firebase project.
   - Add Android/iOS/Web apps as needed.
   - Download the Firebase config files and place them in the correct location.

5. Run the app:

   ```bash
   flutter run
   ```

## Notes

- The app uses Firebase Authentication for sign-in and registration.
- User profile information is stored in the Firestore `users` collection.
- The profile creation screen collects basic user details such as name, date of birth, gender, nationality, and language.
