import 'package:app_aula/model/DiasVividos.dart';
import 'package:app_aula/util/dialogos.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

class DiasVividosOoPage extends StatefulWidget {
  const DiasVividosOoPage({super.key, required this.title});
  final String title;
  @override
  State<DiasVividosOoPage> createState() => _DiasVividosOoPageState();
}

class _DiasVividosOoPageState extends State<DiasVividosOoPage> {
  DiasVividos obj = DiasVividos();
  final List<DiasVividos> entries = <DiasVividos>[];
  final List<int> colorCodes = <int>[600, 100];

  void _calcular() {
    Dialogos.showAlertDialog(context, 'Calculou dias para ${obj.nome}');
    setState(() {
      entries.add(DiasVividos.iniAll(obj.nome, obj.idade));
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
                    border: OutlineInputBorder(), labelText: 'Sua idade'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Informe sua idade';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Informe número na idade';
                  }
                  obj.idade = int.tryParse(value)!;
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
              Text(
                '${obj.nome}, você viveu aproximadamente',
                style: Theme.of(context).textTheme.headline5,
              ),
              Text(
                '${obj.getDiasVividos()} dias.',
                style: Theme.of(context).textTheme.headline4,
              ),
              const Text('Dias que viveu +-'),
              TextFormField(
                controller: resultadoController,
                readOnly: true,
                keyboardType: TextInputType.none,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Resultado',
                ),
              ),

              SizedBox(
                height: 200,
                width: 300,
                child: ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: entries.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        height: 50,
                        color: Colors.amber[colorCodes[index % 2 == 0 ? 0 : 1]],
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
