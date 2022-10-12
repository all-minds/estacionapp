import 'package:estacionapp/components/google_sign_in_button.dart';
import 'package:estacionapp/constants/spacing.dart';
import 'package:estacionapp/services/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<StatefulWidget> createState() => _SignIn();
}

class _SignIn extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Padding(
                padding: const EdgeInsets.all(Spacing.base),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: <Widget>[
                          Flexible(
                            flex: 0,
                            child: Image.asset('assets/estacionapp-logo.png'),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              const Padding(
                                  padding:
                                      EdgeInsets.only(bottom: Spacing.medium),
                                  child:
                                      Text('Seu melhor lugar para estacionar')),
                              GoogleSignInButton(onPressed: () async {
                                await FirebaseAuthService(context: context)
                                    .signInWithGoogle();
                              }),
                            ],
                          )
                        ],
                      )
                    ]))));
  }
}
