import 'package:flutter/material.dart';
import 'package:flutter_loadingindicator/flutter_loadingindicator.dart';
import 'package:productive_families_admin/application/authentication/sign_in/sign_in_screen.dart';
import 'package:productive_families_admin/application/home/main_page.dart';
import 'package:productive_families_admin/auth.dart';

class WidgetTree extends StatefulWidget {
  const WidgetTree({super.key});

  @override
  State<WidgetTree> createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      builder: (context, snapshot) {
        print(snapshot.hasData);
        if (snapshot.hasData) {
          EasyLoading.dismiss();
          return const MainPage();
        } else {
          EasyLoading.dismiss();
          return const SignInScreen();
        }
      },
      stream: Auth().authStateChanges,
    );
  }
}
