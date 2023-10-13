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
            return const CircularProgressIndicator();
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
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Divider(),
          Column(
            children: (group['teams'] as List).map((team) {
              final flagURL = team['flagURL'];
              return ListTile(
                leading: flagURL != null
                    ? Image.network(
                        flagURL,
                        width: 40,
                        height: 40,
                      )
                    : const Icon(Icons.flag), // Remplacez Icon(Icons.flag) par le widget que vous souhaitez afficher en cas d'absence de drapeau.
                title: Text(team['name']),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

