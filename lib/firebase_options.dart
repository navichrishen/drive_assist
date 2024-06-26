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
    apiKey: 'AIzaSyBhiuGYflfctHngER95R1jCnPF1VwfmHkk',
    appId: '1:33660439769:web:fd18b2524eb70f941ac2c8',
    messagingSenderId: '33660439769',
    projectId: 'drive-assist-771f8',
    authDomain: 'drive-assist-771f8.firebaseapp.com',
    storageBucket: 'drive-assist-771f8.appspot.com',
    measurementId: 'G-YR62Y6LP76',
    // databaseURL: 'https://drive-assist-771f8-default-rtdb.asia-southeast1.firebasedatabase.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCKx5Rug9merBKSrXc6GTcIDecCExy4dN8',
    appId: '1:33660439769:android:573320bfec8b14081ac2c8',
    messagingSenderId: '33660439769',
    projectId: 'drive-assist-771f8',
    storageBucket: 'drive-assist-771f8.appspot.com',
    databaseURL: 'https://drive-assist-771f8-default-rtdb.asia-southeast1.firebasedatabase.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCqRfhI8bQ_DycfAR1s4PvxysGCjRfeA6I',
    appId: '1:33660439769:ios:468dd71e69aac88e1ac2c8',
    messagingSenderId: '33660439769',
    projectId: 'drive-assist-771f8',
    storageBucket: 'drive-assist-771f8.appspot.com',
    iosBundleId: 'com.example.driveAssist',
    // databaseURL: 'https://drive-assist-771f8-default-rtdb.asia-southeast1.firebasedatabase.app',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCqRfhI8bQ_DycfAR1s4PvxysGCjRfeA6I',
    appId: '1:33660439769:ios:c0a2660067db390e1ac2c8',
    messagingSenderId: '33660439769',
    projectId: 'drive-assist-771f8',
    storageBucket: 'drive-assist-771f8.appspot.com',
    iosBundleId: 'com.example.driveAssist.RunnerTests',
    // databaseURL: 'https://drive-assist-771f8-default-rtdb.asia-southeast1.firebasedatabase.app',
  );
}
