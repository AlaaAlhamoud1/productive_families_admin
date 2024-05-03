import 'package:flutter/material.dart';
import 'package:productive_families_admin/core/colors.dart';

class InputTextFormField extends StatefulWidget {
  final TextEditingController controller;
  final bool isSecureField;
  final bool autoCorrect;
  final String? hint;
  final TextInputType type;
  final String? Function(String?)? validator;
  const InputTextFormField({
    Key? key,
    required this.type,
    required this.controller,
    this.validator,
    this.isSecureField = false,
    this.autoCorrect = false,
    this.hint,
  }) : super(key: key);

  @override
  State<InputTextFormField> createState() => _InputTextFormFieldState();
}

class _InputTextFormFieldState extends State<InputTextFormField> {
  bool _passwordVisible = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
            blurRadius: 6,
            color: Colors.black.withOpacity(0.1),
            blurStyle: BlurStyle.normal,
            offset: const Offset(0, 0)),
      ]),
      child: TextFormField(
        keyboardType: widget.type,
        controller: widget.controller,
        obscureText: widget.isSecureField && !_passwordVisible,
        enableSuggestions: !widget.isSecureField,
        autocorrect: widget.autoCorrect,
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
          filled: true,
          fillColor: Colors.white,
          hintText: widget.hint,
          hintStyle: TextStyle(color: AppColors.appColor),
          suffixIcon: widget.isSecureField
              ? IconButton(
                  icon: Icon(
                    _passwordVisible ? Icons.visibility : Icons.visibility_off,
                    color: Theme.of(context).primaryColorDark,
                  ),
                  onPressed: () {
                    setState(() {
                      _passwordVisible = !_passwordVisible;
                    });
                  },
                )
              : null,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide.none),
        ),
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: widget.validator,
      ),
    );
  }
}
