import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class CandidaturePage extends StatelessWidget {
  final Function(Map<String, dynamic>, String) onCandidatureDetailPressed;

  const CandidaturePage({super.key, required this.onCandidatureDetailPressed});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Candidatures'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('candidature')
                  .orderBy('date', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Center(child: Text("Aucune candidature trouvée"));
                }

                var docs = snapshot.data!.docs;

                return ListView(
                  children: docs
                      .map((doc) => buildCandidatureTile(context, doc))
                      .toList(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCandidatureTile(BuildContext context, QueryDocumentSnapshot doc) {
    var candidature = doc.data() as Map<String, dynamic>;
    var candidatureId = doc.id;

    var timestamp = (candidature['date'] as Timestamp).toDate();
    var formattedDate = DateFormat('yyyy-MM-dd').format(timestamp);

    return GestureDetector(
      onTap: () {
        onCandidatureDetailPressed(candidature, candidatureId);
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
                candidature['lastName'][0],
                style: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${candidature['lastName']} ${candidature['firstName']}",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "Offre postulée: ${candidature['joboffers']}",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[700],
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    "Email: ${candidature['email']}",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[700],
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  GestureDetector(
                    onTap: () => _launchURL(candidature['cv']),
                    child: Text(
                      "Lien vers cv",
                      style: TextStyle(fontSize: 16, color: Colors.blue),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  if (candidature['cover_letter'].isNotEmpty)
                    Text(
                      "Lettre de motivation: ${candidature['cover_letter']}",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[700],
                      ),
                    )
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
                SizedBox(height: 5),
                if (candidature['cv'].isNotEmpty)
                  Text(
                    "CV Disponible",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.green,
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Impossible de charger le fichier $url';
    }
  }
}
