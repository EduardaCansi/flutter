import 'dart:ui';

import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Problemas na Cidade")),
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
              title: const Text('Relatório'),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).pushNamed('/relatorioList');
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Image(
              image: AssetImage('images/luz.jpg'),
            ),
            const Text("Bem Vindo"),
            const Text("Relate Problemas na sua Cidade:"),
            const Text("Lampadas queimadas, buracos, concertos"),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/relatorioList');
              },
              child: const Text("Relatar Problema"),
            ),
          ],
        ),
      ),
    );
  }
}
