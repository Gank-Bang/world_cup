import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TeamDetail extends StatefulWidget {
  final String teamName;

  TeamDetail({Key? key, required this.teamName}) : super(key: key);

  @override
  State<TeamDetail> createState() => _TeamDetailState();
}

class _TeamDetailState extends State<TeamDetail> {
  // Liste de joueurs (en dur pour l'exemple)
  final List<Player> players = [
    Player(name: 'Joueur 1', yellowCards: 2, redCards: 0, goals: 3, position: 'Attaquant'),
    Player(name: 'Joueur 2', yellowCards: 1, redCards: 0, goals: 1, position: 'Milieu'),
    Player(name: 'Joueur 3', yellowCards: 0, redCards: 1, goals: 0, position: 'Défenseur'),
    // Ajoutez d'autres joueurs ici
  ];

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
      body: Column(
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
                  title: Text(player.name),
                  subtitle: Text('Cartons jaunes: ${player.yellowCards}, Cartons rouges: ${player.redCards}, Buts: ${player.goals}, Poste: ${player.position}'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class Player {
  final String name;
  final int yellowCards;
  final int redCards;
  final int goals;
  final String position;

  Player({
    required this.name,
    required this.yellowCards,
    required this.redCards,
    required this.goals,
    required this.position,
  });
}
