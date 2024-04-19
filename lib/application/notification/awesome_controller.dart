import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';

class NotificationController {
  static bool isTerminate = false;
  static String payload = '';
  @pragma("vm:entry-point")
  static Future<void> onNotificationCreatedMethod(
      ReceivedNotification receivedNotification) async {}

  @pragma("vm:entry-point")
  static Future<void> onNotificationDisplayedMethod(
      ReceivedNotification receivedNotification) async {}

  @pragma("vm:entry-point")
  static Future<void> onDismissActionReceivedMethod(
      ReceivedAction receivedAction) async {}

  @pragma("vm:entry-point")
  static Future<void> onActionReceivedMethod(
      ReceivedAction receivedAction) async {
    payload = receivedAction.payload!['go to']!;
    debugPrint('Received action: ${receivedAction.actionLifeCycle}');

    if (receivedAction.actionLifeCycle == NotificationLifeCycle.Terminated) {
      isTerminate = true;
    } else if (receivedAction.actionLifeCycle ==
            NotificationLifeCycle.Background ||
        receivedAction.actionLifeCycle == NotificationLifeCycle.Foreground) {
      // payload = '${receivedAction.payload!['go to']}';
      // isTerminate = false;
      // MyApp.navigatorKey.currentState?.pushNamedAndRemoveUntil(
      //   '/${receivedAction.payload!['go to']}',
      //   (route) => true,
      // );
    }
  }
}
