import 'dart:async';
import 'package:trabalho_final/model/Relatorio.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

const String relatoriorioTable = "relatoriorio";
const String idCol = "_id";
const String nomeCol = "nome";
const String telefoneCol = "telefone";
const String ruaCol = "rua";
const String bairroCol = "bairro";
const String pontoRefCol = "pontoRef";
const String problemaCol = "problema";

class RelatorioHelper {
  static final RelatorioHelper _instance = RelatorioHelper.internal();
  factory RelatorioHelper() => _instance;
  RelatorioHelper.internal();
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
    final path = join(databasesPath, "baserelatorios.db");
    return await openDatabase(path, version: 1,
        onCreate: (Database db, int newerVersion) async {
      await db.execute(
          "CREATE TABLE $relatoriorioTable ($idCol TEXT PRIMARY KEY , $nomeCol TEXT, $telefoneCol TEXT, $ruaCol TEXT, $bairroCol TEXT , $pontoRefCol TEXT , $problemaCol TEXT)");
    });
  }

  Future<Relatorio> inserir(Relatorio relatorio) async {
    Database dbRelatorio = await db;
    int? idNew = Sqflite.firstIntValue(
        await dbRelatorio.rawQuery("SELECT MAX($idCol) FROM $relatoriorioTable"));
    if (idNew == null) {
      idNew = 1;
    } else {
      idNew = idNew + 1;
    }
    relatorio.id = idNew.toString();
    await dbRelatorio.insert(relatoriorioTable, relatorio.toMap());
    return relatorio;
  }

  Future<Relatorio?> getObjeto(int idFind) async {
    Database dbRelatorio = await db;
    List<Map<String, dynamic>> maps = await dbRelatorio.query(relatoriorioTable,
        columns: [idCol, nomeCol], where: "$idCol = ?", whereArgs: [idFind]);
    if (maps.isNotEmpty) {
      return Relatorio.fromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<int> excluir(String idDel) async {
    Database dbRelatorio = await db;
    return await dbRelatorio
        .delete(relatoriorioTable, where: "$idCol = ?", whereArgs: [idDel]);
  }

  Future<int> alterar(Relatorio relatorio) async {
    Database dbRelatorio = await db;
    return await dbRelatorio.update(relatoriorioTable, relatorio.toMap(),
        where: "$idCol = ?", whereArgs: [relatorio.id]);
  }

  Future<List<Relatorio>> obterTodos() async {
    Database dbRelatorio = await initDb();
    List listMap = await dbRelatorio.rawQuery("SELECT * FROM $relatoriorioTable");
    List<Relatorio> listRelatorio = List.empty(growable: true);
    for (Map<String, dynamic> m in listMap) {
      listRelatorio.add(Relatorio.fromMap(m));
    }
    return listRelatorio;
  }

  Future<int?> getQuantidade() async {
    Database dbRelatorio = await db;
    return Sqflite.firstIntValue(
        await dbRelatorio.rawQuery("SELECT COUNT(*) FROM $relatoriorioTable"));
  }

  Future<int?> getMaiorId() async {
    Database dbRelatorio = await db;
    return Sqflite.firstIntValue(
        await dbRelatorio.rawQuery("SELECT MAX(*) FROM $relatoriorioTable"));
  }

  Future close() async {
    Database dbRelatorio = await db;
    dbRelatorio.close();
  }
}
