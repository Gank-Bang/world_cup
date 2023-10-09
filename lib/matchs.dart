import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'World Cup 2018 Matches',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MatchListPage(),
    );
  }
}

class MatchListPage extends StatelessWidget {
  MatchListPage();

  // Exemples de matchs
  final List<Match> matches = [
    Match(
      homeTeam: 'France',
      awayTeam: 'Croatia',
      score: '4 - 2',
    ),
    Match(
      homeTeam: 'Brazil',
      awayTeam: 'Belgium',
      score: '1 - 2',
    ),
    Match(
      homeTeam: 'England',
      awayTeam: 'Sweden',
      score: '2 - 0',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Supprime le bouton de retour
        title: Text(
          'Matchs',
          style: GoogleFonts.bebasNeue(
            fontSize: 24, // Taille de la police
            fontWeight: FontWeight.bold, // Gras
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: matches.length,
        itemBuilder: (context, index) {
          return MatchListItem(match: matches[index]);
        },
      ),
    );
  }
}

class Match {
  final String homeTeam;
  final String awayTeam;
  final String score;

  Match({
    required this.homeTeam,
    required this.awayTeam,
    required this.score,
  });
}

class MatchListItem extends StatelessWidget {
  final Match match;

  const MatchListItem({required this.match});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('${match.homeTeam} vs ${match.awayTeam}'),
      subtitle: Text('Score: ${match.score}'),
      leading: Icon(Icons.sports_soccer),
      // Vous pouvez ajouter d'autres détails du match ici
    );
  }
}
