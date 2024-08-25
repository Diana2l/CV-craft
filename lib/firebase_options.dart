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
    apiKey: 'AIzaSyDavdKsKBYT9y1qnI_hLB37cmqco-nAykU',
    appId: '1:683112036706:web:8224cea748e4997719143b',
    messagingSenderId: '683112036706',
    projectId: 'cvcraft-98508',
    authDomain: 'cvcraft-98508.firebaseapp.com',
    storageBucket: 'cvcraft-98508.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCsXjZYkHKavQp-jWACArsoHkACSJr7hSo',
    appId: '1:683112036706:android:15cc89ca2273491c19143b',
    messagingSenderId: '683112036706',
    projectId: 'cvcraft-98508',
    storageBucket: 'cvcraft-98508.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCMjJ1P0xDQRegjpPRQiJjKz1lRcF4BF1E',
    appId: '1:683112036706:ios:44b631ebd625ab2c19143b',
    messagingSenderId: '683112036706',
    projectId: 'cvcraft-98508',
    storageBucket: 'cvcraft-98508.appspot.com',
    iosClientId: '683112036706-19pioovk5d6momc42eku31j96d9jntkj.apps.googleusercontent.com',
    iosBundleId: 'com.example.jobsLink',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCMjJ1P0xDQRegjpPRQiJjKz1lRcF4BF1E',
    appId: '1:683112036706:ios:44b631ebd625ab2c19143b',
    messagingSenderId: '683112036706',
    projectId: 'cvcraft-98508',
    storageBucket: 'cvcraft-98508.appspot.com',
    iosClientId: '683112036706-19pioovk5d6momc42eku31j96d9jntkj.apps.googleusercontent.com',
    iosBundleId: 'com.example.jobsLink',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDavdKsKBYT9y1qnI_hLB37cmqco-nAykU',
    appId: '1:683112036706:web:a1ca8c622320ab7f19143b',
    messagingSenderId: '683112036706',
    projectId: 'cvcraft-98508',
    authDomain: 'cvcraft-98508.firebaseapp.com',
    storageBucket: 'cvcraft-98508.appspot.com',
  );
}
