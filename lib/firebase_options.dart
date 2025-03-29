//
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

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
    apiKey: 'AIzaSyBLs5dqxJeglL8HBwIBlhuYP2ZLgDZPyjY',
    appId: '1:85476555347:web:5e43c0460bc7416d1b24a6',
    messagingSenderId: '85476555347',
    projectId: 'weather-app-aa6be',
    authDomain: 'weather-app-aa6be.firebaseapp.com',
    storageBucket: 'weather-app-aa6be.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDtIu_fLklBrSJ8Olo5_nhoDoD7U2ypW3A',
    appId: '1:85476555347:android:e45d6651882d6b0c1b24a6',
    messagingSenderId: '85476555347',
    projectId: 'weather-app-aa6be',
    storageBucket: 'weather-app-aa6be.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBJEQLqSlUy2qH6aEhRV4e_lSD_9_4sgPk',
    appId: '1:85476555347:ios:01f372d0b7dd24691b24a6',
    messagingSenderId: '85476555347',
    projectId: 'weather-app-aa6be',
    storageBucket: 'weather-app-aa6be.firebasestorage.app',
    iosBundleId: 'com.example.weatherForecast',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBJEQLqSlUy2qH6aEhRV4e_lSD_9_4sgPk',
    appId: '1:85476555347:ios:01f372d0b7dd24691b24a6',
    messagingSenderId: '85476555347',
    projectId: 'weather-app-aa6be',
    storageBucket: 'weather-app-aa6be.firebasestorage.app',
    iosBundleId: 'com.example.weatherForecast',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBLs5dqxJeglL8HBwIBlhuYP2ZLgDZPyjY',
    appId: '1:85476555347:web:74561ae1ba5351151b24a6',
    messagingSenderId: '85476555347',
    projectId: 'weather-app-aa6be',
    authDomain: 'weather-app-aa6be.firebaseapp.com',
    storageBucket: 'weather-app-aa6be.firebasestorage.app',
  );
}
