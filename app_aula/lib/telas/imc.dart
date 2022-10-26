import 'package:flutter/material.dart';

class ImcPage extends StatefulWidget {
  const ImcPage({super.key, required this.title});

  final String title;

  @override
  State<ImcPage> createState() => _ImcPageState();
}

class _ImcPageState extends State<ImcPage> {
  String _nome = '';
  int _peso = 0;
  int _altura = 0;
  double _imc = 0;

  void _calcular() {
    setState(() {
      _imc = (_peso / _altura) * 2;
    });
  }

  final _formKey = GlobalKey<FormState>();

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
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              //adicionar aqui as widget para o form
              TextFormField(
                keyboardType: TextInputType.name,
                maxLength: 50,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Digite o Nome',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'É preciso informar o nome';
                  }
                  _nome = value;
                  return null;
                },
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                maxLength: 5,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Digite o Peso',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'É preciso informar a idade';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Informe número na idade';
                  }
                  _peso = int.tryParse(value)!;
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
              Text(
                '$_nome, você viveu aproximadamente:',
                style: Theme.of(context).textTheme.headline6,
              ),
              Text(
                '$_imc dias.',
                style: Theme.of(context).textTheme.headline4,
              ),
              /*const Text('Dias que viveu +-'),
              TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Resultado',
                ),
                // usar key para detectar setState
                key: Key(_diasVividos.toString()),
                initialValue: _diasVividos.toString(),
              ),*/
            ],
          ),
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
