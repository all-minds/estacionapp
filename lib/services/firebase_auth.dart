import 'package:estacionapp/services/firebase_messaging.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../constants/routes.dart';

const Map<String, String> authenticationErrorMapper = {
  'account-exists-with-different-credential':
      'A conta já existe com credenciais diferentes!',
  'invalid-credential': 'Credenciais inválidas!',
  'sign-in-failed': 'Falha ao logar!'
};

class FirebaseAuthService {
  final BuildContext context;

  late FirebaseAuth instance;

  FirebaseAuthService({required this.context}) {
    instance = FirebaseAuth.instance;
  }

  static SnackBar customSnackBar({required String message}) {
    return SnackBar(content: Text(message));
  }

  static User? getUser() {
    return FirebaseAuth.instance.currentUser;
  }

  // Encapsulates logout
  Future<void> signOut() async {
    await instance.signOut().then((value) async {
      await Navigator.pushNamed(context, Routes.signIn);
      await FirebaseMessagingService().unsubscribe();
    });
  }

  // Encapsulates google sign in flow
  Future<void> signInWithGoogle() async {
    try {
      // Trigger authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create new credential
      final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);

      await instance.signInWithCredential(credential).then((value) async {
        await Navigator.pushNamedAndRemoveUntil(
            context, Routes.home, (_) => false);
        await FirebaseMessaging.instance.subscribeToTopic(value.user!.uid);
        print('ok');
      });
    } on FirebaseAuthException catch (error) {
      final message = authenticationErrorMapper[error.code] ??
          'Não foi possível logar agora!';

      ScaffoldMessenger.of(context)
          .showSnackBar(FirebaseAuthService.customSnackBar(message: message));

      rethrow;
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
          FirebaseAuthService.customSnackBar(
              message: 'Um erro desconhecido ocorreu, tente novamente!'));

      rethrow;
    }
  }
}
