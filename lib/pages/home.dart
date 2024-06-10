import 'package:flutter/material.dart';
import 'package:ohana_admin/appbar.dart';
import 'package:ohana_admin/pages/article/add_articles.dart';
import 'package:ohana_admin/pages/article/articles_page.dart';
import 'package:ohana_admin/pages/candidatures_page.dart';
import 'package:ohana_admin/pages/devis/devis_page.dart';
import 'package:ohana_admin/pages/lateral_bar.dart';
import 'package:ohana_admin/pages/emploi/add_offres.dart';
import 'package:ohana_admin/pages/apercu_page.dart';
import 'package:ohana_admin/pages/emploi/offres_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Widget _selectedPage;
  var currentPage = "apercu";
  @override
  void initState() {
    super.initState();
    _selectedPage = ApercuPage();
  }

  void _showApercuPage() {
    setState(() {
      _selectedPage = ApercuPage();
      currentPage = "apercu";
    });
  }

  void _showArticlesPage() {
    setState(() {
      _selectedPage = ArticlesPage(onAddArticlePressed: _showAddArticlesPage);
      currentPage = "articles";
    });
  }

  void _showDevisPage() {
    setState(() {
      _selectedPage = DevisPage();
      currentPage = "devis";
    });
  }

  void _showOffresPage() {
    setState(() {
      _selectedPage = OffresPage(onAddOffrePressed: _showAddOffresPage);
      currentPage = "offres";
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          LateralBar(
            onArticlesPressed: _showArticlesPage,
            onDevisPressed: _showDevisPage,
            onOffresPressed: _showOffresPage,
            onApercuPressed: _showApercuPage,
            onCandidaturesPressed: _showCandidaturesPage,
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
