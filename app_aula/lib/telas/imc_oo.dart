import 'package:app_aula/model/Imc.dart';
import 'package:app_aula/util/dialogos.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

class ImcOoPage extends StatefulWidget {
  const ImcOoPage({super.key, required this.title});

  final String title;

  @override
  State<ImcOoPage> createState() => _ImcOoPageState();
}

class _ImcOoPageState extends State<ImcOoPage> {
  Imc obj = Imc();
  final List<Imc> entries = <Imc>[];
  final List<int> colorCodes = <int>[200, 100];

  void _calcular() {
    Dialogos.showAlertDialog(context, 'Calculou dias para ${obj.nome}');
    setState(() {
      entries.add(Imc.iniAll(obj.nome, obj.peso, obj.altura, obj.imc));
      resultadoController.text = obj.getResultado();
    });
  }

  final _formKey = GlobalKey<FormState>();
  final resultadoController = TextEditingController();

  void _limpar() {
    setState(() {
      entries.clear();
    });
    GFToast.showToast(
      'Limpou os dados.',
      context,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              // Adicionar aqui as widgets para o form
              TextFormField(
                keyboardType: TextInputType.name,
                maxLength: 50,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Seu nome'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Informe algo no nome';
                  }
                  obj.nome = value;
                  return null;
                },
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                maxLength: 3,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Sua altura'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Informe sua altura';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Informe número na altura';
                  }
                  obj.altura = int.tryParse(value)!;
                  return null;
                },
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                maxLength: 3,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Seu peso'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Informe seu peso';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Informe número no peso';
                  }
                  obj.peso = int.tryParse(value)!;
                  return null;
                },
              ),
              ElevatedButton(
                onPressed: () {
                  // Validate returns true if the form is valid, or false otherwise.
                  if (_formKey.currentState!.validate()) {
                    // If the form is valid, display a snackbar. In the real world,
                    // you'd often call a server or save the information in a database.
                    _calcular();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Calculado com sucesso')),
                    );
                  }
                },
                child: const Text('Calcular'),
              ),
              ElevatedButton(
                onPressed: () {
                  Dialogos.showConfirmDialog(context, 'Confirma?:', _limpar);
                },
                child: const Text('Limpar'),
              ),

              SizedBox(
                height: 200,
                width: 500,
                child: ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: entries.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        height: 50,
                        color:
                            Colors.blueGrey[colorCodes[index % 2 == 0 ? 0 : 1]],
                        child: Center(
                            child: Row(
                          children: [
                            SizedBox(
                                width: 100,
                                child: Text('${entries[index].nome}')),
                            Text('${entries[index].getResultado()}'),
                          ],
                        )),
                      );
                    }),
              ),
            ],
          ),
        ),
      ),

      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
