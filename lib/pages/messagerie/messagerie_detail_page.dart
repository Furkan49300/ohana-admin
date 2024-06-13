import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MessagerieDetailPage extends StatelessWidget {
  final Map<String, dynamic> message;
  final String messageId;
  final VoidCallback onBackPressed;

  const MessagerieDetailPage(
      {super.key,
      required this.message,
      required this.messageId,
      required this.onBackPressed});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Détails du Message'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: onBackPressed,
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () => _deleteMessage(context),
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
                "Nom: ${message['lastname']}",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                "Prénom: ${message['firstname']}",
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 10),
              Text(
                "Email: ${message['email']}",
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 10),
              Text(
                "Offre: ${message['offer']}",
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 10),
              Text(
                "Contenu:",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                message['content'],
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _deleteMessage(BuildContext context) async {
    bool confirm = await _showConfirmationDialog(context);
    if (confirm) {
      try {
        await FirebaseFirestore.instance
            .collection('messagerie')
            .doc(messageId)
            .delete();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Message supprimé avec succès')),
        );
        onBackPressed();
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erreur lors de la suppression du message')),
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
              content: Text('Voulez-vous vraiment supprimer ce message?'),
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
}
