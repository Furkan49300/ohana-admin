import 'package:flutter/material.dart';

class OffreDetailPage extends StatelessWidget {
  final Map<String, dynamic> jobOffer;

  const OffreDetailPage({super.key, required this.jobOffer});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(jobOffer['title']),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                jobOffer['title'],
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Text(
                'Lieu: ${jobOffer['place']}',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 10),
              Text(
                'Type de contrat: ${jobOffer['contract']}',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 10),
              Text(
                'Salaire: ${jobOffer['salary']}',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 10),
              Text(
                'Date de publication: ${jobOffer['publish_date']}',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 10),
              Text(
                'Durée: ${jobOffer['duration']}',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 10),
              Text(
                'Alerte: ${jobOffer['alert']}',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 20),
              Text(
                'Description',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                jobOffer['description'],
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 20),
              Text(
                'Profil requis',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              ...List<Widget>.from(jobOffer['profil'].map((profile) => Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      profile,
                      style: TextStyle(fontSize: 18),
                    ),
                  ))),
            ],
          ),
        ),
      ),
    );
  }
}
