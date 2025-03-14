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
    apiKey: 'AIzaSyDFj5QBanhlTnKNGo58_JvIfHrgE1lCiY4',
    appId: '1:654758117299:web:0e031df21f122e2e2515c6',
    messagingSenderId: '654758117299',
    projectId: 'patient-d9fd8',
    authDomain: 'patient-d9fd8.firebaseapp.com',
    databaseURL: 'https://patient-d9fd8-default-rtdb.firebaseio.com',
    storageBucket: 'patient-d9fd8.appspot.com',
    measurementId: 'G-KW6B1DSEN5',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAM7ohle13paZ07sKK-56rHsuqfhZohgxw',
    appId: '1:654758117299:android:f31ca90bb52f030c2515c6',
    messagingSenderId: '654758117299',
    projectId: 'patient-d9fd8',
    databaseURL: 'https://patient-d9fd8-default-rtdb.firebaseio.com',
    storageBucket: 'patient-d9fd8.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBHBPZO8UPK_feqCGZvqb3wKE5cSF6zs0c',
    appId: '1:654758117299:ios:ce66a70de4e78a362515c6',
    messagingSenderId: '654758117299',
    projectId: 'patient-d9fd8',
    databaseURL: 'https://patient-d9fd8-default-rtdb.firebaseio.com',
    storageBucket: 'patient-d9fd8.appspot.com',
    iosBundleId: 'com.example.patient',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBHBPZO8UPK_feqCGZvqb3wKE5cSF6zs0c',
    appId: '1:654758117299:ios:ce66a70de4e78a362515c6',
    messagingSenderId: '654758117299',
    projectId: 'patient-d9fd8',
    databaseURL: 'https://patient-d9fd8-default-rtdb.firebaseio.com',
    storageBucket: 'patient-d9fd8.appspot.com',
    iosBundleId: 'com.example.patient',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDFj5QBanhlTnKNGo58_JvIfHrgE1lCiY4',
    appId: '1:654758117299:web:77b1d0e8eefe69542515c6',
    messagingSenderId: '654758117299',
    projectId: 'patient-d9fd8',
    authDomain: 'patient-d9fd8.firebaseapp.com',
    databaseURL: 'https://patient-d9fd8-default-rtdb.firebaseio.com',
    storageBucket: 'patient-d9fd8.appspot.com',
    measurementId: 'G-T48S3FG56B',
  );
}
