import 'dart:async';

import 'package:flutter/material.dart';
import 'package:productive_families_admin/widget_tree.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) =>  WidgetTree(),
          ));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Expanded(
            flex: 4,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Image.asset('assets/images/new_logo.png'),
            )),
        Expanded(
          flex: 5,
          child: Image.asset(
            'assets/images/welcom.png',
            fit: BoxFit.fitWidth,
          ),
        ),
      ]),
    );
  }
}
