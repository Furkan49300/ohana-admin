import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OffresPage extends StatelessWidget {
  final VoidCallback onAddOffrePressed;
  final Function(Map<String, dynamic>, String) onOffreDetailPressed;

  const OffresPage(
      {super.key,
      required this.onAddOffrePressed,
      required this.onOffreDetailPressed});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Offres d\'emploi'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection('emploi').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Center(child: Text("Aucune offre d'emploi trouvée"));
                }
                return Wrap(
                  alignment: WrapAlignment.start,
                  spacing: 8.0,
                  runSpacing: 10.0,
                  children: snapshot.data!.docs.map((doc) {
                    var offre = doc.data() as Map<String, dynamic>;
                    var offreId = doc.id;

                    // Convertir le timestamp en DateTime
                    DateTime publishDate =
                        (offre['publish_date'] as Timestamp).toDate();
                    // Formater la date
                    String formattedPublishDate =
                        DateFormat('dd/MM/yyyy').format(publishDate);

                    return MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        onTap: () {
                          onOffreDetailPressed(offre, offreId);
                        },
                        child: Container(
                          width: 250,
                          height: 250,
                          margin:
                              EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  offre['title'],
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  'Date de publication: $formattedPublishDate',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey[700],
                                  ),
                                ),
                                Text(
                                  'Durée: ${offre['duration']}',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey[700],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: ElevatedButton(
                onPressed: onAddOffrePressed,
                child: Text("Ajouter une offre d'emploi"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
