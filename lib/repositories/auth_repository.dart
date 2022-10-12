import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

const Map<String, String> authenticationErrorMapper = {
  'account-exists-with-different-credential':
      'A conta já existe com credenciais diferentes!',
  'invalid-credential': 'Credenciais inválidas!',
  'sign-in-failed': 'Falha ao logar!'
};

class AuthRepository {
  final BuildContext context;

  late FirebaseAuth instance;
  late User? loggedUser;

  AuthRepository({required this.context}) {
    instance = FirebaseAuth.instance;
  }

  static SnackBar customSnackBar({required String message}) {
    return SnackBar(content: Text(message));
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

      await instance.signInWithCredential(credential);
      loggedUser = instance.currentUser;
    } on FirebaseAuthException catch (error) {
      final message = authenticationErrorMapper[error.code] ??
          'Não foi possível logar agora!';

      ScaffoldMessenger.of(context)
          .showSnackBar(AuthRepository.customSnackBar(message: message));

      rethrow;
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(AuthRepository.customSnackBar(
          message: 'Um erro desconhecido ocorreu, tente novamente!'));

      rethrow;
    }
  }
}
