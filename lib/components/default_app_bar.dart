import 'package:estacionapp/services/firebase_auth.dart';
import 'package:flutter/material.dart';

class DefaultAppBar extends StatelessWidget implements PreferredSizeWidget {
  const DefaultAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(50);

  logout(BuildContext context) async {
    await FirebaseAuthService(context: context).signOut();
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: [
        IconButton(
            onPressed: () async {
              await logout(context);
            },
            icon: const Icon(Icons.logout))
      ],
    );
  }
}
