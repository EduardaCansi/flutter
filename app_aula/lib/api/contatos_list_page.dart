import 'package:app_aula/api/contatos_edit_page.dart';
import 'package:app_aula/model/Contato_api.dart';
import 'package:app_aula/api/ContatoHelperApi.dart';
import 'package:app_aula/util/dialogos.dart';
import 'package:flutter/material.dart';

class ContatosListApiPage extends StatefulWidget {
  const ContatosListApiPage({super.key, this.title});
  final String? title;

  @override
  State<ContatosListApiPage> createState() => _ContatosListApiPageState();
}

class _ContatosListApiPageState extends State<ContatosListApiPage> {
  final contatosDb = ContatoHelperApi();
  List<ContatoApi> contatos = List.empty();
  ContatoApi? selecionado;

  void _getAllContacts() {
    contatosDb.obterTodos().then((list) {
      setState(() {
        contatos = list;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _getAllContacts();
  }

  selecionar(int selecao) {
    selecionado = contatos[selecao];
    _showContactPage();
  }

  void _incluir() {
    selecionado = ContatoApi();
    _showContactPage();
  }

  void _showContactPage() async {
    final result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ContatosEditApiPage(
                  selecionado: selecionado,
                )));
    if (result != null) {
      if (result == 'Salvar') {
        if (selecionado!.id == null) {
          contatosDb.inserir(selecionado!).then((_) {
            _getAllContacts();
            Dialogos.showAlertDialog(context, 'Dados inseridos com sucesso!');
          });
        } else {
          contatosDb.alterar(selecionado!).then((_) {
            _getAllContacts();
            Dialogos.showAlertDialog(context, 'Dados alterados com sucesso!');
          });
        }
      } else if (result == 'Excluir') {
        contatosDb.excluir(selecionado!.id!).then((_) {
          _getAllContacts();
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
            itemCount: contatos.length,
            scrollDirection: Axis.vertical,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Row(children: <Widget>[
                  Text('${contatos[index].id}'),
                  const SizedBox(width: 20),
                  Text(contatos[index].nome!),
                  const SizedBox(width: 20),
                  Text(contatos[index].telefone!),
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
