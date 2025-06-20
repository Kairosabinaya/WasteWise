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
    apiKey: 'AIzaSyDRoOuyNtchFkzFNtBCSpvsd_uTRVDvARs',
    appId: '1:596366131069:web:4dc780d689926df664d614',
    messagingSenderId: '596366131069',
    projectId: 'wastewise-d00fd',
    authDomain: 'wastewise-d00fd.firebaseapp.com',
    storageBucket: 'wastewise-d00fd.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCPh-Naidlq0bHp0YKN0enVnA1B91-TbkQ',
    appId: '1:596366131069:android:69c5e8d21d4a3cf264d614',
    messagingSenderId: '596366131069',
    projectId: 'wastewise-d00fd',
    storageBucket: 'wastewise-d00fd.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyApy72Alv0yMu6-JhMYZdXoJ91aHzA01ts',
    appId: '1:596366131069:ios:69a66bc3fc4101f764d614',
    messagingSenderId: '596366131069',
    projectId: 'wastewise-d00fd',
    storageBucket: 'wastewise-d00fd.firebasestorage.app',
    iosBundleId: 'com.example.wastewise',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyApy72Alv0yMu6-JhMYZdXoJ91aHzA01ts',
    appId: '1:596366131069:ios:69a66bc3fc4101f764d614',
    messagingSenderId: '596366131069',
    projectId: 'wastewise-d00fd',
    storageBucket: 'wastewise-d00fd.firebasestorage.app',
    iosBundleId: 'com.example.wastewise',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDRoOuyNtchFkzFNtBCSpvsd_uTRVDvARs',
    appId: '1:596366131069:web:394705d29b2e208164d614',
    messagingSenderId: '596366131069',
    projectId: 'wastewise-d00fd',
    authDomain: 'wastewise-d00fd.firebaseapp.com',
    storageBucket: 'wastewise-d00fd.firebasestorage.app',
  );
}
