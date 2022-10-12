import 'package:estacionapp/constants/routes.dart';
import 'package:estacionapp/screens/home.dart';
import 'package:estacionapp/screens/parking_lots_list.dart';
import 'package:estacionapp/screens/sign_in.dart';
import 'package:estacionapp/services/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseMessagingService().initializeMessaging();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Estacionapp',
      theme: ThemeData(
        // brightness: Brightness.dark,
        primarySwatch: Colors.blue,
      ),
      // home: const SignIn(title: 'Estacionapp'),
      routes: {
        Routes.home: (context) => const Home(),
        Routes.signIn: (context) => const SignIn()
      },
    );
  }
}
