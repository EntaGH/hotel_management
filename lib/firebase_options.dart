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
    apiKey: 'AIzaSyBTx2B4PtGCGFYCLh8kvDq0HSyvz-OZJ7w',
    appId: '1:387620752702:web:7acb12481780d1e2bbf06f',
    messagingSenderId: '387620752702',
    projectId: 'fe-hotel',
    authDomain: 'fe-hotel.firebaseapp.com',
    storageBucket: 'fe-hotel.firebasestorage.app',
    measurementId: 'G-MQ1HCXLQ39',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyApOAiv7jd0sSReAFaIIpz80fK2OGgk-es',
    appId: '1:387620752702:android:d5d49044ac0359cbbbf06f',
    messagingSenderId: '387620752702',
    projectId: 'fe-hotel',
    storageBucket: 'fe-hotel.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA6IEMP1xq0bAnqrCZnz-2GhiTJqgSwGFs',
    appId: '1:387620752702:ios:529716eec4acc8e4bbf06f',
    messagingSenderId: '387620752702',
    projectId: 'fe-hotel',
    storageBucket: 'fe-hotel.firebasestorage.app',
    iosBundleId: 'com.example.feHotel',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyA6IEMP1xq0bAnqrCZnz-2GhiTJqgSwGFs',
    appId: '1:387620752702:ios:529716eec4acc8e4bbf06f',
    messagingSenderId: '387620752702',
    projectId: 'fe-hotel',
    storageBucket: 'fe-hotel.firebasestorage.app',
    iosBundleId: 'com.example.feHotel',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBTx2B4PtGCGFYCLh8kvDq0HSyvz-OZJ7w',
    appId: '1:387620752702:web:f5bcbd047af7ed18bbf06f',
    messagingSenderId: '387620752702',
    projectId: 'fe-hotel',
    authDomain: 'fe-hotel.firebaseapp.com',
    storageBucket: 'fe-hotel.firebasestorage.app',
    measurementId: 'G-X8N9THSYHM',
  );

}