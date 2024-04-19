import 'package:flutter/material.dart';

import '../../widgets/input_form_button.dart';
import '../../widgets/input_text_button.dart';
import '../../widgets/input_text_form_field.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(flex: 3, child: Image.asset("assets/images/app_logo.png")),
            const Expanded(
              child: Text(
                "Please enter your e-mail address and password",
                style: TextStyle(fontSize: 16, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              child: InputTextFormField(
                controller: emailController,
                hint: 'Email',
              ),
            ),
            Expanded(
              child: InputFormButton(
                onClick: () {},
                titleText: 'Continue',
              ),
            ),
            Expanded(
              child: InputTextButton(
                onClick: () {
                  Navigator.of(context).pop();
                },
                titleText: 'Back',
              ),
            ),
            const Spacer(
              flex: 2,
            ),
          ],
        ),
      ),
    ));
  }
}
