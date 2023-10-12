import 'package:flutter/material.dart';
import 'package:graphql/client.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:world_cup/main.dart';
import 'package:world_cup/register.dart';


class Login extends StatelessWidget {
  const Login({Key? key});

  Future<void> loginUser(context, String username, String password) async {
    final client = GraphQLClient(
      link: HttpLink('http://10.0.2.2:3100/graphql'), // Remplacez par l'URL de votre serveur GraphQL
      cache: GraphQLCache(),
    );

    final result = await client.query(
      QueryOptions(
        document: gql('''
          query Login(\$username: String!, \$password: String!) {
            login(username: \$username, password: \$password) {
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
      Fluttertoast.showToast(
        msg: 'Vérifiez votre mot de passe',
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    } else {
      final userData = result.data?['login'];
      if (userData != null) {
        print('Logged in as: ${userData['username']}');
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MyHomePage()),
        );
      } else {
        Fluttertoast.showToast(
          msg: 'Vérifiez votre mot de passe',
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
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
          'Connexion',
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
                  labelText: 'Adresse e-mail',
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
                onPressed: () => loginUser(
                  context,
                  usernameController.text,
                  passwordController.text,
                ),
                child: const Text('Se connecter'),
              ),
              ElevatedButton(
                onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Register()),
        ),
                child: const Text('Creer un compte'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
