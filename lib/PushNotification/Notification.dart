import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/subjects.dart';

class NotificationScreen {
  static final _notification = FlutterLocalNotificationsPlugin();
  static final onNotification = BehaviorSubject<String?>();

  static Future _notificationDetails() async {
    return NotificationDetails(
        iOS: IOSNotificationDetails(),
        android: AndroidNotificationDetails('channelId', 'channelName',
            subText: 'description', importance: Importance.max));
  }

  static Future showNotification({
    int id = 0,
    String? title,
    String? body,
    String? payload,
  }) async =>
      _notification.show(id, title, body, await _notificationDetails(),
          payload: payload);
}
