import 'package:flutter/material.dart';
import 'package:ohana_admin/auth.dart';
import 'package:ohana_admin/pages/authentication.dart';
import 'package:ohana_admin/pages/home.dart';

class WidgetTree extends StatefulWidget {
  const WidgetTree({super.key});

  @override
  State<WidgetTree> createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: Auth().authStateChanges,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return HomePage();
          } else {
            return const AuthenticationPage();
          }
        });
  }
}
