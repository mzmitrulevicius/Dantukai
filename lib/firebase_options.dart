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
    apiKey: 'AIzaSyCUp3boZPflOu3b5reGrZ4KpJTxTzceTh0',
    appId: '1:243103591958:web:de6c1f23bde2591d254f37',
    messagingSenderId: '243103591958',
    projectId: 'dantukai-9fd66',
    authDomain: 'dantukai-9fd66.firebaseapp.com',
    storageBucket: 'dantukai-9fd66.appspot.com',
    measurementId: 'G-3WBQ194RP5',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDM0hTbsjii_WlZ5Xr2jQ2cbcJ2Z5yXkYI',
    appId: '1:243103591958:android:5bf1648849f51b5c254f37',
    messagingSenderId: '243103591958',
    projectId: 'dantukai-9fd66',
    storageBucket: 'dantukai-9fd66.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD5TDT_PGWXWyNe9RDEA31MoBJYRqSDYRc',
    appId: '1:243103591958:ios:9b9f047a1066d388254f37',
    messagingSenderId: '243103591958',
    projectId: 'dantukai-9fd66',
    storageBucket: 'dantukai-9fd66.appspot.com',
    iosBundleId: 'com.example.manoDantukai',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyD5TDT_PGWXWyNe9RDEA31MoBJYRqSDYRc',
    appId: '1:243103591958:ios:2f20b19ab6592a48254f37',
    messagingSenderId: '243103591958',
    projectId: 'dantukai-9fd66',
    storageBucket: 'dantukai-9fd66.appspot.com',
    iosBundleId: 'com.example.manoDantukai.RunnerTests',
  );
}
