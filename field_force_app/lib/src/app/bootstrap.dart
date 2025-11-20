import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:logger/logger.dart';

import '../../firebase_options.dart';
import '../config/app_config.dart';
import '../services/notification_service.dart';

class AppBootstrap {
  static final Logger _logger = Logger();

  static Future<void> initialize(AppConfig config) async {
    WidgetsFlutterBinding.ensureInitialized();
    Logger.level = config.enableLogging ? Level.debug : Level.warning;

    await _initFirebase();
    await _ensureLocationPermission();
    await NotificationService.initialize();
    await FirebaseMessaging.instance.requestPermission();
  }

  static Future<void> _initFirebase() async {
    try {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
    } catch (error, stackTrace) {
      _logger.w(
        'Firebase initialization skipped',
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

  static Future<void> _ensureLocationPermission() async {
    final permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      await Geolocator.requestPermission();
    }
  }
}
