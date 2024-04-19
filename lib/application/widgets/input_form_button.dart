import 'package:flutter/material.dart';

class InputFormButton extends StatelessWidget {
  final Function()? onClick;
  final String titleText;

  const InputFormButton({
    Key? key,
    required this.onClick,
    required this.titleText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Container(
        height: 60,
        width: 250,
        decoration: BoxDecoration(
            color: const Color(0xFF4AC382),
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            boxShadow: [
              BoxShadow(
                  blurRadius: 6,
                  spreadRadius: 6,
                  color: Colors.black.withOpacity(0.1),
                  blurStyle: BlurStyle.normal,
                  offset: const Offset(-1, 0)),
            ]),
        child: Center(
          child: Text(
            titleText,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
