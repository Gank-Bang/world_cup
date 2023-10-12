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
      title: 'Classement des Poules',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: GroupStandingsPage(),
    );
  }
}

class GroupStandingsPage extends StatelessWidget {
  GroupStandingsPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Classement des Poules',
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
              groups {
                name
                teams {
                  name
                  flagURL
                }
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

          final groups = result.data!['groups'];

          return ListView.builder(
            itemCount: groups.length,
            itemBuilder: (context, index) {
              final group = groups[index];
              return GroupStandingsItem(group: group);
            },
          );
        },
      ),
    );
  }
}

class GroupStandingsItem extends StatelessWidget {
  final dynamic group;

  GroupStandingsItem({required this.group});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.all(8),
      child: Column(
        children: [
          ListTile(
            title: Text(
              group['name'],
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Divider(),
          Column(
            children: (group['teams'] as List).map((team) {
              return ListTile(
                leading: Image.network(
                  team['flagURL'], // Utilisez le champ 'flagURL' pour afficher le drapeau
                  width: 40,
                  height: 40,
                ),
                title: Text(team['name']),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
