import 'package:flutter/material.dart';

class DevisPage extends StatelessWidget {
  const DevisPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Devis",
            style: TextStyle(fontSize: 25),
          ),
        ),
      ],
    );
  }
}
