import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:ohana_admin/components/build_message_tile.dart';

class MessageriePage extends StatelessWidget {
  final Function(Map<String, dynamic>, String) onMessageDetailPressed;

  const MessageriePage({super.key, required this.onMessageDetailPressed});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Messagerie'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('messagerie')
                  .orderBy('repondu')
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Center(child: Text("Aucun message trouvé"));
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
                          "Messages non répondus",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ...nonReponduDocs
                        .map((doc) => BuildMessageTile(
                            onMessageDetailPressed: onMessageDetailPressed,
                            context: context,
                            doc: doc))
                        .toList(),
                    if (reponduDocs.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Messages répondus",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ...reponduDocs
                        .map((doc) => BuildMessageTile(
                            onMessageDetailPressed: onMessageDetailPressed,
                            context: context,
                            doc: doc))
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
}
