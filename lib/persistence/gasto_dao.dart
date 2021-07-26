//@dart=2.9
import 'dart:io';
import 'package:gastos_marcos_sousa/model/gasto.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class GastoDao {
  static final _databaseName = "gasto.db";
  static final _databaseVersion = 1;
  static final table = "gastotable";
  static final _id = "_id";
  static final _ano = "ano";
  static final _dia = "dia";
  static final _mes = "mes";
  static final _finalidade = "finalidade";
  static final _valor = "valor";

  GastoDao._privateConstructor();
  static final GastoDao instance = GastoDao._privateConstructor();
  static Database _database; //check later

  Future<Database> get database async {
    if (_database != null) return _database; //check later
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute("""
      CREATE TABLE $table (
        $_id INTEGER PRIMARY KEY,
        $_ano INTEGER NOT NULL,
        $_dia INTEGER NOT NULL,
        $_mes TEXT NOT NULL,
        $_finalidade TEXT NOT NULL,
        $_valor REAL NOT NULL
      )
    """);
  }

  static Future<int> inserir(Gasto gasto) async {
    var result = 0;
    try {
      Database db = await instance.database;
      result = await db.insert(table, gasto.getGasto()); //check later
    } on Exception catch (e) {
      return 0;
    }
    return result;
  }

  static Future<List<Gasto>> findAll() async {
    var result;
    List<Gasto> gastos;
    try {
      final Database db = await instance.database;
      result = await db.query(table);
      gastos = _toList(result);
    } on Exception catch (e) {
      return null;
    }
    return gastos;
  }

  static List<Gasto> _toList(List<Map<String, dynamic>> result) {
    final List<Gasto> gastos = List();
    for (Map<String, dynamic> row in result) {
      final Gasto gasto = Gasto(row[_id], row[_ano], row[_dia], row[_mes],
          row[_finalidade], row[_valor]);
      gastos.add(gasto);
    }
    return gastos;
  }

  static Future<int> alterar(Gasto gasto) async {
    var result = 0;
    try {
      Database db = await instance.database;
      result = await db.update(table, gasto.getGasto(),
          where: "$_id = ?", whereArgs: [gasto.id]);
    } on Exception catch (e) {
      return 0;
    }
    return result;
  }

  static Future<int> excluir(int id) async {
    var result = 0;
    try {
      Database db = await instance.database;
      result = await db.delete(table, where: "$_id = ?", whereArgs: [id]);
    } on Exception catch (e) {
      return 0;
    }
    return result;
  }
}
