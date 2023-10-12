import 'package:flutter/material.dart';
import 'package:graphql/client.dart';
import 'package:world_cup/main.dart';

class Register extends StatelessWidget {
  const Register({Key? key});

  Future<void> createUser(BuildContext context, String username, String password) async {
    final client = GraphQLClient(
      link: HttpLink('http://10.0.2.2:3100/graphql'), // Remplacez par l'URL de votre serveur GraphQL
      cache: GraphQLCache(),
    );

    final result = await client.query(
      QueryOptions(
        document: gql('''
          query CreateUser(\$username: String!, \$password: String!) {
            createUser(username: \$username, password: \$password) {
              username
            }
          }
        '''),
        variables: {
          'username': username,
          'password': password,
        },
      ),
    );

    if (result.hasException) {
      print('GraphQL Error: ${result.exception.toString()}');
      // Gérer l'erreur d'inscription
      // Par exemple, afficher un toast pour indiquer l'échec de l'inscription
    } else {
      final userData = result.data?['createUser'];
      if (userData != null) {
        print('User created: ${userData['username']}');
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MyHomePage()),
        );
      } else {
        // Gérer l'échec de l'inscription
        // Par exemple, afficher un toast pour indiquer l'échec de l'inscription
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController usernameController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Inscription',
        ),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: usernameController,
                decoration: const InputDecoration(
                  labelText: 'Nom',
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: passwordController,
                decoration: const InputDecoration(
                  labelText: 'Mot de passe',
                ),
                obscureText: true,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => createUser(
                  context,
                  usernameController.text,
                  passwordController.text,
                ),
                child: const Text("S'inscrire"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
