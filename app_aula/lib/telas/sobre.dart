import 'package:app_aula/telas/mais_info.dart';
import 'package:flutter/material.dart';

class SobrePage extends StatelessWidget {
  const SobrePage({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false, title: const Text("Sobre o App")),
      body: Center(
        child: Column(
          children: [
            const Text("App de Aula"),
            const Text("Protótipo com Testes"),
            ElevatedButton(
              child: const Text('Voltar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: const Text('Mais Info'),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const MaisInfoPage(),
                ));
              },
            ),
          ],
        ),
      ),
    );
  }
}
