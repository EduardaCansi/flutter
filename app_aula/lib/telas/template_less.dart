import 'package:flutter/material.dart';

class SobrePage extends StatelessWidget {
  const SobrePage({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Sobre o App")),
      body: Center(
        child: Column(
          children: const [
            Text("App de Aula"),
            Text("Protótipo com Testes"),
          ],
        ),
      ),
    );
  }
}
