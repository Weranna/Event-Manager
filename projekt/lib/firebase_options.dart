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
    apiKey: 'AIzaSyC8xBqrofng3WUFEGAmcDBeHkPljZ4fBaM',
    appId: '1:70479705307:web:70d44215a69db7ae5a08fe',
    messagingSenderId: '70479705307',
    projectId: 'eventmanager-a6923',
    authDomain: 'eventmanager-a6923.firebaseapp.com',
    storageBucket: 'eventmanager-a6923.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBbUN5LOA6Fj-QMYYnnNAZnjMJ1Yyb-VI0',
    appId: '1:70479705307:android:f19def55f641b0745a08fe',
    messagingSenderId: '70479705307',
    projectId: 'eventmanager-a6923',
    storageBucket: 'eventmanager-a6923.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDmjEqnyizaGB5YnqziSWfNYeAxUgBEoSo',
    appId: '1:70479705307:ios:d6285b5966aad4b15a08fe',
    messagingSenderId: '70479705307',
    projectId: 'eventmanager-a6923',
    storageBucket: 'eventmanager-a6923.appspot.com',
    androidClientId: '70479705307-ksdd3ltjmpqnb8qjqmqjd1ph47m2kr2n.apps.googleusercontent.com',
    iosClientId: '70479705307-gmnmof0koiumiepc75prrr8oref2dsi0.apps.googleusercontent.com',
    iosBundleId: 'com.example.projekt',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDmjEqnyizaGB5YnqziSWfNYeAxUgBEoSo',
    appId: '1:70479705307:ios:d6285b5966aad4b15a08fe',
    messagingSenderId: '70479705307',
    projectId: 'eventmanager-a6923',
    storageBucket: 'eventmanager-a6923.appspot.com',
    androidClientId: '70479705307-ksdd3ltjmpqnb8qjqmqjd1ph47m2kr2n.apps.googleusercontent.com',
    iosClientId: '70479705307-gmnmof0koiumiepc75prrr8oref2dsi0.apps.googleusercontent.com',
    iosBundleId: 'com.example.projekt',
  );
}