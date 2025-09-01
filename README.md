# 🌱 Plant Disease Diary
    A Flutter-based mobile application that helps farmers and plant lovers to identify plant diseases by capturing images.
    The app uses Firebase Authentication, Cloud Firestore, and Firebase Storage to manage users and store diagnosis history.

# APK Link
    https://drive.google.com/file/d/1xnTRi_XMDmi9x78l2kaVZCAl9DeyHYQX/view?usp=sharing

# Features
    Capture Plant Images using a Camera
    Add the plant name and disease name
    Save Diagnosis to Firebase Firestore with user ID, timestamp & image
    User Authentication (# Signup, Login, Google Login)
    Home Screen with Diagnosis History (auto-sync from Firestore)
    Firebase Storage Integration for image uploads
    Modern & Clean UI with Provider State Management

# Tech Stack
    Framework: Flutter (Dart)
    State Management: Provider
    Backend: Firebase Authentication
    Database: Cloud Firestore
    Storage: Firebase Storage

# Project Structure
    lib/
    │── main.dart
    │── screens/
    │   ├── login_screen.dart
    │   ├── signup_screen.dart
    │   ├── home_screen.dart
    │   ├── recognition_screen.dart
    │── provider/
    │   ├── login_provider.dart
    │   ├── recognition_provider.dart
    │── widgets/
    │   ├── round_button.dart
    │── utils/
    │   ├── firebase_constants.dart
    │   ├── theme.dart

# Clone the repository
    git clone https://github.com/your-username/plant-disease-detector.git
    cd plant-disease-detector

# Setup Instructions
 # Clone the repository
    git clone https://github.com/your-username/plant-disease-detector.git
    cd plant-disease-detector

# Install dependencies
    flutter pub get

# Setup Firebase
    Go to Firebase Console
    Create a new project
    Enable Authentication (Email/Password + Google)
    Enable Firestore Database
    Enable Firebase Storage
    Download google-services.json (for Android) and place it in android/app/
    Download GoogleService-Info.plist (for iOS) and place it in ios/Runner/
# Run the app
    flutter run

# Contribution

    Fork the repo
    Create a new branch (feature-branch)
    Commit your changes (git commit -m "Add new feature")
    Push to the branch (git push origin feature-branch)
    Open a Pull Request

# License
      This project is licensed under the MIT License – feel free to use and modify it.

# Author
    Muhammad Siddiq Shah
    Email: shahsiddiq004@gmail.com#

# Video
    https://github.com/user-attachments/assets/e4e19bdb-7b98-43c2-a861-9df74691c4ec



