import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> initialize() async {
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const settings = InitializationSettings(android: android);
    await _plugin.initialize(settings);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      final title = message.notification?.title ?? 'New Assignment';
      final body =
          message.notification?.body ?? 'Open the app to view details.';
      showSimpleNotification(title: title, body: body);
    });
  }

  static Future<void> showSimpleNotification({
    required String title,
    required String body,
  }) async {
    const androidDetails = AndroidNotificationDetails(
      'ffm_channel',
      'Field Force Notifications',
      importance: Importance.max,
      priority: Priority.high,
    );
    const details = NotificationDetails(android: androidDetails);
    await _plugin.show(title.hashCode, title, body, details);
  }

  static Future<void> showPendingSyncBanner(int count) async {
    await showSimpleNotification(
      title: 'Sync pending',
      body: '$count items are waiting to sync.',
    );
  }
}
