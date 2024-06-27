import 'package:flutter/material.dart';
import 'package:ohana_admin/auth.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onMenuPressed;

  const MyAppBar({super.key, required this.onMenuPressed});
  Future<void> signOut() async {
    await Auth().signOut();
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.purple,
      centerTitle: true,
      title: const Text("OHana Admin", style: TextStyle(fontSize: 18)),
      leading: Builder(
        builder: (BuildContext context) {
          return IconButton(
            icon: const Icon(Icons.menu),
            onPressed: onMenuPressed,
          );
        },
      ),
      actions: [
        IconButton(
            onPressed: () {
              signOut();
            },
            icon: Icon(Icons.login))
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
