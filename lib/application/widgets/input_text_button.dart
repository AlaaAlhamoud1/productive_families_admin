import 'package:flutter/material.dart';

class InputTextButton extends StatelessWidget {
  final Function() onClick;
  final String titleText;

  const InputTextButton({
    Key? key,
    required this.onClick,
    required this.titleText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onClick,
      style: ButtonStyle(
        padding: MaterialStateProperty.all<EdgeInsets>(
            const EdgeInsets.symmetric(horizontal: 20)),
        maximumSize:
            MaterialStateProperty.all<Size>(const Size(double.maxFinite, 100)),
        minimumSize:
            MaterialStateProperty.all<Size>(const Size(double.maxFinite, 80)),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
        ),
      ),
      child: Text(
        titleText,
        style: const TextStyle(color: Colors.black),
      ),
    );
  }
}
