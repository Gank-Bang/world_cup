import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

void main() {
  runApp(const MyApp());
}

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Matchs',
          style: GoogleFonts.bebasNeue(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Query(
        options: QueryOptions(
          document: gql('''
            query {
              matchs {
                id
                matchDay
                teamA {
                  name
                }
                teamB {
                  name
                }
                teamAScore
                teamBScore
              }
            }
          '''),
        ),
        builder: (QueryResult result, {refetch, fetchMore}) {
          if (result.hasException) {
            return Text('Erreur de chargement des données: ${result.exception.toString()}');
          }

          if (result.isLoading) {
            return CircularProgressIndicator();
          }

          final matches = result.data!['matchs'];

          return ListView.builder(
            itemCount: matches.length,
            itemBuilder: (context, index) {
              final match = matches[index];
              return MatchListItem(
      homeTeam: match['teamA']['name'],
      awayTeam: match['teamB']['name'],
      score: '${match['teamAScore']} - ${match['teamBScore']}',
      //matchDay: match['matchDay'],
    );
            },
          );
        },
      ),
    );
  }
}

class MatchListItem extends StatelessWidget {
  final String homeTeam;
  final String awayTeam;
  final String score;
  //final String matchDay;

  const MatchListItem({
    required this.homeTeam,
    required this.awayTeam,
    required this.score,
    //required this.matchDay,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text('$homeTeam vs $awayTeam'),
        subtitle: Text('Score: $score'),
        //trailing: Text('Journée $matchDay'),
        leading: Icon(Icons.sports_soccer),
      ),
    );
  }
}
