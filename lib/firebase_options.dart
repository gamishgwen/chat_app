// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyCcb8qucraVp-RBToH2qaTc9SZr81ifN2M',
    appId: '1:125732211386:web:8b7f112af24acc94459083',
    messagingSenderId: '125732211386',
    projectId: 'chat-app-e7492',
    authDomain: 'chat-app-e7492.firebaseapp.com',
    storageBucket: 'chat-app-e7492.appspot.com',
    measurementId: 'G-DQVFPEY7LW',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAhO7CQdVVMcWNfl1UI5asfVcrQzym_rjA',
    appId: '1:125732211386:android:05fbdcbf00bdc594459083',
    messagingSenderId: '125732211386',
    projectId: 'chat-app-e7492',
    storageBucket: 'chat-app-e7492.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAMmRSJJ0t4ZurUJe6cY9sNV7nZE2PZK90',
    appId: '1:125732211386:ios:bdecc6fd144dfd17459083',
    messagingSenderId: '125732211386',
    projectId: 'chat-app-e7492',
    storageBucket: 'chat-app-e7492.appspot.com',
    iosBundleId: 'com.example.chatApp',
  );
}
