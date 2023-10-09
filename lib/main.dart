import 'package:flutter/material.dart';
import 'package:world_cup/classement.dart';
import 'package:world_cup/poules.dart';
import 'package:world_cup/recherche.dart';

import 'matchs.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark().copyWith(
        // Utilisez le themeData.dark() pour obtenir un thème sombre de base
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          // Définissez la couleur du texte pour les icônes inactives ici
          unselectedItemColor: Colors.grey,
        ),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0; // Index for the selected bottom navigation bar item

  // List of widgets to be displayed based on the selected item
  final List<Widget> _views = [
    MatchListPage(),
    MatchSearchPage(),
    TeamRankingPage(),
    GroupStandingsPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Remove the appBar
      appBar: null,
      body: Container(
        // Set the background color to grey[900]
        color: Colors.grey[900],
        child: _views[_currentIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment_outlined),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.table_chart),
            label: '',
          ),
        ],
        // Set the background color of the bottom bar to black
        backgroundColor: Colors.black,
      ),
    );
  }
}

class EmptyView extends StatelessWidget {
  final String title;

  const EmptyView({Key? key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        title,
        style: TextStyle(
          fontSize: 24,
          color: Colors.white, // Set the text color to white
        ),
      ),
    );
  }
}
