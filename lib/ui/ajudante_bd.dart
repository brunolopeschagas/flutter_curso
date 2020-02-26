import 'dart:io';
import 'dart:async';
import 'package:http_rest_app/modeos/Usuario.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class BDadosAjudante {
  static final BDadosAjudante _instancia = new BDadosAjudante.internal();

  factory BDadosAjudante() => _instancia;

  final String tabelaUsuario = "tbl_usuario";
  final String colId = "id";
  final String colNome = "nome";
  final String colSenha = "senha";

  BDadosAjudante.internal();

  static Database _db;
  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }

    return _db = await initDB();
  }

  initDB() async {
    Directory diretorioPadrao = await getApplicationDocumentsDirectory();
    String caminho = join(diretorioPadrao.path, "bd_principal.db");

    var nossoBD = await openDatabase(caminho, version: 1, onCreate: _onCreate);
    return nossoBD;
  }

  void _onCreate(Database db, int version) async {
    await db.execute("CREATE TABLE $tabelaUsuario ("
        "$colId INTEGER PRIMARY KEY,"
        "$colNome TEXT,"
        "$colSenha TEXT"
        ");");
  }

  Future<int> insertUsuario(Usuario usuario) async {
    Database bdCliente = await db;
    return await bdCliente.insert("$tabelaUsuario", usuario.toMap());
  }

  Future<List> pegarUsuarios() async {
    Database bdCliente = await db;
    var res = await bdCliente.rawQuery("SELECT * FROM $tabelaUsuario");

    return res.toList();
  }

  Future<Usuario> getUsuario(int id) async {
    Database bdCliente = await db;

    var res = await bdCliente
        .rawQuery("SELECT * FROM $tabelaUsuario WHERE $colId = $id");

    if (res.length > 0) {
      return new Usuario.map(res.first);
    }

    return null;
  }

  Future<int> delUsuario(int id) async {
    Database bdCliente = await db;
    return await bdCliente
        .delete("$tabelaUsuario", where: "$colId = ?", whereArgs: [id]);
  }

  Future<int> updateUsuario(Usuario usuario) async {
    Database bdCliente = await db;
    return await bdCliente.update("$tabelaUsuario", usuario.toMap(),
        where: "$colId = ?", whereArgs: [usuario.id]);
  }

  Future<int> getCount() async {
    Database bdCliente = await db;
    
    var x = await bdCliente.rawQuery('SELECT COUNT (*) from $tabelaUsuario');
    int count = Sqflite.firstIntValue(x);
    return count;
  }

  Future desconectar() async {
    Database bdCliente = await db;
    return bdCliente.close();
  }
}
