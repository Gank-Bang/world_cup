import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Classement de la Coupe du Monde',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TeamRankingPage(),
    );
  }
}

class TeamRankingPage extends StatelessWidget {
  TeamRankingPage();

  // Exemples de classement d'équipes
  final List<Team> teams = [
    Team(
      position: 1,
      name: 'France',
      flagUrl:
          'https://upload.wikimedia.org/wikipedia/en/thumb/c/c3/Flag_of_France.svg/1280px-Flag_of_France.svg.png',
    ),
    Team(
      position: 2,
      name: 'Croatia',
      flagUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/1/1b/Flag_of_Croatia.svg/1280px-Flag_of_Croatia.svg.png',
    ),
    Team(
      position: 3,
      name: 'Brazil',
      flagUrl:
          'https://upload.wikimedia.org/wikipedia/en/thumb/0/05/Flag_of_Brazil.svg/1280px-Flag_of_Brazil.svg.png',
    ),
    Team(
      position: 4,
      name: 'Belgium',
      flagUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/Flag_of_Belgium.svg/1280px-Flag_of_Belgium.svg.png',
    ),
    // Ajoutez d'autres équipes ici
  ];

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
      ),
      body: ListView.builder(
        itemCount: teams.length,
        itemBuilder: (context, index) {
          return TeamRankingItem(team: teams[index]);
        },
      ),
    );
  }
}

class Team {
  final int position;
  final String name;
  final String flagUrl;

  Team({
    required this.position,
    required this.name,
    required this.flagUrl,
  });
}

class TeamRankingItem extends StatelessWidget {
  final Team team;

  TeamRankingItem({required this.team});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(
        team.flagUrl,
        width: 40,
        height: 30,
      ),
      title: Text(
        '${team.position}. ${team.name}',
        style: TextStyle(fontSize: 18),
      ),
      // Vous pouvez ajouter d'autres détails du classement ici
    );
  }
}
