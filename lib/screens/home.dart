import 'package:estacionapp/components/google_sign_in_button.dart';
import 'package:estacionapp/constants/spacing.dart';
import 'package:estacionapp/repositories/parking_repository.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key, required this.title});

  final String title;

  @override
  State<StatefulWidget> createState() => _Home();
}

class _Home extends State<Home> {
  void onSignInPressed() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
              padding: const EdgeInsets.only(
                  left: Spacing.base,
                  right: Spacing.base,
                  top: Spacing.base,
                  bottom: Spacing.medium),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(),
                  Expanded(
                      child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Flexible(
                        flex: 1,
                        child: Image.asset('assets/estacionapp-logo.png'),
                      )
                    ],
                  )),
                  GoogleSignInButton(
                    onPressed: () => {},
                  )
                ],
              ))),
    );
  }
}
