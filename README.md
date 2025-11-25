# Flutter-Batoo-Maps-Demo

This is a public demo of the Baato App for Flutter. This app shows the way to integrate [Baato](http://baato.io/) map style in Flutter, using Baato API and features like location service, routing, markers, and camera.

## Requirements

- **Flutter:** 3.38.3 or higher
- **Dart:** 3.10.1 or higher
- **Baato Maps:** 1.1.0
- **Java:** 21 (for Android builds)
- **Kotlin:** 2.1.0
- **Android Gradle Plugin:** 8.9.1
- **Gradle:** 8.11.1
- **NDK:** 28.1.13356709

## Running locally

### 1. Setting up the environment

Create a `.env` file in the root directory of the project and add your Baato API key:

```
baato_api_key=your_api_key_here
```

Obtain your access token on the [Baato account page](http://baato.io/).

### 2. Installing dependencies

Run the following command to install dependencies:

```bash
flutter pub get
```

### 3. Running the app

Run the app on your connected device or emulator:

```bash
flutter run
```

## Build Configuration

### Android

For Android builds, ensure you have Java 21 installed and configured. If using `jenv`, you can set the local Java version:

```bash
jenv local 21
```

The project is configured with:
- **compileSdk:** Defined by Flutter
- **minSdk:** Defined by Flutter
- **targetSdk:** Defined by Flutter
- **NDK Version:** 28.1.13356709
- **Java Version:** 21
- **Kotlin Version:** 2.1.0

## API Documentation

Details on `Flutter Baato Map` API Documentation can be found at [Flutter Baato Maps](https://github.com/baato/flutter_baato_maps)