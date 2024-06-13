import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ohana_admin/pages/composants/section_title.dart';
import 'package:ohana_admin/pages/composants/text_field.dart';

class AddOffrePage extends StatefulWidget {
  const AddOffrePage({super.key});

  @override
  _AddOffreState createState() => _AddOffreState();
}

class _AddOffreState extends State<AddOffrePage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _placeController = TextEditingController();
  final TextEditingController _contractController = TextEditingController();
  final TextEditingController _salaryController = TextEditingController();
  final TextEditingController _publishDateController = TextEditingController();
  final TextEditingController _durationController = TextEditingController();
  final TextEditingController _alertController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final List<TextEditingController> _profileControllers = [
    TextEditingController()
  ];

  @override
  void dispose() {
    _titleController.dispose();
    _placeController.dispose();
    _contractController.dispose();
    _salaryController.dispose();
    _publishDateController.dispose();
    _durationController.dispose();
    _alertController.dispose();
    _descriptionController.dispose();
    for (var controller in _profileControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  Future<void> _createJobOffer() async {
    if (_formKey.currentState!.validate()) {
      try {
        String currentDate = DateFormat('dd MMMM yyyy').format(DateTime.now());

        Map<String, dynamic> jobOfferData = {
          'title': _titleController.text,
          'place': _placeController.text,
          'contract': _contractController.text,
          'salary': double.tryParse(_salaryController.text) ?? 0.0,
          'publish_date': currentDate,
          'duration': _durationController.text,
          'alert': _alertController.text,
          'description': _descriptionController.text,
          'profil':
              _profileControllers.map((controller) => controller.text).toList(),
        };

        CollectionReference jobOffersRef =
            FirebaseFirestore.instance.collection('emploi');
        await jobOffersRef.add(jobOfferData);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Offre d\'emploi créée avec succès')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('Erreur lors de la création de l\'offre : $e')),
        );
      }
    }
  }

  void _addProfileController() {
    setState(() {
      _profileControllers.add(TextEditingController());
    });
  }

  void _removeProfileController(int index) {
    setState(() {
      if (_profileControllers.length > 1) {
        _profileControllers.removeAt(index);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Créer une offre d\'emploi'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BuildSectionTitle(title: 'Informations générales'),
                BuildTextField(
                  controller: _titleController,
                  labelText: 'Titre de l\'offre',
                  validatorMessage: 'Veuillez entrer un titre',
                ),
                BuildTextField(
                  controller: _placeController,
                  labelText: 'Lieu',
                  validatorMessage: 'Veuillez entrer un lieu',
                ),
                BuildTextField(
                  controller: _contractController,
                  labelText: 'Type de contrat',
                  validatorMessage: 'Veuillez entrer un type de contrat',
                ),
                BuildTextField(
                  controller: _salaryController,
                  labelText: 'Salaire en €',
                  validatorMessage: 'Veuillez entrer un salaire',
                ),
                BuildTextField(
                  controller: _durationController,
                  labelText: 'Durée',
                  validatorMessage: 'Veuillez entrer une durée',
                ),
                BuildSectionTitle(title: 'Description'),
                BuildTextField(
                  controller: _descriptionController,
                  labelText: 'Description',
                  validatorMessage: 'Veuillez entrer une description',
                ),
                const SizedBox(height: 20),
                BuildSectionTitle(title: 'Profil requis'),
                ..._buildProfileFields(),
                const SizedBox(height: 10),
                const SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    onPressed: _createJobOffer,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 32, vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      'Créer l\'offre',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildProfileFields() {
    return _profileControllers.asMap().entries.map((entry) {
      int index = entry.key;
      TextEditingController controller = entry.value;
      return Card(
        margin: const EdgeInsets.symmetric(vertical: 10),
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BuildTextField(
                controller: controller,
                labelText: 'Ajouter un critère',
                validatorMessage: 'Veuillez entrer un critère',
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (index == _profileControllers.length - 1)
                    TextButton(
                      onPressed: _addProfileController,
                      child: const Text(
                        'Ajouter un critère',
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                  if (_profileControllers.length > 1)
                    TextButton(
                      onPressed: () => _removeProfileController(index),
                      child: const Text(
                        'Supprimer ce critère',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      );
    }).toList();
  }
}
