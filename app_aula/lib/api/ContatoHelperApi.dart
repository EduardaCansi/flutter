import 'package:app_aula/model/Contato_api.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ContatoHelperApi {
  String uri = "http://localhost:3000";

  Future<String> inserir(ContatoApi contact) async {
    final res = await http.post(Uri.parse('$uri/contato'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(contact.toMap()));
    return res.body;
  }

  Future<ContatoApi> getObjeto(String idFind) async {
    final res = await http.get(Uri.parse('$uri/contato/$idFind'));
    if (res.statusCode == 200) {
      ContatoApi c = ContatoApi.fromMap(jsonDecode(res.body));
      return c;
    } else {
      throw Exception('Erro ao recuperar o objeto.');
    }
  }

  Future<String> excluir(String idDel) async {
    final res = await http.delete(Uri.parse('$uri/contato/$idDel'));
    return res.body;
  }

  Future<int> alterar(ContatoApi contact) async {
    final res = await http.put(Uri.parse('$uri/contato'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(contact.toMap()));
    return 0;
  }

  Future<List<ContatoApi>> obterTodos() async {
    final res = await http.get(Uri.parse('$uri/contato'));
    if (res.statusCode == 200) {
      List jsonList = json.decode(res.body);
      List<ContatoApi> listContact = List.empty(growable: true);
      for (Map<String, dynamic> m in jsonList) {
        ContatoApi c = ContatoApi.fromMap(m);
        listContact.add(c);
      }
      return listContact;
    } else {
      throw Exception('Erro ao recuperar os objetos.');
    }
  }
}
