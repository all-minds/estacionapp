import 'package:flutter/material.dart';

class DefaultAppBar extends StatelessWidget implements PreferredSizeWidget {
  const DefaultAppBar({super.key, required this.onLogoutPressed});

  final Function onLogoutPressed;

  @override
  Size get preferredSize => const Size.fromHeight(50);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: [
        IconButton(
            onPressed: () => {onLogoutPressed()},
            icon: const Icon(Icons.logout))
      ],
    );
  }
}
