import 'package:flutter/material.dart';
import 'package:flutter_loadingindicator/flutter_loadingindicator.dart';
import 'package:productive_families_admin/application/storage/firebase_storage.dart';
import 'package:productive_families_admin/application/widgets/input_form_button.dart';
import 'package:productive_families_admin/application/widgets/input_text_button.dart';
import 'package:productive_families_admin/application/widgets/input_text_form_field.dart';
import 'package:productive_families_admin/auth.dart';
import 'package:productive_families_admin/core/colors.dart';
import 'package:productive_families_admin/core/utils/common.dart';
import 'package:productive_families_admin/core/utils/pattern.dart';
import 'package:productive_families_admin/widget_tree.dart';

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
  final TextEditingController locationController = TextEditingController();

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
                const SizedBox(
                  height: 36,
                ),
                const Text(
                  'Please enter your email to register',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 10,
                ),
                InputTextFormField(
                  type: TextInputType.name,
                  controller: nameController,
                  hint: 'fullName',
                ),
                const SizedBox(
                  height: 20,
                ),
                InputTextFormField(
                  validator: (String? value) {
                    print(int.tryParse(value!));
                    return int.tryParse(value) is int
                        ? value.isEmpty
                            ? 'enter your age please'
                            : value.isEmpty ||
                                    int.tryParse(value)! < 18 ||
                                    int.tryParse(value)! > 100
                                ? 'you must be older than 18'
                                : null
                        : 'please enter numerous only';
                  },
                  type: TextInputType.number,
                  controller: ageController,
                  hint: 'age',
                ),
                const SizedBox(
                  height: 20,
                ),
                InputTextFormField(
                  type: TextInputType.emailAddress,
                  validator: (String? value) {
                    Patterns.emailEnhanced;
                    final regex = RegExp(Patterns.emailEnhanced);
                    return value!.isEmpty || !regex.hasMatch(value)
                        ? 'enter valid email'
                        : null;
                  },
                  controller: emailController,
                  hint: 'Email',
                ),
                const SizedBox(
                  height: 20,
                ),
                InputTextFormField(
                  type: TextInputType.visiblePassword,
                  controller: passwordController,
                  hint: 'Password',
                  isSecureField: true,
                ),
                const SizedBox(
                  height: 20,
                ),
                InputTextFormField(
                  type: TextInputType.name,
                  controller: locationController,
                  hint: 'location',
                  isSecureField: false,
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "gender",
                      style: TextStyle(
                          color: AppColors.appColor,
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
                    if (RegExp(Patterns.emailEnhanced)
                        .hasMatch(emailController.text)) {}
                    EasyLoading.show();
                    await Auth()
                        .createUserWithEmailAndPassword(
                            email: emailController.text,
                            password: passwordController.text)
                        .then((value) {
                      createUser(
                              name: nameController.text,
                              age: int.tryParse(ageController.text) ?? 0,
                              email: emailController.text,
                              gender: selctedItem ?? "",
                              location: locationController.text)
                          .then((value) {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const WidgetTree(),
                          ),
                          (route) => false,
                        );
                      });
                    }).catchError(
                      (error, stackTrace) {
                        if (error
                            .toString()
                            .toLowerCase()
                            .contains("already in use")) {
                          toast("The email address is already in use");
                        } else if (error
                            .toString()
                            .toLowerCase()
                            .contains("The email address is badly formatted")) {
                          toast("The email address is not valid.");
                        } else if (error.code == "auth/operation-not-allowed") {
                          toast("Operation not allowed.");
                        } else if (error.toString().toLowerCase().contains(
                            "password should be at least 6 characters")) {
                          toast("The password is too weak.");
                        }
                        EasyLoading.dismiss();
                      },
                    );
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
