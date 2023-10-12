import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class TeamDetail extends StatefulWidget {
  final String teamName;
  final String teamId;

  TeamDetail({Key? key, required this.teamName, required this.teamId}) : super(key: key);

  @override
  State<TeamDetail> createState() => _TeamDetailState();
}

class _TeamDetailState extends State<TeamDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Détails de l\'équipe',
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
              players(team_id: ${widget.teamId}) {
                name
                position
                goalsScored
                assists
                yellowCards
                redCards
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

          final players = result.data!['players'];

          return Column(
            children: [
              Center(
                child: Text(
                  'Nom de l\'équipe : ${widget.teamName}',
                  style: TextStyle(fontSize: 18),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: players.length,
                  itemBuilder: (context, index) {
                    final player = players[index];
                    return ListTile(
                      title: Text(player['name']),
                      subtitle: Text('Cartons jaunes: ${player['yellowCards']}, Cartons rouges: ${player['redCards']}, Buts: ${player['goalsScored']}, Poste: ${player['position']}'),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
