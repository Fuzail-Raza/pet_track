// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyC6vb1vJqwZ7C7s4DK_nUdG7jHoO2fHJBc',
    appId: '1:571169544577:web:2c9d3d50f065713acbb080',
    messagingSenderId: '571169544577',
    projectId: 'pettify-96749',
    authDomain: 'pettify-96749.firebaseapp.com',
    storageBucket: 'pettify-96749.appspot.com',
    measurementId: 'G-64EE0CLV17',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAHuysMGb2tP-O5UAOhK7FB0bWHofN6CZ8',
    appId: '1:571169544577:android:1a0d4080f9c521b8cbb080',
    messagingSenderId: '571169544577',
    projectId: 'pettify-96749',
    storageBucket: 'pettify-96749.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBZOUnyP03xwdVNzxLkkEkfbBIKBQbs7-A',
    appId: '1:571169544577:ios:efe4c9b7dc9043c0cbb080',
    messagingSenderId: '571169544577',
    projectId: 'pettify-96749',
    storageBucket: 'pettify-96749.appspot.com',
    androidClientId: '571169544577-skr38bpnvcr19pd7gu9stqsmo7om36lp.apps.googleusercontent.com',
    iosClientId: '571169544577-nnn2fiqjj30ro131gpsh9tia5li6lp5p.apps.googleusercontent.com',
    iosBundleId: 'com.example.petTrack',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBZOUnyP03xwdVNzxLkkEkfbBIKBQbs7-A',
    appId: '1:571169544577:ios:efe4c9b7dc9043c0cbb080',
    messagingSenderId: '571169544577',
    projectId: 'pettify-96749',
    storageBucket: 'pettify-96749.appspot.com',
    androidClientId: '571169544577-skr38bpnvcr19pd7gu9stqsmo7om36lp.apps.googleusercontent.com',
    iosClientId: '571169544577-nnn2fiqjj30ro131gpsh9tia5li6lp5p.apps.googleusercontent.com',
    iosBundleId: 'com.example.petTrack',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyC6vb1vJqwZ7C7s4DK_nUdG7jHoO2fHJBc',
    appId: '1:571169544577:web:68ba96b90e8a2f96cbb080',
    messagingSenderId: '571169544577',
    projectId: 'pettify-96749',
    authDomain: 'pettify-96749.firebaseapp.com',
    storageBucket: 'pettify-96749.appspot.com',
    measurementId: 'G-ZVNRZJSZ3N',
  );
}