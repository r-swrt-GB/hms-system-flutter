# HMS-System Mobile App Documentation

![HMS-System Logo](https://health-sciences.nwu.ac.za/sites/health-sciences.nwu.ac.za/files/styles/max_1300x1300/public/files/image/1.png?itok=LnMA_Ypy)

## Table of Contents
1. [Introduction](#introduction)
2. [Prerequisites](#prerequisites)
3. [Installation](#installation)
4. [Running the Application](#running-the-application)
5. [Connecting to the API](#connecting-to-the-api)
6. [Troubleshooting](#troubleshooting)
7. [Contributors](#contributors)

## Introduction

The HMS-System Mobile App is designed for students to interact with the HMS-System platform. This Flutter-based application allows students to view assignments created by lecturers and submit their video responses directly through the app.

Key functionalities include:
- **Assignment Viewing**: Students can browse and view assignments posted by lecturers.
- **Video Submission**: Students can record and submit video responses to assignments.
- **Feedback Access**: Students can view marks and comments provided by lecturers on their submissions.

This README will guide you through the setup and usage of the HMS-System Mobile App.

## Prerequisites

Before you begin, ensure you have the following installed on your system:
- [Flutter](https://flutter.dev/docs/get-started/install) (version 2.5 or higher)
- [Dart](https://dart.dev/get-dart) (usually comes with Flutter)
- [Android Studio](https://developer.android.com/studio) (for Android development)
- [Xcode](https://developer.apple.com/xcode/) (for iOS development, macOS only)
- [Git](https://git-scm.com/downloads)
- A compatible IDE (e.g., Visual Studio Code, Android Studio, or IntelliJ IDEA)

To check your installed versions:
- For Flutter: `flutter --version`
- For Dart: `dart --version`

Additionally, you'll need:
- An Android emulator or iOS simulator set up and running
- The HMS-System API server running locally (refer to the API repository's README for setup instructions)

## Installation

1. Clone the repository:
   ```
   git clone https://github.com/your-repo/hms-system-mobile.git
   cd hms-system-mobile
   ```

2. Install Flutter dependencies:
   ```
   flutter pub get
   ```

3. Copy the example environment file:
   ```
   cp .env.example .env
   ```

4. (Optional) If you're using Visual Studio Code, install the Flutter and Dart extensions for a better development experience.

## Running the Application

1. Ensure you have an Android emulator or iOS simulator running.

2. Start the application:
   ```
   flutter run
   ```

   This command will build the app and install it on your emulator/simulator.

## Connecting to the API

To connect the mobile app to the HMS-System API:

1. Ensure the HMS-System API server is running locally. Refer to the API repository's README for instructions on setting up and running the server.

2. Update the API base URL in the mobile app's .env file:
   - Open the `.env` file in the root of your project
   - Set the `API_BASE_URL` variable to your local API server address:
     
     For Android emulators:
     ```
     API_BASE_URL=http://10.0.2.2:8000/api
     ```
     
     For iOS simulators:
     ```
     API_BASE_URL=http://localhost:8000/api
     ```
     
     Note: `10.0.2.2` is the special IP address to access the host machine's localhost from an Android emulator. For iOS simulators, use `localhost` or `127.0.0.1`.

3. If you're testing on a physical device:
   - Ensure both the device and the computer running the API server are on the same network.
   - Use the computer's local IP address (e.g., `192.168.1.100`) instead of `10.0.2.2` or `localhost`.
   - Your `.env` file might look like:
     ```
     API_BASE_URL=http://192.168.1.100:8000/api
     ```

4. After changing the .env file, you may need to restart your Flutter app for the changes to take effect.

## Troubleshooting

If you encounter any issues:

1. Ensure Flutter is correctly installed and up to date:
   ```
   flutter doctor
   ```
   Address any issues reported by this command.

2. Verify that your emulator/simulator is running and detected by Flutter:
   ```
   flutter devices
   ```

3. If you're having trouble connecting to the API, check that:
   - The API server is running
   - The `API_BASE_URL` in your .env file is correct (remember to use `10.0.2.2` for Android emulators and `localhost` for iOS simulators)
   - You've restarted the Flutter app after changing the .env file

4. For build errors, try cleaning the project and rebuilding:
   ```
   flutter clean
   flutter pub get
   flutter run
   ```

5. If you're experiencing performance issues, try running the app in profile mode:
   ```
   flutter run --profile
   ```

For further assistance, please open an issue in the GitHub repository.

## Contributors

Our group details:

Group Name: Men In Code

Group Member 1
Name and surname: Henk Mooiman
Student number: 41293584
University Email Address: 41293584@mynwu.ac.za
 
Group Member 2
Name and surname: Theunis Kok
Student number: 43113877
University Email Address: 43113877@mynwu.ac.za
 
Group Member 3
Name and surname: Ruan van Heerden
Student number: 41763882
University Email Address: 41763882@mynwu.ac.za
