import 'dart:async';
import 'package:app_aula/model/Contato.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

const String contactTable = "contatos";
const String idCol = "_id";
const String nomeCol = "nome";
const String emailCol = "email";
const String telefoneCol = "telefone";

class ContatoHelper {
  static final ContatoHelper _instance = ContatoHelper.internal();
  factory ContatoHelper() => _instance;
  ContatoHelper.internal();
  Database? _db = null;

  Future<Database> get db async {
    if (_db != null) {
      return _db!;
    } else {
      _db = await initDb();
      return _db!;
    }
  }

  Future<Database> initDb() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, "basecontatos.db");
    return await openDatabase(path, version: 1,
        onCreate: (Database db, int newerVersion) async {
      await db.execute(
          "CREATE TABLE $contactTable ($idCol TEXT PRIMARY KEY , $nomeCol TEXT, $emailCol TEXT, $telefoneCol TEXT)");
    });
  }

  Future<Contato> inserir(Contato contact) async {
    Database dbContact = await db;
    int? idNew = Sqflite.firstIntValue(
        await dbContact.rawQuery("SELECT MAX($idCol) FROM $contactTable"));
    if (idNew == null) {
      idNew = 1;
    } else {
      idNew = idNew + 1;
    }
    contact.id = idNew.toString();
    await dbContact.insert(contactTable, contact.toMap());
    return contact;
  }

  Future<Contato?> getObjeto(int idFind) async {
    Database dbContact = await db;
    List<Map<String, dynamic>> maps = await dbContact.query(contactTable,
        columns: [idCol, nomeCol], where: "$idCol = ?", whereArgs: [idFind]);
    if (maps.isNotEmpty) {
      return Contato.fromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<int> excluir(String idDel) async {
    Database dbContact = await db;
    return await dbContact
        .delete(contactTable, where: "$idCol = ?", whereArgs: [idDel]);
  }

  Future<int> alterar(Contato contact) async {
    Database dbContact = await db;
    return await dbContact.update(contactTable, contact.toMap(),
        where: "$idCol = ?", whereArgs: [contact.id]);
  }

  Future<List<Contato>> obterTodos() async {
    Database dbContact = await initDb();
    List listMap = await dbContact.rawQuery("SELECT * FROM $contactTable");
    List<Contato> listContact = List.empty(growable: true);
    for (Map<String, dynamic> m in listMap) {
      listContact.add(Contato.fromMap(m));
    }
    return listContact;
  }

  Future<int?> getQuantidade() async {
    Database dbContact = await db;
    return Sqflite.firstIntValue(
        await dbContact.rawQuery("SELECT COUNT(*) FROM $contactTable"));
  }

  Future<int?> getMaiorId() async {
    Database dbContact = await db;
    return Sqflite.firstIntValue(
        await dbContact.rawQuery("SELECT MAX(*) FROM $contactTable"));
  }

  Future close() async {
    Database dbContact = await db;
    dbContact.close();
  }
}
