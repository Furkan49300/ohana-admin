import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:flutter_quill/flutter_quill.dart';

class EditArticlePage extends StatefulWidget {
  final Map<String, dynamic> article;
  final String articleId;
  final VoidCallback onSave;

  const EditArticlePage(
      {Key? key,
      required this.article,
      required this.articleId,
      required this.onSave})
      : super(key: key);

  @override
  _EditArticlePageState createState() => _EditArticlePageState();
}

class _EditArticlePageState extends State<EditArticlePage> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late quill.QuillController _quillController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.article['title']);
    _descriptionController =
        TextEditingController(text: widget.article['description']);

    var textDelta = quill.Document.fromJson(
        jsonDecode(widget.article['paragraphs'][0]['text']));
    _quillController = quill.QuillController(
      document: textDelta,
      selection: const TextSelection.collapsed(offset: 0),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Modifier l\'article'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveArticle,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: 'Titre',
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.purple, width: 2.0),
                  ),
                ),
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.purple, width: 2.0),
                  ),
                ),
                style: TextStyle(fontSize: 16),
                maxLines: null,
              ),
              SizedBox(height: 20),
              QuillToolbar.simple(
                  configurations: quill.QuillSimpleToolbarConfigurations(
                      controller: _quillController)),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: QuillEditor.basic(
                  configurations: QuillEditorConfigurations(
                    placeholder: 'Texte',
                    padding: EdgeInsets.all(20),
                    controller: _quillController,
                    sharedConfigurations: const QuillSharedConfigurations(
                      locale: Locale('fr'),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton.icon(
                icon: Icon(Icons.save),
                label: Text('Enregistrer'),
                onPressed: _saveArticle,
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  textStyle: TextStyle(fontSize: 18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _saveArticle() async {
    final updatedArticle = {
      'title': _titleController.text,
      'description': _descriptionController.text,
      'paragraphs': [
        {
          'text': jsonEncode(_quillController.document.toDelta().toJson()),
        }
      ],
    };

    try {
      await FirebaseFirestore.instance
          .collection('article')
          .doc(widget.articleId)
          .update(updatedArticle);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Article mis à jour avec succès')),
      );
      widget.onSave();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erreur lors de la mise à jour de l\'article')),
      );
    }
  }
}
