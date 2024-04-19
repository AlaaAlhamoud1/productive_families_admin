import 'package:flutter/material.dart';
import 'package:flutter_loadingindicator/flutter_loadingindicator.dart';
import 'package:productive_families_admin/application/storage/firebase_storage.dart';
import 'package:productive_families_admin/auth.dart';
import 'package:productive_families_admin/widget_tree.dart';

import '../../widgets/input_form_button.dart';
import '../../widgets/input_text_button.dart';
import '../../widgets/input_text_form_field.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

List<String> gender = ['male', 'female'];
String? selctedItem = 'male';

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 150,
                  child: Image.asset("assets/images/new_logo.png"),
                ),
                const Text(
                  'Please Ese Your Email To Register',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 36,
                ),
                InputTextFormField(
                  controller: nameController,
                  hint: 'fullName',
                ),
                const SizedBox(
                  height: 20,
                ),
                InputTextFormField(
                  controller: ageController,
                  hint: 'age',
                ),
                const SizedBox(
                  height: 20,
                ),
                InputTextFormField(
                  controller: emailController,
                  hint: 'Email',
                ),
                const SizedBox(
                  height: 20,
                ),
                InputTextFormField(
                  controller: passwordController,
                  hint: 'Password',
                  isSecureField: true,
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Text(
                      "gender",
                      style: TextStyle(
                          color: Color(0xFF4AC382),
                          fontWeight: FontWeight.bold),
                    ),
                    DropdownButton<String>(
                      value: selctedItem,
                      items: gender
                          .map((item) => DropdownMenuItem<String>(
                              value: item,
                              child: Text(
                                item,
                              )))
                          .toList(),
                      onChanged: (item) {
                        setState(() => selctedItem = item);
                      },
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                InputFormButton(
                  onClick: () async {
                    EasyLoading.show();
                    await Auth()
                        .createUserWithEmailAndPassword(
                            email: emailController.text,
                            password: passwordController.text)
                        .then((value) => print('register'));
                    await createUser(
                            name: nameController.text,
                            age: int.tryParse(ageController.text) ?? 0,
                            email: emailController.text,
                            gender: selctedItem ?? "")
                        .then((value) {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const WidgetTree(),
                        ),
                        (route) => false,
                      );
                    });
                  },
                  titleText: 'Sign Up',
                ),
                InputTextButton(
                  onClick: () {
                    Navigator.of(context).pop();
                  },
                  titleText: "back",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
