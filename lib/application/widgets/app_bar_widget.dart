// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:productive_families_admin/application/home/settings_screen.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final List<Widget>? actions;
  final Color? backgroundColor;
  final Widget? title;

  const AppBarWidget({
    Key? key,
    this.actions,
    this.backgroundColor,
    this.title,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(50.0);

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
        preferredSize: preferredSize,
        child: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SettingsScreen(),
                    ));
              },
              icon: const Icon(Icons.settings)),
          titleTextStyle: const TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          automaticallyImplyLeading: false,
          centerTitle: true,
          actions: actions,
          backgroundColor: backgroundColor,
          title: title,
        ));
  }
}
