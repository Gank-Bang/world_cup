import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graphql/client.dart';

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

  final _client = GraphQLClient(
    link: HttpLink('http://localhost:3100/graphql'),
    cache: GraphQLCache(),
  );

  List<dynamic> _searchResults = [];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _performSearch() async {
    setState(() {
      _searchQuery = _searchController.text;
    });

    final QueryResult result = await _client.query(
      QueryOptions(
        document: gql('''
            query SearchPlayers(\$searchQuery: String!) {
              filteredPlayersByName(playerName: \$searchQuery) {
                id
                name
                yellowCards
                redCards
                goalsScored
                assists
                position
              }
            }
          '''),
        variables: {'searchQuery': _searchQuery},
      ),
    );

    if (result.hasException) {
      print(result.exception.toString());
      return;
    }

    if (result.data != null) {
      final List<dynamic> searchResultsData = result.data!['filteredPlayersByName'];

      setState(() {
        _searchResults = searchResultsData;
      });
    }
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
                labelText: 'Rechercher un joueur',
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: _performSearch,
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _searchResults.length,
              itemBuilder: (context, index) {
                final player = _searchResults[index];
                return ListTile(
                  title: Text('Nom: ${player['name']}'),
                  subtitle: Text('Role: ${player['position']}\nButs: ${player['goalsScored']}\nAssists: ${player['assists']}\nCartons Jaune: ${player['yellowCards']}\nCartons rouge: ${player['redCards']}'),
                  // Ajoutez d'autres champs ici
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
