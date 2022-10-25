import 'package:flutter/material.dart';

class MatriculaPage extends StatelessWidget {
  const MatriculaPage({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Sobre Mim")),
      body: Center(
        child: Column(
          children: const [
            Image(
              image: AssetImage('images/stitch.png'),
            ),
            Text("Nome: Eduarda Cansi"),
            Text("Matricula: 182738"),
            Text("Email: 182738@upf.br"),
            Text("Curso: Analise e Dev de Sistemas"),
            Text("Nível: VI"),
          ],
        ),
      ),
    );
  }
}
