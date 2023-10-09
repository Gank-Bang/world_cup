import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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

  // Exemples de classement des poules
  final List<Group> groups = [
    Group(
      groupName: 'Groupe A',
      teams: [
        Team(position: 1, name: 'France', points: 9),
        Team(position: 2, name: 'Brazil', points: 6),
        Team(position: 3, name: 'Germany', points: 3),
        Team(position: 4, name: 'Spain', points: 0),
      ],
    ),
    Group(
      groupName: 'Groupe B',
      teams: [
        Team(position: 1, name: 'Argentina', points: 7),
        Team(position: 2, name: 'Italy', points: 5),
        Team(position: 3, name: 'Netherlands', points: 4),
        Team(position: 4, name: 'Portugal', points: 1),
      ],
    ),
    // Ajoutez d'autres groupes ici
  ];

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
      body: ListView.builder(
        itemCount: groups.length,
        itemBuilder: (context, index) {
          return GroupStandingsItem(group: groups[index]);
        },
      ),
    );
  }
}

class Group {
  final String groupName;
  final List<Team> teams;

  Group({
    required this.groupName,
    required this.teams,
  });
}

class Team {
  final int position;
  final String name;
  final int points;

  Team({
    required this.position,
    required this.name,
    required this.points,
  });
}

class GroupStandingsItem extends StatelessWidget {
  final Group group;

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
              group.groupName,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Divider(),
          Column(
            children: group.teams.map((team) {
              return ListTile(
                leading: Text('${team.position}.'),
                title: Text('${team.name} : ${team.points} points'),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
