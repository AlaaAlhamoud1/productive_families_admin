import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_loadingindicator/flutter_loadingindicator.dart';
import 'package:productive_families_admin/application/notification/awesome_controller.dart';
import 'package:productive_families_admin/application/home/local_notifications.dart';
import 'package:productive_families_admin/business_logic/blocs/auth/auth_bloc.dart';
import 'package:productive_families_admin/core/colors.dart';
import 'package:productive_families_admin/widget_tree.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'firebase_options.dart';

late SharedPreferences sharedPreferences;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  configLoading();
  sharedPreferences = await SharedPreferences.getInstance();
  AwesomeNotifications().initialize(
    null,
    [
      NotificationChannel(
        channelKey: 'pushnotificationapp',
        channelName: 'pushnotificationappchannel',
        channelDescription: 'Notification channel for basic tests',
        importance: NotificationImportance.High,
        // enableVibration: true/,
        // soundSource: 'resource://raw/a',
        // playSound: true,
      ),
    ],
  );

  FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true, badge: true, sound: true);

  FirebaseMessaging.onMessageOpenedApp.single
      .asStream()
      .single
      .then((value) => _firebaseMessagingHandler(value));

  FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
    if (message.notification != null) {
      Map<Object?, Object?> data = {
        'title': message.notification!.title,
        'body': message.notification!.body,
        'data': message.data
      };
      await LocalNotificationService.showMessage(data);
    }
  });
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingHandler);
  runApp(const MyApp());
}

void onMessageReceivedInTheForeground(Map<Object?, Object?> data) {
  LocalNotificationService.showMessage(data);
}

@pragma("vm:entry-point")
Future<void> _firebaseMessagingHandler(RemoteMessage message) async {
  if (message.notification != null) {
    Map<Object?, Object?> data = {
      'title': message.notification!.title,
      'body': message.notification!.body,
      'data': message.data
    };
    await LocalNotificationService.showMessage(data);
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    FirebaseMessaging.instance.subscribeToTopic('a');
    AwesomeNotifications().requestPermissionToSendNotifications(permissions: [
      NotificationPermission.Alert,
      NotificationPermission.FullScreenIntent
    ]);
    AwesomeNotifications().setListeners(
        onActionReceivedMethod: NotificationController.onActionReceivedMethod,
        onNotificationCreatedMethod:
            NotificationController.onNotificationCreatedMethod,
        onNotificationDisplayedMethod:
            NotificationController.onNotificationDisplayedMethod,
        onDismissActionReceivedMethod:
            NotificationController.onDismissActionReceivedMethod);
    FirebaseMessaging.instance
        .requestPermission(alert: true, announcement: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider<AuthBloc>(
        create: (context) => AuthBloc()..add(CheckAuth()),
      ),
    ], child: const ProductiveFamiliesApp());
  }
}

class ProductiveFamiliesApp extends StatelessWidget {
  const ProductiveFamiliesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.appColor),
        useMaterial3: true,
      ),
      builder: EasyLoading.init(),
      home: const WidgetTree(),
    );
  }
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2500)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.white
    ..backgroundColor = AppColors.appColor
    ..indicatorColor = Colors.white
    ..textColor = Colors.white
    ..userInteractions = false
    ..maskType = EasyLoadingMaskType.black
    ..dismissOnTap = true;
}
