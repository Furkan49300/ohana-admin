import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;

class ArticleDetailPage extends StatelessWidget {
  final Map<String, dynamic> article;
  final String articleId;
  final VoidCallback onBackPressed;

  const ArticleDetailPage({
    Key? key,
    required this.article,
    required this.articleId,
    required this.onBackPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: onBackPressed,
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () => _deleteArticle(context),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                article['title'],
                style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                article['description'],
                style: TextStyle(fontSize: 15),
              ),
              SizedBox(height: 10),
              Text(
                "Publié le: ${article['publish_date']}",
                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              ),
              SizedBox(height: 20),
              ..._buildParagraphs(article['paragraphs']),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildParagraphs(List<dynamic> paragraphs) {
    return paragraphs.map((paragraph) {
      var textDelta = quill.Document.fromJson(jsonDecode(paragraph['text']));
      var textController = quill.QuillController(
        document: textDelta,
        selection: const TextSelection.collapsed(offset: 0),
      );

      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (paragraph['title'] != null)
              Text(
                paragraph['title'],
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            if (paragraph['url_image'] != null && paragraph['url_image'] != '')
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Image.network(paragraph['url_image']),
              ),
            if (paragraph['image_subtitle'] != null)
              Text(
                paragraph['image_subtitle'],
                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              ),
            quill.QuillEditor.basic(
                configurations: quill.QuillEditorConfigurations(
                    controller: textController,
                    enableInteractiveSelection: false)),
            if (paragraph['video'] != null && paragraph['video'] != '')
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  'Video: ${paragraph['video']}',
                  style: TextStyle(fontSize: 14, color: Colors.blue),
                ),
              ),
          ],
        ),
      );
    }).toList();
  }

  void _deleteArticle(BuildContext context) async {
    bool confirm = await _showConfirmationDialog(context);
    if (confirm) {
      try {
        await FirebaseFirestore.instance
            .collection('article')
            .doc(articleId)
            .delete();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Article supprimé avec succès')),
        );
        onBackPressed();
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('Erreur lors de la suppression de l\'article')),
        );
      }
    }
  }

  Future<bool> _showConfirmationDialog(BuildContext context) async {
    return (await showDialog<bool>(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Confirmer la suppression'),
              content: Text('Voulez-vous vraiment supprimer cet article?'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child:
                      Text('Annuler', style: TextStyle(color: Colors.purple)),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child:
                      Text('Supprimer', style: TextStyle(color: Colors.purple)),
                ),
              ],
            );
          },
        )) ??
        false;
  }
}
