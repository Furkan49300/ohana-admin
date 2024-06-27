import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ApercuPage extends StatelessWidget {
  const ApercuPage({super.key});

  Future<int> _getDocumentCount(String collectionName) async {
    final QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection(collectionName).get();
    return snapshot.size;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<Map<String, int>>(
        future: _fetchCounts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erreur : ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return Center(child: Text('Aucune donnée disponible'));
          } else {
            final counts = snapshot.data!;
            return GridView.count(
              crossAxisCount: 6,
              crossAxisSpacing: 4.0,
              mainAxisSpacing: 4.0,
              children: [
                _buildCountContainer('Devis', counts['devis']!,
                    Icons.description, Colors.orange),
                _buildCountContainer('Articles', counts['article']!,
                    Icons.article, Colors.green),
                _buildCountContainer('Offres d\'emploi', counts['emploi']!,
                    Icons.work, Colors.purple),
                _buildCountContainer('Messages', counts['messagerie']!,
                    Icons.message, Colors.red),
              ],
            );
          }
        },
      ),
    );
  }

  Future<Map<String, int>> _fetchCounts() async {
    final devisCount = await _getDocumentCount('devis');
    final articleCount = await _getDocumentCount('article');
    final contactsCount = await _getDocumentCount('contacts');
    final emploiCount = await _getDocumentCount('emploi');
    final messagerieCount = await _getDocumentCount('messagerie');

    return {
      'devis': devisCount,
      'article': articleCount,
      'contacts': contactsCount,
      'emploi': emploiCount,
      'messagerie': messagerieCount,
    };
  }

  Widget _buildCountContainer(
      String title, int count, IconData icon, Color color) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      padding: EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 24, color: color), // Taille de l'icône réduite
          SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold), // Taille de texte réduite
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 4),
          Text(
            count.toString(),
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: color), // Taille de texte réduite
          ),
        ],
      ),
    );
  }
}
