import 'package:flutter/material.dart';
import 'package:flutter_loadingindicator/flutter_loadingindicator.dart';
import 'package:productive_families_admin/application/widgets/input_form_button.dart';
import 'package:productive_families_admin/auth.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: InputFormButton(
          onClick: () async {
            await EasyLoading.show(status: 'loading...');
            await Auth().signOut();
            Navigator.pop(context);
          },
          titleText: "log out",
        ),
      ),
    );
  }
}
