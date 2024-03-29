// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart' show defaultTargetPlatform, kIsWeb, TargetPlatform;

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
    apiKey: 'AIzaSyC_yInpNRQdnPwzB7DBMUZQ4C62FRefqh8',
    appId: '1:193955521872:web:a5b9c97caf99eb9e873855',
    messagingSenderId: '193955521872',
    projectId: 'gad-nov-2022-group-chat',
    authDomain: 'gad-nov-2022-group-chat.firebaseapp.com',
    storageBucket: 'gad-nov-2022-group-chat.appspot.com',
    measurementId: 'G-QVS5163K9L',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC3phAiTkBzAoCdhlu8TBAxzLGv7WbL8ik',
    appId: '1:193955521872:android:534a841d3c7b93ae873855',
    messagingSenderId: '193955521872',
    projectId: 'gad-nov-2022-group-chat',
    storageBucket: 'gad-nov-2022-group-chat.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDKc2JX2rcOutW0oGxrNsg6TrzyXFsNZtY',
    appId: '1:193955521872:ios:34776b30d15be94e873855',
    messagingSenderId: '193955521872',
    projectId: 'gad-nov-2022-group-chat',
    storageBucket: 'gad-nov-2022-group-chat.appspot.com',
    iosClientId: '193955521872-0lag9gsedpt2pv9551h0tl9ot7ebs7oo.apps.googleusercontent.com',
    iosBundleId: 'com.example.gad7',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDKc2JX2rcOutW0oGxrNsg6TrzyXFsNZtY',
    appId: '1:193955521872:ios:34776b30d15be94e873855',
    messagingSenderId: '193955521872',
    projectId: 'gad-nov-2022-group-chat',
    storageBucket: 'gad-nov-2022-group-chat.appspot.com',
    iosClientId: '193955521872-0lag9gsedpt2pv9551h0tl9ot7ebs7oo.apps.googleusercontent.com',
    iosBundleId: 'com.example.gad7',
  );
}
