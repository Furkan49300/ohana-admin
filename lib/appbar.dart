import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onMenuPressed;

  const MyAppBar({super.key, required this.onMenuPressed});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.purple,
      centerTitle: true,
      title: const Text("OHana Admin"),
      leading: Builder(
        builder: (BuildContext context) {
          return IconButton(
            icon: const Icon(Icons.menu),
            onPressed: onMenuPressed,
          );
        },
      ),
      actions: [IconButton(onPressed: () {}, icon: Icon(Icons.login))],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
