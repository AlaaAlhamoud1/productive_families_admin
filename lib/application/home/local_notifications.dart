import 'package:awesome_notifications/awesome_notifications.dart';

class LocalNotificationService {
  static showMessage(Map<Object?, dynamic> data) async {
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        customSound: 'resource://raw/a',
        locked: false,
        id: DateTime.now().millisecond,
        channelKey: 'pushnotificationapp',
        wakeUpScreen: true,
        title: data['title'].toString(),
        body: data['body'].toString(),
        // payload: {
        //   'go to': data['data']['go to'].toString(),
        // },
      ),
    );
  }
}
