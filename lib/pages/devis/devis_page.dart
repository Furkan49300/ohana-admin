import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class DevisPage extends StatelessWidget {
  final Function(Map<String, dynamic>, String) onDevisDetailPressed;

  const DevisPage({super.key, required this.onDevisDetailPressed});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Devis'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('devis')
                  .orderBy('repondu')
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Center(child: Text("Aucun devis trouvé"));
                }

                var docs = snapshot.data!.docs;
                var nonReponduDocs =
                    docs.where((doc) => !(doc['repondu'] ?? false)).toList();
                var reponduDocs =
                    docs.where((doc) => doc['repondu'] ?? false).toList();

                return ListView(
                  children: [
                    if (nonReponduDocs.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Devis non répondus",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ...nonReponduDocs
                        .map((doc) => buildDevisTile(context, doc))
                        .toList(),
                    if (reponduDocs.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Devis répondus",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ...reponduDocs
                        .map((doc) => buildDevisTile(context, doc))
                        .toList(),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDevisTile(BuildContext context, QueryDocumentSnapshot doc) {
    var devis = doc.data() as Map<String, dynamic>;
    var devisId = doc.id;

    var timestamp = devis['date_sent'] as Timestamp;
    var dateTime = timestamp.toDate();
    var formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(dateTime);

    return GestureDetector(
      onTap: () {
        onDevisDetailPressed(devis, devisId);
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        padding: EdgeInsets.all(16),
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
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.blue,
              child: Text(
                devis['lastname'][0],
                style: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${devis['lastname']} ${devis['firstname']}",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "Offre: ${devis['offer']}",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[700],
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "Date: $formattedDate",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
