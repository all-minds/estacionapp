import 'package:estacionapp/components/default_app_bar.dart';
import 'package:estacionapp/services/firebase_auth.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final authRepository = FirebaseAuthService(context: context);

    return Scaffold(
        appBar: DefaultAppBar(onLogoutPressed: authRepository.signOut),
        body: Column());
  }
}
