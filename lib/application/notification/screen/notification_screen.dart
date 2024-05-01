import 'package:flutter/material.dart';
import 'package:productive_families_admin/core/colors.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.appColor,
        title: const Text(
          "Notificaiton",
        ),
        centerTitle: true,
        titleTextStyle: const TextStyle(
            color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
      ),
      body: Container(),
    );
  }
}
