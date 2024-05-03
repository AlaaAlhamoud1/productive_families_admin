// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:productive_families_admin/core/colors.dart';
import 'package:productive_families_admin/core/data/local_data/shared_pref.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

bool value1 = false;

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("settings"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
        child: SingleChildScrollView(
          child: Column(
            children: [
              InputDecorationWidget(
                label: "general",
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("currency"),
                      Text("USD"),
                    ],
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Expanded(child: Text("deliveryAddress")),
                      Text(getStringAsync('LOCATION')),
                    ],
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              InputDecorationWidget(
                label: "notificaitons",
                children: [
                  customSwitchWidget("order", false),
                  customSwitchWidget("promotion", false),
                  customSwitchWidget("newArrival", false)
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget customSwitchWidget(String text, bool val) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(text),
        Switch(
          activeTrackColor: const Color.fromARGB(255, 32, 101, 64),
          value: val,
          activeColor: AppColors.appColor,
          onChanged: (bool value) {},
        )
      ],
    );
  }
}

class InputDecorationWidget extends StatelessWidget {
  final String label;
  final List<Widget> children;
  const InputDecorationWidget({
    Key? key,
    required this.label,
    required this.children,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InputDecorator(
      decoration: InputDecoration(
        labelStyle: TextStyle(color: AppColors.appColor),
        contentPadding: const EdgeInsets.symmetric(horizontal: 8),
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
      ),
      child: Container(
        padding: const EdgeInsets.only(top: 24, left: 8, bottom: 16, right: 12),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: children),
      ),
    );
  }
}
