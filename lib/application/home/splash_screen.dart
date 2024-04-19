import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../business_logic/blocs/auth/auth_bloc.dart';
import '../router/app_router.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            Navigator.of(context).pushNamedAndRemoveUntil(
                AppRouter.signIn, ModalRoute.withName(''));
          } else if (state is AuthFail) {}
        },
        child: Scaffold(
          body: Column(children: [
            Expanded(flex: 4, child: Image.asset('assets/images/new_logo.png')),
            const Expanded(
              flex: 3,
              child: Padding(
                padding: EdgeInsets.only(left: 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Welcom to',
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.w900)),
                    Expanded(
                      child: Text('Potea',
                          style: TextStyle(
                              fontSize: 50,
                              color: Color(0xFF4AC382),
                              fontWeight: FontWeight.w900)),
                    ),
                    Expanded(
                      child: SizedBox(
                        width: 350,
                        child: Text(
                            'The best plant e-commerce & online store app of the contury for your needs!',
                            style: TextStyle(fontSize: 13)),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ]),
        ));
  }
}
