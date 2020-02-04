import 'dart:io';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class BDadosAjudante {
  static final BDadosAjudante _instancia = new BDadosAjudante.internal();
  static Database _db;

  factory BDadosAjudante() => _instancia;

  final String tabelaUsuario = "tbl_usuario";
  final String colId = "id";
  final String colNome = "nome";
  final String colSenha = "senha";

  BDadosAjudante.internal();

  Future<Database> get db async {
    if (null != _db) {
      return _db;
    }

    _db = await initDB();
  }

  initDB() async {
    Directory diretorioPadrao = await getApplicationDocumentsDirectory();
    String caminho = join(diretorioPadrao.path, "bd_principal.db");

    var nossoBD = await openDatabase(caminho, version: 1, onCreate: _onCreate);
    return nossoBD;
  }

  void _onCreate(Database db, int version) async {
    String sqlTblUsuario =
        "CREATE TABLE $tabelaUsuario ("
        "$colId INTEGER PRIMARY KEY,"
        "$colNome TEXT,"
        "$colSenha TEXT"
        ");";
    await db.execute(sqlTblUsuario);
  }

  Future<int> insertUsuario() async {}
}
