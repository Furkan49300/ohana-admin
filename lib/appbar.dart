import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.purple,
      centerTitle: true,
      title: const Text("OHana Admin"),
      leading: const Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.person),
            const SizedBox(width: 8),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Bamy',
                  style: TextStyle(fontSize: 14),
                ),
                Text(
                  'Admin',
                  style: TextStyle(fontSize: 12, color: Colors.white70),
                ),
              ],
            ),
          ],
        ),
      ),
      actions: [IconButton(onPressed: () {}, icon: Icon(Icons.login))],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
