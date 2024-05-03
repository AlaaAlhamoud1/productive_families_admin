import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_loadingindicator/flutter_loadingindicator.dart';
import 'package:productive_families_admin/application/authentication/sign_up/sign_up_screen.dart';
import 'package:productive_families_admin/auth.dart';
import 'package:productive_families_admin/core/data/local_data/shared_pref.dart';
import 'package:productive_families_admin/core/utils/common.dart';

import '../../widgets/input_form_button.dart';
import '../../widgets/input_text_form_field.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  String? errorMessage = '';
  bool isLogIn = true;
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  Future<void> signInWithEmailAndPassword(
      {required String email, required String pass}) async {
    try {
      await Auth().signInWithEmailAndPassword(email: email, password: pass);
      await setValue('EMAIL', email);
    } on FirebaseAuthException catch (e) {
      if (e.message.toString().characters.length < 50) {
        print(e.message.toString().characters.length);
        toast(e.message);
      } else {
        toast('check your internet');
      }
    }
  }

  Future<void> createUserWithEmailAndPassword() async {
    try {
      await Auth().createUserWithEmailAndPassword(
          email: _controllerEmail.text, password: _controllerPassword.text);
    } on FirebaseAuthException catch (e) {
      if (e.message.toString().characters.length < 50) {
        print(e.message.toString().characters.length);
        toast(e.message);
      }
    }
  }

  @override
  void initState() {
    EasyLoading.dismiss();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Image.asset("assets/images/new_logo.png"),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InputTextFormField(
                    type: TextInputType.emailAddress,
                    controller: _controllerEmail,
                    hint: "Email",
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: InputTextFormField(
                      type: TextInputType.name,
                      controller: _controllerPassword,
                      hint: "Password",
                      isSecureField: true,
                    ),
                  ),
                ],
              ),
              InputFormButton(
                onClick: () async {
                  await EasyLoading.show(status: 'loading...');
                  signInWithEmailAndPassword(
                          email: _controllerEmail.text,
                          pass: _controllerPassword.text)
                      .then(
                    (value) async {
                      await setValue('ID', _controllerEmail.text);
                      EasyLoading.dismiss();
                    },
                  );
                },
                titleText: "sign In",
              ),
              Row(
                children: [
                  const Text("dont have account?"),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SignUpScreen(),
                            ));
                      },
                      child: const Text('Register'))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
