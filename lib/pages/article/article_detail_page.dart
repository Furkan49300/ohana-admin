import 'package:flutter/material.dart';

class ArticleDetailPage extends StatelessWidget {
  final Map<String, dynamic> article;
  final String articleId; // Accept the document ID

  const ArticleDetailPage(
      {super.key, required this.article, required this.articleId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(article['title']),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                article['title'],
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                "Published on: ${article['publish_date']}",
                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              ),
              SizedBox(height: 20),
              Text(
                article['description'],
                style: TextStyle(fontSize: 18),
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
            if (paragraph['text'] != null)
              Text(
                paragraph['text'],
                style: TextStyle(fontSize: 16),
              ),
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
}
