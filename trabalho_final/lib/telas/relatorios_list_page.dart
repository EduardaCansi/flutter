import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:trabalho_final/model/Relatorio.dart';
import 'package:trabalho_final/sqlite/RelatorioHelper.dart';
import 'package:trabalho_final/telas/relatorios_edit_page.dart';
import 'package:trabalho_final/util/dialogos.dart';
import 'package:flutter/material.dart';

class RelatoriosListPage extends StatefulWidget {
  const RelatoriosListPage({super.key, this.title});
  final String? title;

  @override
  State<RelatoriosListPage> createState() => _RelatoriosListPageState();
}

class _RelatoriosListPageState extends State<RelatoriosListPage> {
  final relatoriosDb = RelatorioHelper();
  List<Relatorio> relatorios = List.empty();
  Relatorio? selecionado;

  final _telefoneMaskFormatter = MaskTextInputFormatter(
      mask: '(##) #####-####',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);

  void _getAllRelatorios() {
    relatoriosDb.obterTodos().then((list) {
      setState(() {
        relatorios = list;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _getAllRelatorios();
  }

  selecionar(int selecao) {
    selecionado = relatorios[selecao];
    _showContactPage();
  }

  void _incluir() {
    selecionado = Relatorio();
    _showContactPage();
  }

  void _showContactPage() async {
    final result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => RelatoriosEditPage(
                  selecionado: selecionado,
                )));
    if (result != null) {
      if (result == 'Salvar') {
        if (selecionado!.id == null) {
          relatoriosDb.inserir(selecionado!).then((_) {
            _getAllRelatorios();
            Dialogos.showAlertDialog(context, 'Dados inseridos com sucesso!');
          });
        } else {
          relatoriosDb.alterar(selecionado!).then((_) {
            _getAllRelatorios();
            Dialogos.showAlertDialog(context, 'Dados alterados com sucesso!');
          });
        }
      } else if (result == 'Excluir') {
        relatoriosDb.excluir(selecionado!.id!).then((_) {
          _getAllRelatorios();
          Dialogos.showAlertDialog(context, 'Dados excluídos com sucesso!');
        });
      } else if (result == 'Cancelar') {}
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Listagem"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: ListView.separated(
            padding: const EdgeInsets.all(10.0),
            itemCount: relatorios.length,
            scrollDirection: Axis.vertical,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(relatorios[index].nome!),
                      const SizedBox(width: 30),
                      Text(relatorios[index].bairro!),
                      const SizedBox(width: 20),
                      Text(_telefoneMaskFormatter
                          .maskText(relatorios[index].telefone!)),
                    ]),
                onTap: () => selecionar(index),
              );
            },
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incluir,
        tooltip: 'incluir',
        child: const Icon(Icons.add),
      ),
    );
  }
}
