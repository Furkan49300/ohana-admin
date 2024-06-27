import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DevisDetailPage extends StatelessWidget {
  final Map<String, dynamic> devis;
  final String devisId;
  final VoidCallback onBackPressed;

  const DevisDetailPage(
      {super.key,
      required this.devis,
      required this.devisId,
      required this.onBackPressed});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Détails du Devis'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: onBackPressed,
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () => _deleteDevis(context),
          ),
          IconButton(
            icon: Icon(Icons.check),
            onPressed: () => _markAsReplied(context),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Nom: ${devis['lastname']}",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                "Prénom: ${devis['firstname']}",
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 10),
              Text(
                "Email: ${devis['email']}",
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 10),
              Text(
                "Offre: ${devis['offer']}",
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 10),
              Text(
                "Contenu:",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                devis['content'],
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _deleteDevis(BuildContext context) async {
    bool confirm = await _showConfirmationDialog(context);
    if (confirm) {
      try {
        await FirebaseFirestore.instance
            .collection('devis')
            .doc(devisId)
            .delete();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Devis supprimé avec succès')),
        );
        onBackPressed();
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erreur lors de la suppression du devis')),
        );
      }
    }
  }

  Future<bool> _showConfirmationDialog(BuildContext context) async {
    return (await showDialog<bool>(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Confirmer la suppression'),
              content: Text('Voulez-vous vraiment supprimer ce devis?'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child:
                      Text('Annuler', style: TextStyle(color: Colors.purple)),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child:
                      Text('Supprimer', style: TextStyle(color: Colors.purple)),
                ),
              ],
            );
          },
        )) ??
        false;
  }

  void _markAsReplied(BuildContext context) async {
    try {
      await FirebaseFirestore.instance
          .collection('devis')
          .doc(devisId)
          .update({'repondu': true});
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Devis marqué comme répondu')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erreur lors de la mise à jour du devis')),
      );
    }
  }
}
