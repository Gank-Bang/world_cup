import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:world_cup/create_team.dart';
import 'package:world_cup/team_detail.dart';

class TeamRankingPage extends StatelessWidget {
  TeamRankingPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Classement',
          style: GoogleFonts.bebasNeue(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const CreateTeam(),
                ),
              );
            },
          ),
        ],
      ),
      body: Query(
        options: QueryOptions(
          document: gql('''
            query {
              teams {
                id
                name
                flagURL
              }
            }
          '''),
        ),
        builder: (QueryResult result, {VoidCallback? refetch, FetchMore? fetchMore}) {
          if (result.hasException) {
            print(result.exception);
            return Text('Erreur GraphQL: ${result.exception}');
          }

          if (result.isLoading) {
            return Text('Chargement...');
          }

          final List<dynamic> teamData = result.data?['teams'] ?? [];

          return ListView.builder(
            itemCount: teamData.length,
            itemBuilder: (context, index) {
              final team = Team.fromJson(teamData[index]);
              return TeamRankingItem(team: team);
            },
          );
        },
      ),
    );
  }
}

class Team {
  final String id;
  final String name;
  final String flagURL;

  Team({
    required this.id,
    required this.name,
    required this.flagURL,
  });

  factory Team.fromJson(Map<String, dynamic> json) {
    return Team(
      id: json['id'] as String,
      name: json['name'] as String,
      flagURL: json['flagURL'] as String? ?? '',
    );
  }
}
class TeamRankingItem extends StatelessWidget {
  final Team team;

  TeamRankingItem({required this.team});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: team.flagURL != ''
          ? Image.network(
              team.flagURL,
              width: 40,
              height: 30,
            )
          : Image.asset('assets/téléchargement.jpeg'), 
      title: Text(
        ' ${team.name}',
        style: const TextStyle(fontSize: 18),
      ),
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => TeamDetail(teamName: team.name, teamId: team.id),
          ),
        );
      },
    );
  }
}
