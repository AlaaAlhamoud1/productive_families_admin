import 'package:flutter/material.dart';
import 'package:productive_families_admin/application/authentication/forgot_password/forgot_password.dart';
import 'package:productive_families_admin/application/authentication/sign_in/sign_in_screen.dart';
import 'package:productive_families_admin/application/authentication/sign_up/sign_up_screen.dart';
import 'package:productive_families_admin/application/home/home_screen.dart';
import 'package:productive_families_admin/application/home/main_page.dart';
import 'package:productive_families_admin/application/home/splash_screen.dart';
import 'package:productive_families_admin/application/notification/screen/notification_screen.dart';
import 'package:productive_families_admin/application/orders/screens/orders_sreen.dart';
import 'package:productive_families_admin/application/stores/screens/create_store.dart';
import 'package:productive_families_admin/application/stores/screens/store.dart';
import 'package:productive_families_admin/widget_tree.dart';

class AppRouter {
  //authentication
  static const String splash = 'splash';
  static const String signIn = 'signIn';
  static const String signUp = 'signIn/signUp';
  static const String forgotPassword = 'signIn/forgot_password';
  //shop main menu
  static const String home = '/';
  //shop main menu
  static const String mainScreen = '/main';
  //shop main menu
  static const String widgetTree = '/sidgetTree';
  //cloth
  static const String clothDetails = '/cloth_details';
  static const String orderDetails = '/order_details';
  //other
  static const String profile = '/profile';
  static const String settings = '/settings';
  static const String notifications = '/notifications';
  static const String about = '/about';
  static const String storeScreen = '/storeScreen';
  static const String store = '/store';
  static const String orders = '/orders';

  static const String notificaitonScreen = '/notificaiton';
  static Route<dynamic> onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case widgetTree:
        return MaterialPageRoute(builder: (_) => const WidgetTree());
      case signIn:
        return MaterialPageRoute(builder: (_) => const SignInScreen());
      case signUp:
        return MaterialPageRoute(builder: (_) => const SignUpScreen());
      case forgotPassword:
        return MaterialPageRoute(builder: (_) => const ForgotPasswordScreen());
      case storeScreen:
        return MaterialPageRoute(builder: (_) => const StoreScreen());
      case home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case store:
        return MaterialPageRoute(builder: (_) => const CreateStore());
      case orders:
        return MaterialPageRoute(builder: (_) => const OrdersTabScreen());
      case mainScreen:
        return MaterialPageRoute(builder: (_) => const MainPage());
      case notificaitonScreen:
        return MaterialPageRoute(builder: (_) => const NotificationScreen());

      default:
        throw MaterialPageRoute(builder: (_) => const HomeScreen());
    }
  }
}
