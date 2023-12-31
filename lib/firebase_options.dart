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
    apiKey: 'AIzaSyDQlXw-HCTFI_Pxz4UmPTBW_Me-rCw_F4w',
    appId: '1:70140424215:web:6af5c46e72bb33ffcaac52',
    messagingSenderId: '70140424215',
    projectId: 'saigai-771de',
    authDomain: 'saigai-771de.firebaseapp.com',
    storageBucket: 'saigai-771de.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCjBXC39Etu9J7eS_oxofgTdzRK7UJPCLw',
    appId: '1:70140424215:android:801ca1fc12e45ab3caac52',
    messagingSenderId: '70140424215',
    projectId: 'saigai-771de',
    storageBucket: 'saigai-771de.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBv0TL9UpZVeyXaTn-YqDvm69KkpOMDSE4',
    appId: '1:70140424215:ios:70c8b620989a28d9caac52',
    messagingSenderId: '70140424215',
    projectId: 'saigai-771de',
    storageBucket: 'saigai-771de.appspot.com',
    iosClientId: '70140424215-1jmsncsphjjgqkkiijenfrvdpabebcbg.apps.googleusercontent.com',
    iosBundleId: 'jp.ac.Saigai',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBv0TL9UpZVeyXaTn-YqDvm69KkpOMDSE4',
    appId: '1:70140424215:ios:d080df9b8604b527caac52',
    messagingSenderId: '70140424215',
    projectId: 'saigai-771de',
    storageBucket: 'saigai-771de.appspot.com',
    iosClientId: '70140424215-1dujr9t5kvucg0rpie4lljr4bpnl1p4m.apps.googleusercontent.com',
    iosBundleId: 'jp.ac.Saigai.RunnerTests',
  );
}
