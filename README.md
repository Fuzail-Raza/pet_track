# Pettify - Pet Tracking Module

## Overview
**Pettify** is an all-in-one solution for pet owners, offering functionalities such as adding pets, setting task reminders, AI pet doctor consultations, shopping for pet essentials, and tracking your pets. This repository contains the module **PetTrack** which enables real-time location tracking of pets through a mobile app.

## Features of Main App
- **Add Pets**: Register your pets with their details.
- **Set Task Reminders**: Never miss a vet appointment or feeding time.
- **AI Pet Doctor**: Consult with an AI-driven virtual vet.
- **Shop Pet Essentials**: Buy food, toys, and other pet supplies.
- **Track Your Pet**: Real-time location tracking using the pet's chip.

## Getting Started

### Prerequisites
- Flutter SDK: [Install Flutter](https://flutter.dev/docs/get-started/install)
- Firebase Project: [Set up Firebase](https://firebase.google.com/docs/flutter/setup)
- Google Maps API Key: [Get API Key](https://developers.google.com/maps/gmp-get-started)

### Installation

1. **Clone the repository**:
   ```bash
   https://github.com/Fuzail-Raza/pet_track.git
   cd Pettify
   ```

2. **Install dependencies**:
   ```bash
   flutter pub get
   ```

3. **Set up Firebase**:
    - Download `google-services.json` from your Firebase project and place it in `android/app`.
    - Download `GoogleService-Info.plist` from your Firebase project and place it in `ios/Runner`.

4. **Configure Android permissions**:
   Add the following permissions to `AndroidManifest.xml`:
   ```xml
   <uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
   <uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />
   ```

5. **Configure iOS permissions**:
   Add the following keys to `Info.plist`:
   ```xml
   <key>NSLocationWhenInUseUsageDescription</key>
   <string>We need your location to track your pet.</string>
   ```

### Running the App
Run the app on a physical device as emulators may not provide accurate location data.

```bash
flutter run
```

## Usage

### Data Form
1. **Input your email** in the form field.
2. **Fetch Pet Data**: Click the "Fetch" button to retrieve the list of your registered pets.
3. **Select a Pet**: Tap on a pet from the list to start tracking.

### Location Tracking
1. **Real-time Updates**: The app will request location permissions and start tracking the pet's location.
2. **Save Location**: The pet's location is periodically updated and saved in Firestore.

## Code Overview

### Main Entry Point
```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}
```

### Data Form
- Fetches pet data from Firestore.
- Displays a list of pets associated with the entered email.

### Location Tracking
- Utilizes the `location` package to get real-time location updates.
- Saves the pet's location in Firestore.

## Dependencies

- `flutter`: SDK for building apps.
- `firebase_core`: Core functionalities for Firebase.
- `cloud_firestore`: Firestore database integration.
- `google_maps_flutter`: Google Maps integration.
- `location`: For accessing device location.

## Contributing

1. Fork the repository.
2. Create a new branch (`git checkout -b feature-branch`).
3. Commit your changes (`git commit -am 'Add some feature'`).
4. Push to the branch (`git push origin feature-branch`).
5. Create a new Pull Request.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgments

- [Flutter](https://flutter.dev/)
- [Firebase](https://firebase.google.com/)
- [Google Maps](https://developers.google.com/maps/)

## Contact

For any queries, please contact [fuzailraza161@gmail.com].

---

Enjoy using **Pettify** and keep your pets safe and happy! 🐾

---
