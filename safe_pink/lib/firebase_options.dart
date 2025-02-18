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
        return macos;
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
    apiKey: 'AIzaSyDnJBABKw5D1vJXvSBbnGynYQQAOqXD0XQ',
    appId: '1:263809878415:web:81e2a54b57497cabf463fa',
    messagingSenderId: '263809878415',
    projectId: 'safe-pink',
    authDomain: 'safe-pink.firebaseapp.com',
    storageBucket: 'safe-pink.appspot.com',
    measurementId: 'G-98MP1ZQJTY',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBOBS_r0XHQniruhobucZqpN_kA5z72s6E',
    appId: '1:263809878415:android:2fe8cdf9d5fb0758f463fa',
    messagingSenderId: '263809878415',
    projectId: 'safe-pink',
    storageBucket: 'safe-pink.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAZhdkSIPXdMExgzl8F53nXz3oTt_6If5A',
    appId: '1:263809878415:ios:3286b830d10c182ff463fa',
    messagingSenderId: '263809878415',
    projectId: 'safe-pink',
    storageBucket: 'safe-pink.appspot.com',
    iosClientId: '263809878415-9psvcjpvnsebv26j7legfgq33b36ru0s.apps.googleusercontent.com',
    iosBundleId: 'com.example.safePink',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAZhdkSIPXdMExgzl8F53nXz3oTt_6If5A',
    appId: '1:263809878415:ios:3286b830d10c182ff463fa',
    messagingSenderId: '263809878415',
    projectId: 'safe-pink',
    storageBucket: 'safe-pink.appspot.com',
    iosClientId: '263809878415-9psvcjpvnsebv26j7legfgq33b36ru0s.apps.googleusercontent.com',
    iosBundleId: 'com.example.safePink',
  );
}
