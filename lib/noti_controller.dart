import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotiController {
  static final FlutterLocalNotificationsPlugin _plugin = FlutterLocalNotificationsPlugin();

  /// Initialize notifications
  static Future<void> init() async {
    AndroidInitializationSettings android = AndroidInitializationSettings('@mipmap/ic_launcher');
    InitializationSettings settings = InitializationSettings(android: android);
    await _plugin.initialize(settings);
    await requestPermission();
  }

  /// Request permission
  static Future<void> requestPermission() async {
    final androidImp = _plugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();
    if (androidImp != null) {
      await androidImp.requestNotificationsPermission();
    }
  }

  /// Show instance notification
  static Future<void> showInstanceNotification({required int id, required String body, required String title}) async {
    AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      "important_chanel",
      "Important Channel",
      showWhen: true,
      priority: Priority.high,
      importance: Importance.max,
      channelDescription: "Important Notifications Channel",
    );
    NotificationDetails details = NotificationDetails(android: androidDetails);
    await _plugin.show(id, title, body, details);
  }

  /// Show scheduled notification
  void showScheduledNotification() {}
}
