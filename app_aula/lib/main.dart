import 'package:app_aula/telas/contador.dart';
import 'package:app_aula/telas/dias_vividos_oo.dart';
import 'package:app_aula/telas/exemplo_listview.dart';
import 'package:app_aula/telas/home.dart';
import 'package:app_aula/telas/imc_oo.dart';
import 'package:app_aula/telas/sobre.dart';
import 'package:app_aula/telas/matricula.dart';
import 'package:app_aula/telas/dias_vividos.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
      routes: {
        '/home': (context) => const HomePage(),
        '/contador': (context) => const ContadorPage(title: "Contador"),
        '/sobre': (context) => const SobrePage(),
        '/matricula': (context) => const MatriculaPage(),
        '/diasVividos': (context) =>
            const DiasVividosPage(title: "Dias Vividos"),
        '/diasVividosOo': (context) =>
            const DiasVividosOoPage(title: 'Dias vividos OO'),
        '/exemploListView': (context) =>
            const ExemploListPage(title: 'Exemplo ListView'),
        '/imcOo': (context) => const ImcOoPage(title: 'Imc Oo'),
      },
    );
  }
}
