import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:timezone/data/latest.dart' as tz;
// import 'package:timezone/timezone.dart' as tz;

class NotifServisHariH {
  FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  final AndroidInitializationSettings _androidInitializationSettings =
      AndroidInitializationSettings('launcher_icon');

  void initNotif() async {
    InitializationSettings initializationSettings = InitializationSettings(
      android: _androidInitializationSettings,
    );

    await _flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  void sendNotif(
    int id,
    String title,
    String body,
    DateTime date,
  ) async {
    var scheduleNotificationDateTime = date;
    // var scheduleNotificationDateTime = DateTime.now();

    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      'channelId',
      'channelName',
      playSound: true,
      importance: Importance.max,
      priority: Priority.high,
    );
    NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
    );

    // await _flutterLocalNotificationsPlugin.show(
    //   0,
    //   title,
    //   body,
    //   notificationDetails,

    // );

    await _flutterLocalNotificationsPlugin.schedule(
      id,
      title,
      body,
      scheduleNotificationDateTime,
      notificationDetails,
    );
  }
}

//every morning

class NotifServis {
  FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  final AndroidInitializationSettings _androidInitializationSettings =
      AndroidInitializationSettings('launcher_icon');

  void initNotif() async {
    InitializationSettings initializationSettings = InitializationSettings(
      android: _androidInitializationSettings,
    );

    await _flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  void sendNotif(
    int id,
    String title,
    String body,
    DateTime date,
  ) async {
    var scheduleNotificationDateTimebefore = date;

    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      'channelId',
      'channelName',
      playSound: true,
      importance: Importance.max,
      priority: Priority.high,
    );
    NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
    );

    await _flutterLocalNotificationsPlugin.schedule(
      id,
      title,
      body,
      scheduleNotificationDateTimebefore,
      notificationDetails,
      androidAllowWhileIdle: true,
    );
  }
}
