import 'package:flutter/material.dart';

class MaisInfoPage extends StatelessWidget {
  const MaisInfoPage({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Mais Info do App")),
      body: Center(
        child: Column(
          children: const [
            Text("Tela com mais informações..."),
            Text("Protótipo com Testes"),
          ],
        ),
      ),
    );
  }
}
