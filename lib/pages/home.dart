import 'package:flutter/material.dart';
import 'package:ohana_admin/appbar.dart';
import 'package:ohana_admin/pages/article/add_articles.dart';
import 'package:ohana_admin/pages/article/article_detail_page.dart';
import 'package:ohana_admin/pages/article/articles_page.dart';
import 'package:ohana_admin/pages/candidatures_page.dart';
import 'package:ohana_admin/pages/devis/devis_details_page.dart';
import 'package:ohana_admin/pages/devis/devis_page.dart';
import 'package:ohana_admin/pages/lateral_bar.dart';
import 'package:ohana_admin/pages/messagerie/messagerie_detail_page.dart';
import 'package:ohana_admin/pages/messagerie/messagerie_page.dart';
import 'package:ohana_admin/pages/offres/add_offres.dart';
import 'package:ohana_admin/pages/apercu_page.dart';
import 'package:ohana_admin/pages/offres/offre_detail_page.dart';
import 'package:ohana_admin/pages/offres/offres_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Widget _selectedPage;
  var currentPage = "apercu";
  bool isLateralBarVisible = true;

  @override
  void initState() {
    super.initState();
    _selectedPage = ApercuPage();
  }

  void _toggleLateralBar() {
    setState(() {
      isLateralBarVisible = !isLateralBarVisible;
    });
  }

  void _showApercuPage() {
    setState(() {
      _selectedPage = ApercuPage();
      currentPage = "apercu";
    });
  }

  void _showArticlesPage() {
    setState(() {
      _selectedPage = ArticlesPage(
        onAddArticlePressed: _showAddArticlesPage,
        onArticleDetailPressed: _showArticleDetailPage,
      );
      currentPage = "articles";
    });
  }

  void _showDevisPage() {
    setState(() {
      _selectedPage = DevisPage(
        onDevisDetailPressed: _showDevisDetailPage,
      );
      currentPage = "devis";
    });
  }

  void _showOffresPage() {
    setState(() {
      _selectedPage = OffresPage(
        onAddOffrePressed: _showAddOffresPage,
        onOffreDetailPressed: _showOffreDetailPage,
      );
      currentPage = "offres";
    });
  }

  void _showMessageriePage() {
    setState(() {
      _selectedPage = MessageriePage(
        onMessageDetailPressed: _showMessageDetailPage,
      );
      currentPage = "messagerie";
    });
  }

  void _showAddArticlesPage() {
    setState(() {
      _selectedPage = AddArticlesPage();
      currentPage = "add_article";
    });
  }

  void _showAddOffresPage() {
    setState(() {
      _selectedPage = AddOffrePage();
      currentPage = "add_offre";
    });
  }


  void _showCandidaturesPage() {
    setState(() {
      _selectedPage = CandidaturesPage();
      currentPage = "candidature";
    });
  }

  void _showArticleDetailPage(Map<String, dynamic> article, String articleId) {
    setState(() {
      _selectedPage = ArticleDetailPage(
        article: article,
        articleId: articleId,
        onBackPressed: _showArticlesPage,
      );
      currentPage = "article_detail";
    });
  }

  void _showOffreDetailPage(Map<String, dynamic> offre, String offreId) {
    setState(() {
      _selectedPage = OffreDetailPage(
        jobOffer: offre,
        offreId: offreId,
        onBackPressed: _showOffresPage,
      );
      currentPage = "offre_detail";
    });
  }

  void _showDevisDetailPage(Map<String, dynamic> devis, String devisId) {
    setState(() {
      _selectedPage = DevisDetailPage(
        devis: devis,
        devisId: devisId,
        onBackPressed: _showDevisPage,
      );
      currentPage = "devis_detail";
    });
  }

  void _showMessageDetailPage(Map<String, dynamic> message, String messageId) {
    setState(() {
      _selectedPage = MessagerieDetailPage(
        message: message,
        messageId: messageId,
        onBackPressed: _showMessageriePage,
      );
      currentPage = "message_detail";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(onMenuPressed: _toggleLateralBar),
      body: Row(
        children: [
          if (isLateralBarVisible)
            LateralBar(
              onArticlesPressed: _showArticlesPage,
              onDevisPressed: _showDevisPage,
              onOffresPressed: _showOffresPage,
              onApercuPressed: _showApercuPage,
              onCandidaturesPressed: _showCandidaturesPage,
              onMessageriePressed: _showMessageriePage,
              currentPage: currentPage,
            ),
          Expanded(
            child: _selectedPage,
          ),
        ],
      ),
    );
  }
}
