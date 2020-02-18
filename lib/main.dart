import 'package:flutter/material.dart';
import 'package:http_rest_app/modeos/Usuario.dart';
import 'package:http_rest_app/ui/ajudante_bd.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  BDadosAjudante db = new BDadosAjudante();

  // int usuarioSalvo = await db.insertUsuario(new Usuario("Maria", "aleluia"));
  // usuarioSalvo = await db.insertUsuario(new Usuario("Maria", "aleluia"));
  // print(usuarioSalvo);

  //recuperar usuario
  Usuario user = await db.getUsuario(2);
  debugPrint("Usuário : ${user.id}");
  debugPrint("Usuário : ${user.nome}");

  //update do usuario
  Usuario usuario = new Usuario("Bruno", "123");
  usuario.id = 2;
  await db.updateUsuario(usuario);
  Usuario userUpdated = await db.getUsuario(2);
  debugPrint("Usuário : ${userUpdated.id}");
  debugPrint("Usuário : ${userUpdated.nome}");

  runApp(new MaterialApp(
    title: "Base de dados SQFlite",
    home: new Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("SQFlite"),
          centerTitle: true,
          backgroundColor: Colors.black38,
        ),
        body: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            children: <Widget>[],
          ),
        ),
      ),
    );
  }
}
