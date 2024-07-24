import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:intl/intl.dart';
import 'package:ohana_admin/components/section_title.dart';
import 'package:ohana_admin/components/text_field.dart';
import 'package:ohana_admin/components/upload_image.dart';

class AddArticlesPage extends StatefulWidget {
  const AddArticlesPage({super.key});

  @override
  _AddArticlesPageState createState() => _AddArticlesPageState();
}

class _AddArticlesPageState extends State<AddArticlesPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _publishDateController = TextEditingController();
  final TextEditingController _updateDateController = TextEditingController();
  List<Map<String, dynamic>> _paragraphControllers = [];
  String? imageUrl;

  @override
  void initState() {
    super.initState();
    _addParagraphController();
  }

  void _addParagraphController() {
    setState(() {
      _paragraphControllers.add({
        'url_image': null,
        'image_subtitle': TextEditingController(),
        'text': QuillController.basic(),
        'video': TextEditingController(),
      });
    });
  }

  void _removeParagraphController(int index) {
    setState(() {
      _paragraphControllers.removeAt(index);
    });
  }

  void _createArticle() async {
    if (_formKey.currentState!.validate()) {
      DateTime now = DateTime.now();
      Timestamp currentTimestamp = Timestamp.fromDate(now);

      Map<String, dynamic> articleData = {
        'title': _titleController.text,
        'description': _descriptionController.text,
        'publish_date': currentTimestamp,
        'update_date': currentTimestamp,
        'image': imageUrl ?? '',
        'paragraphs': _paragraphControllers.map((paragraph) {
          return {
            'url_image': paragraph['url_image'] ?? '',
            'image_subtitle': paragraph['image_subtitle'].text,
            'text': jsonEncode(paragraph['text'].document.toDelta().toJson()),
            'video': paragraph['video'].text,
          };
        }).toList(),
      };

      CollectionReference articlesRef =
          FirebaseFirestore.instance.collection('article');
      await articlesRef.add(articleData);

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Article créé avec succès')));
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _publishDateController.dispose();
    _updateDateController.dispose();
    for (var controller in _paragraphControllers) {
      controller.forEach((key, value) {
        if (value is TextEditingController) {
          value.dispose();
        } else if (value is QuillController) {
          value.dispose();
        }
      });
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Créer un article'),
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
                  labelText: 'Titre de l\'article',
                  validatorMessage: 'Veuillez entrer un titre',
                ),
                BuildTextField(
                    controller: _descriptionController,
                    labelText: 'Description',
                    validatorMessage: 'Veuillez entrer une description'),
                const SizedBox(height: 20),
                UploadImage(onImageUploaded: (url) {
                  setState(() {
                    imageUrl = url;
                  });
                }),
                if (imageUrl != null)
                  SizedBox(width: 100, child: Image.network(imageUrl!)),
                BuildSectionTitle(title: 'Paragraphes'),
                ..._buildParagraphFields(),
                const SizedBox(height: 10),
                Center(
                  child: ElevatedButton(
                    onPressed: _addParagraphController,
                    child: const Text(
                      'Ajouter un paragraphe',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    onPressed: _createArticle,
                    child: const Text(
                      'Créer l\'article',
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

  List<Widget> _buildParagraphFields() {
    return _paragraphControllers.asMap().entries.map((entry) {
      int index = entry.key;
      Map<String, dynamic> controllers = entry.value;
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
              Text("Texte du paragraphe",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              QuillToolbar.simple(
                configurations: QuillSimpleToolbarConfigurations(
                  controller: controllers['text'],
                  sharedConfigurations: const QuillSharedConfigurations(
                    locale: Locale('fr'),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 30),
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.black)),
                child: QuillEditor.basic(
                  configurations: QuillEditorConfigurations(
                    placeholder: 'Texte',
                    padding: EdgeInsets.all(20),
                    controller: controllers['text'],
                    sharedConfigurations: const QuillSharedConfigurations(
                      locale: Locale('fr'),
                    ),
                  ),
                ),
              ),
              UploadImage(onImageUploaded: (url) {
                setState(() {
                  controllers['url_image'] = url;
                });
              }),
              if (controllers['url_image'] != null)
                SizedBox(
                    width: 100,
                    child: Image.network(controllers['url_image']!)),
              BuildTextField(
                controller: controllers['image_subtitle'],
                labelText: 'Sous-titre de l\'image',
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => _removeParagraphController(index),
                    child: const Text(
                      'Supprimer ce paragraphe',
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
