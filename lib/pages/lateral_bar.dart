import 'package:flutter/material.dart';

class LateralBar extends StatefulWidget {
  final VoidCallback onApercuPressed;
  final VoidCallback onArticlesPressed;
  final VoidCallback onDevisPressed;
  final VoidCallback onOffresPressed;
  final VoidCallback onCandidaturesPressed;
  final String currentPage;

  const LateralBar(
      {super.key,
      required this.onApercuPressed,
      required this.onArticlesPressed,
      required this.onDevisPressed,
      required this.onOffresPressed,
      required this.currentPage,
      required this.onCandidaturesPressed});

  @override
  _LateralBarState createState() => _LateralBarState();
}

class _LateralBarState extends State<LateralBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      color: Color.fromARGB(255, 58, 57, 73),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
                width: 100,
                child: Image(image: AssetImage("assets/images/logo2.png"))),
          ),
          SizedBox(
            width: double.infinity,
            child: TextButton(
              onPressed: widget.onApercuPressed,
              style: TextButton.styleFrom(
                backgroundColor: widget.currentPage == 'apercu'
                    ? Color.fromARGB(129, 148, 142, 141)
                    : Colors.transparent,
              ),
              child: Text("Aperçu"),
            ),
          ),
          SizedBox(height: 30),
          SizedBox(
            width: double.infinity,
            child: TextButton(
              onPressed: widget.onArticlesPressed,
              style: TextButton.styleFrom(
                backgroundColor: widget.currentPage == 'articles' ||
                        widget.currentPage == 'add_article'
                    ? Color.fromARGB(129, 148, 142, 141)
                    : Colors.transparent,
              ),
              child: Text("Actualités"),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: TextButton(
              onPressed: widget.onDevisPressed,
              style: TextButton.styleFrom(
                backgroundColor: widget.currentPage == 'devis'
                    ? Color.fromARGB(129, 148, 142, 141)
                    : Colors.transparent,
              ),
              child: Text("Devis"),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: TextButton(
              onPressed: widget.onOffresPressed,
              style: TextButton.styleFrom(
                backgroundColor: widget.currentPage == 'offres' ||
                        widget.currentPage == 'add_offre'
                    ? Color.fromARGB(129, 148, 142, 141)
                    : Colors.transparent,
              ),
              child: Text("Offres d'emplois"),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: TextButton(
              onPressed: widget.onCandidaturesPressed,
              style: TextButton.styleFrom(
                backgroundColor: widget.currentPage == 'candidature'
                    ? Color.fromARGB(129, 148, 142, 141)
                    : Colors.transparent,
              ),
              child: Text("Candidatures"),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                backgroundColor: widget.currentPage == 'aze'
                    ? Color.fromARGB(129, 148, 142, 141)
                    : Colors.transparent,
              ),
              child: Text("Messages"),
            ),
          ),
        ],
      ),
    );
  }
}
