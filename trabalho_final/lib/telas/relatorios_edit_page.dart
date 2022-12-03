import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import '../model/Relatorio.dart';

class RelatoriosEditPage extends StatefulWidget {
  const RelatoriosEditPage({super.key, this.selecionado});

  final Relatorio? selecionado;

  @override
  State<RelatoriosEditPage> createState() => _RelatoriosEditPageState();
}

class _RelatoriosEditPageState extends State<RelatoriosEditPage> {
  final _formKey = GlobalKey<FormState>();

  final _nomeCon = TextEditingController();
  final _telefoneCon = TextEditingController();
  final _ruaCon = TextEditingController();
  final _bairroCon = TextEditingController();
  final _pontoRefCon = TextEditingController();
  final _problemaCon = TextEditingController();

  final _telefoneMaskFormatter = MaskTextInputFormatter(
      mask: '(##) #####-####',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);

  @override
  void initState() {
    super.initState();
    _nomeCon.text = widget.selecionado!.nome!;
    _telefoneCon.text =
        _telefoneMaskFormatter.maskText(widget.selecionado!.telefone!);
    _ruaCon.text = widget.selecionado!.rua!;
    _bairroCon.text = widget.selecionado!.bairro!;
    _pontoRefCon.text = widget.selecionado!.pontoRef!;
    _problemaCon.text = widget.selecionado!.problema!;
  }

  void salvar() {
    widget.selecionado!.nome = _nomeCon.text;
    widget.selecionado!.telefone =
        _telefoneMaskFormatter.getUnmaskedText().isNotEmpty
            ? _telefoneMaskFormatter.getUnmaskedText()
            : _telefoneCon.text;
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
        body: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Padding(
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
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Obrigatório";
                        }

                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _telefoneCon,
                      keyboardType: TextInputType.phone,
                      inputFormatters: [_telefoneMaskFormatter],
                      maxLength: 15,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Telefone',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Obrigatório';
                        }

                        if (value.length != 15) {
                          return "Telefone inválido";
                        }

                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _ruaCon,
                      keyboardType: TextInputType.text,
                      maxLength: 40,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Rua',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Obrigatório";
                        }

                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _bairroCon,
                      keyboardType: TextInputType.text,
                      maxLength: 20,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Bairro',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Obrigatório";
                        }

                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _pontoRefCon,
                      keyboardType: TextInputType.text,
                      maxLength: 40,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Ponto de Referencia',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Obrigatório";
                        }

                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _problemaCon,
                      keyboardType: TextInputType.multiline,
                      maxLength: 255,
                      maxLines: 4,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Problema',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Obrigatório";
                        }

                        return null;
                      },
                    ),
                    Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                            child: const Text('Salvar'),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                salvar();
                              }
                            },
                          ),
                        ),
                        if (widget.selecionado!.id != null)
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
            )));
  }
}
