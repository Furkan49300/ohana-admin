import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:intl/intl.dart';

class OffreDetailPage extends StatelessWidget {
  final String offreId;
  final VoidCallback onBackPressed;
  final Map<String, dynamic> jobOffer;

  const OffreDetailPage(
      {super.key,
      required this.offreId,
      required this.onBackPressed,
      required this.jobOffer});

  Future<Map<String, dynamic>> _fetchJobOffer() async {
    DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
        .collection('emploi')
        .doc(offreId)
        .get();
    return documentSnapshot.data() as Map<String, dynamic>;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: _fetchJobOffer(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: onBackPressed,
              ),
            ),
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.hasError) {
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: onBackPressed,
              ),
            ),
            body: Center(child: Text('Erreur de chargement de l\'offre')),
          );
        }

        if (!snapshot.hasData || snapshot.data == null) {
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: onBackPressed,
              ),
            ),
            body: Center(
                child: Text('Aucune donnée disponible pour cette offre')),
          );
        }

        Map<String, dynamic> jobOffer = snapshot.data!;
        Timestamp publishTimestamp = jobOffer['publish_date'];
        DateTime publishDate = publishTimestamp.toDate();
        String formattedPublishDate =
            DateFormat('dd/MM/yyyy').format(publishDate);

        var textDelta =
            quill.Document.fromJson(jsonDecode(jobOffer['offer_content']));
        var textController = quill.QuillController(
          document: textDelta,
          selection: const TextSelection.collapsed(offset: 0),
        );

        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: onBackPressed,
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: () => _deleteOffre(context),
              ),
            ],
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (jobOffer['url_image'] != null &&
                    jobOffer['url_image'].isNotEmpty)
                  SizedBox(
                      width: 350, child: Image.network(jobOffer['url_image'])),
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
                  "Salaire: ${jobOffer['salary']} € par mois",
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 10),
                Text(
                  "Publié le: $formattedPublishDate",
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),
                SizedBox(height: 20),
                quill.QuillEditor.basic(
                    configurations: quill.QuillEditorConfigurations(
                        controller: textController,
                        enableInteractiveSelection: false))
              ],
            ),
          ),
        );
      },
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
        onBackPressed();
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
