import 'package:flutter/material.dart';
import '../model/Relatorio.dart';

class RelatoriosEditPage extends StatefulWidget {
  const RelatoriosEditPage({super.key, this.selecionado});

  final Relatorio? selecionado;

  @override
  State<RelatoriosEditPage> createState() => _RelatoriosEditPageState();
}

class _RelatoriosEditPageState extends State<RelatoriosEditPage> {
  final _nomeCon = TextEditingController();
  final _telefoneCon = TextEditingController();
  final _ruaCon = TextEditingController();
  final _bairroCon = TextEditingController();
  final _pontoRefCon = TextEditingController();
  final _problemaCon = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nomeCon.text = widget.selecionado!.nome!;
    _telefoneCon.text = widget.selecionado!.telefone!;
    _ruaCon.text = widget.selecionado!.rua!;
    _bairroCon.text = widget.selecionado!.bairro!;
    _pontoRefCon.text = widget.selecionado!.pontoRef!;
    _problemaCon.text = widget.selecionado!.problema!;

  }

  void salvar() {
    widget.selecionado!.nome = _nomeCon.text;
    widget.selecionado!.telefone = _telefoneCon.text;
    widget.selecionado!.rua = _ruaCon.text;
    widget.selecionado!.bairro = _bairroCon.text;
    widget.selecionado!.pontoRef = _pontoRefCon.text;
    widget.selecionado!.problema = _problemaCon.text;
    Navigator.pop(context, 'Salvar');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edição de Problema'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            TextFormField(
              controller: _nomeCon,
              keyboardType: TextInputType.text,
              maxLength: 20,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Nome',
              ),
            ),
            TextFormField(
              controller: _telefoneCon,
              keyboardType: TextInputType.text,
              maxLength: 20,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Telefone',
              ),
            ),
            TextFormField(
              controller: _ruaCon,
              keyboardType: TextInputType.text,
              maxLength: 40,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Rua',
              ),
            ),
            TextFormField(
              controller: _bairroCon,
              keyboardType: TextInputType.text,
              maxLength: 20,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Bairro',
              ),
            ),
            TextFormField(
              controller: _pontoRefCon,
              keyboardType: TextInputType.text,
              maxLength: 40,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Ponto de Referencia',
              ),
            ),
            TextFormField(
              controller: _problemaCon,
              keyboardType: TextInputType.text,
              maxLength: 50,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Problema',
              ),
            ),
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    child: const Text('Salvar'),
                    onPressed: () {
                      salvar();
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    child: const Text('Excluir'),
                    onPressed: () {
                      Navigator.pop(context, 'Excluir');
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    child: const Text('Cancelar'),
                    onPressed: () {
                      Navigator.pop(context, 'Cancelar');
                    },
                  ),
                ),
              ],
            )
          ],
        )),
      ),
    );
  }
}
