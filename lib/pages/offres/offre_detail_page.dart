import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class OffreDetailPage extends StatelessWidget {
  final Map<String, dynamic> jobOffer;
  final String offreId; // Ajoutez l'ID de l'offre
  final VoidCallback
      onBackPressed; // Ajoutez un callback pour le bouton de retour

  const OffreDetailPage(
      {super.key,
      required this.jobOffer,
      required this.offreId,
      required this.onBackPressed});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: onBackPressed, // Utilisez le callback ici
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () => _deleteOffre(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        // Ajoutez SingleChildScrollView ici
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (jobOffer['url_image'] != null &&
                jobOffer['url_image'].isNotEmpty)
              SizedBox(width: 350, child: Image.network(jobOffer['url_image'])),
            SizedBox(height: 10),
            Text(
              jobOffer['title'],
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              "Lieu: ${jobOffer['place']}",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Text(
              "Type de contrat: ${jobOffer['contract']}",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Text(
              "Salaire: ${jobOffer['salary']} € par mois",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Text(
              "Durée: ${jobOffer['duration']}",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Text(
              "Publié le: ${jobOffer['publish_date']}",
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),
            SizedBox(height: 20),
            Text(
              jobOffer['description'],
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            Text(
              "Profil recherché:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            for (var profil in jobOffer['profil'])
              Text(
                "- $profil",
                style: TextStyle(fontSize: 16),
              ),
          ],
        ),
      ),
    );
  }

  void _deleteOffre(BuildContext context) async {
    bool confirm = await _showConfirmationDialog(context);
    if (confirm) {
      try {
        await FirebaseFirestore.instance
            .collection('emploi')
            .doc(offreId)
            .delete();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Offre supprimée avec succès')),
        );
        onBackPressed(); // Navigate back after deletion
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erreur lors de la suppression de l\'offre')),
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
              content: Text('Voulez-vous vraiment supprimer cette offre?'),
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
