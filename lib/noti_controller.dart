import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter_timezone/flutter_timezone.dart';

class NotiController {
  static final FlutterLocalNotificationsPlugin _plugin = FlutterLocalNotificationsPlugin();

  /// Initialize notifications
  static Future<void> init() async {
    AndroidInitializationSettings android = AndroidInitializationSettings('@mipmap/ic_launcher');
    InitializationSettings settings = InitializationSettings(android: android);
    await _plugin.initialize(settings);
    await requestPermission();
    tz.initializeTimeZones();
    final String timeZoneName = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZoneName));
  }

  /// Request permission
  static Future<void> requestPermission() async {
    final androidImp = _plugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();
    if (androidImp != null) {
      await androidImp.requestExactAlarmsPermission();
      await androidImp.requestNotificationsPermission();
    }
  }

  /// Show instance notification
  static Future<void> showInstanceNotification({required int id, required String body, required String title}) async {
    AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      "instance_chanel",
      "Instance Channel",
      showWhen: true,
      priority: Priority.high,
      importance: Importance.max,
      channelDescription: "Instance Notifications Channel",
    );
    NotificationDetails details = NotificationDetails(android: androidDetails);

    await _plugin.show(id, title, body, details);
  }

  /// Show scheduled notification
  static Future<void> showScheduledNotification({required int id, required String body, required String title, required DateTime schedule}) async {
    AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      "scheduled_chanel",
      "Scheduled Channel",
      showWhen: true,
      priority: Priority.high,
      importance: Importance.max,
      channelDescription: "Scheduled Notifications Channel",
    );
    NotificationDetails details = NotificationDetails(android: androidDetails);

    await _plugin.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.from(schedule, tz.local),
      details,
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
    );
  }
}
