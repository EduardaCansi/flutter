import 'dart:ui';

import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("App Aula")),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.add),
              title: const Text('Contador'),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).pushNamed('/contador');
              },
            ),
            ListTile(
              leading: const Icon(Icons.help_center),
              title: const Text('Sobre'),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).pushNamed('/sobre');
              },
            ),
            ListTile(
              leading: const Icon(Icons.account_circle_outlined),
              title: const Text('Eu'),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).pushNamed('/matricula');
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Image(
              image: AssetImage('images/upf.png'),
            ),
            const Text("Bem Vindo ao App"),
            const Text("Protótipo de Testes"),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/contador');
              },
              child: const Text("Contador"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/sobre');
              },
              child: const Text("Sobre"),
            ),
          ],
        ),
      ),
    );
  }
}
