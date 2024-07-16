import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:intl/intl.dart';
import 'package:ohana_admin/pages/composants/section_title.dart';
import 'package:ohana_admin/pages/composants/text_field.dart';
import 'package:ohana_admin/pages/composants/upload_image.dart';
import 'package:diacritic/diacritic.dart';

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
  final TextEditingController _durationController = TextEditingController();
  final TextEditingController _alertController = TextEditingController();
  List<TextEditingController> _profileControllers = [TextEditingController()];
  String? _imageUrl;
  QuillController _quillController = QuillController.basic();

  @override
  void dispose() {
    _titleController.dispose();
    _placeController.dispose();
    _contractController.dispose();
    _salaryController.dispose();
    _durationController.dispose();
    _alertController.dispose();
    _profileControllers.forEach((controller) => controller.dispose());
    _quillController.dispose();
    super.dispose();
  }

  Future<void> _createJobOffer() async {
    if (_formKey.currentState!.validate()) {
      try {
        Timestamp currentTimestamp = Timestamp.fromDate(DateTime.now());

        // Convert Quill editor content to JSON format
        String offerContent =
            jsonEncode(_quillController.document.toDelta().toJson());

        // Function to remove accents and convert to lowercase
        String normalizeString(String input) {
          return removeDiacritics(input).toLowerCase();
        }

        // Generate keywords from the title
        List<String> keywords =
            normalizeString(_titleController.text).split(' ');

        Map<String, dynamic> jobOfferData = {
          'title': _titleController.text,
          'url_image': _imageUrl ?? '',
          'place': _placeController.text,
          'contract': _contractController.text,
          'salary': double.tryParse(_salaryController.text) ?? 0.0,
          'publish_date': currentTimestamp,
          'duration': _durationController.text,
          'alert': _alertController.text,
          'offer_content': offerContent,
          'keywords': keywords,
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

  void _onImageUploaded(String imageUrl) {
    setState(() {
      _imageUrl = imageUrl;
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
                ),
                BuildTextField(
                  controller: _durationController,
                  labelText: 'Durée',
                  validatorMessage: 'Veuillez entrer une durée',
                ),
                UploadImage(onImageUploaded: _onImageUploaded),
                if (_imageUrl != null)
                  SizedBox(width: 100, child: Image.network(_imageUrl!)),
                BuildSectionTitle(title: 'Description'),
                QuillToolbar.simple(
                  configurations: QuillSimpleToolbarConfigurations(
                    controller: _quillController,
                    sharedConfigurations: const QuillSharedConfigurations(
                      locale: Locale(
                          'fr'), // Changed to French locale for consistency
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 30),
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.black)),
                  child: QuillEditor.basic(
                    configurations: QuillEditorConfigurations(
                      placeholder: 'Description de l\'offre',
                      padding: EdgeInsets.all(20),
                      controller: _quillController,
                      sharedConfigurations: const QuillSharedConfigurations(
                        locale: Locale('fr'),
                      ),
                    ),
                  ),
                ),
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
}
