import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Football Match Search',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MatchSearchPage(),
    );
  }
}

class MatchSearchPage extends StatefulWidget {
  const MatchSearchPage();

  @override
  _MatchSearchPageState createState() => _MatchSearchPageState();
}

class _MatchSearchPageState extends State<MatchSearchPage> {
  TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _performSearch() {
    setState(() {
      _searchQuery = _searchController.text;
      print("dsf");
      // Vous pouvez utiliser '_searchQuery' pour effectuer une recherche API ici
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Rechercher',
          style: GoogleFonts.bebasNeue(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Rechercher un match',
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: _performSearch,
                ),
              ),
            ),
          ),
          // Afficher les résultats de la recherche ici
          Expanded(
            child: Center(
              child: Text(
                'Résultats de la recherche : $_searchQuery',
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
