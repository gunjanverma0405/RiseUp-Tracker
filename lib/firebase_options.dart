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
    apiKey: 'AIzaSyBj_2IfSsYlowbvICKBCzbF19cAJrcZepw',
    appId: '1:323259046861:web:efdac099dacde1b4718284',
    messagingSenderId: '323259046861',
    projectId: 'riseuptracker',
    authDomain: 'riseuptracker.firebaseapp.com',
    storageBucket: 'riseuptracker.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAVz7-9QK-HJTFlT8gyJPPH5VfG4uwKf8k',
    appId: '1:323259046861:android:d1c03d2e9dcad3fe718284',
    messagingSenderId: '323259046861',
    projectId: 'riseuptracker',
    storageBucket: 'riseuptracker.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA7RmYMCMsa_UcdNP3G6WDAeZm2Q5SUnAg',
    appId: '1:323259046861:ios:c0e776be10d4458b718284',
    messagingSenderId: '323259046861',
    projectId: 'riseuptracker',
    storageBucket: 'riseuptracker.appspot.com',
    androidClientId: '323259046861-fp1deg6bqkt4r4asigj35su1cjtunkfa.apps.googleusercontent.com',
    iosClientId: '323259046861-qlomm5ald5cqr647go3ro3k7qlscpm9g.apps.googleusercontent.com',
    iosBundleId: 'com.example.riseuptracker',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyA7RmYMCMsa_UcdNP3G6WDAeZm2Q5SUnAg',
    appId: '1:323259046861:ios:c0e776be10d4458b718284',
    messagingSenderId: '323259046861',
    projectId: 'riseuptracker',
    storageBucket: 'riseuptracker.appspot.com',
    androidClientId: '323259046861-fp1deg6bqkt4r4asigj35su1cjtunkfa.apps.googleusercontent.com',
    iosClientId: '323259046861-qlomm5ald5cqr647go3ro3k7qlscpm9g.apps.googleusercontent.com',
    iosBundleId: 'com.example.riseuptracker',
  );
}
