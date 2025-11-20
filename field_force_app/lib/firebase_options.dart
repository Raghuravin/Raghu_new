import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

/// Minimal placeholder Firebase configuration so firebase_core can initialize
/// without requiring platform-specific config files. Replace with the real
/// values when integrating with your backend project.
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return _web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return _android;
      case TargetPlatform.iOS:
        return _ios;
      case TargetPlatform.macOS:
        return _macos;
      case TargetPlatform.windows:
        return _windows;
      case TargetPlatform.linux:
        return _linux;
      default:
        return _android;
    }
  }

  static const _web = FirebaseOptions(
    apiKey: 'mock-web-api-key',
    appId: '1:000000000000:web:mock',
    messagingSenderId: '000000000000',
    projectId: 'field-force-mock',
  );

  static const _android = FirebaseOptions(
    apiKey: 'mock-android-api-key',
    appId: '1:000000000000:android:mock',
    messagingSenderId: '000000000000',
    projectId: 'field-force-mock',
  );

  static const _ios = FirebaseOptions(
    apiKey: 'mock-ios-api-key',
    appId: '1:000000000000:ios:mock',
    messagingSenderId: '000000000000',
    projectId: 'field-force-mock',
    iosBundleId: 'com.example.fieldForce',
  );

  static const _macos = FirebaseOptions(
    apiKey: 'mock-macos-api-key',
    appId: '1:000000000000:macos:mock',
    messagingSenderId: '000000000000',
    projectId: 'field-force-mock',
    iosBundleId: 'com.example.fieldForce',
  );

  static const _windows = FirebaseOptions(
    apiKey: 'mock-windows-api-key',
    appId: '1:000000000000:windows:mock',
    messagingSenderId: '000000000000',
    projectId: 'field-force-mock',
  );

  static const _linux = FirebaseOptions(
    apiKey: 'mock-linux-api-key',
    appId: '1:000000000000:linux:mock',
    messagingSenderId: '000000000000',
    projectId: 'field-force-mock',
  );
}
