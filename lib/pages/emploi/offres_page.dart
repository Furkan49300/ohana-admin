import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OffresPage extends StatelessWidget {
  final VoidCallback onAddOffrePressed;

  const OffresPage({super.key, required this.onAddOffrePressed});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Offres d'emploi",
            style: TextStyle(fontSize: 25),
          ),
        ),
        Container(
            margin: EdgeInsets.only(bottom: 20),
            height: 250,
            child: Placeholder()),
        ElevatedButton(
            onPressed: onAddOffrePressed,
            child: Text("Ajouter une offre d'emploi"))
      ],
    );
  }
}
