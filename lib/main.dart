import 'package:flutter/material.dart';
import 'package:http_rest_app/modeos/Usuario.dart';
import 'package:http_rest_app/ui/ajudante_bd.dart';

List _listaUsers;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  BDadosAjudante db = new BDadosAjudante();

  //  int usuarioSalvo = await db.insertUsuario(new Usuario("Maria", "aleluia"));
  // usuarioSalvo = await db.insertUsuario(new Usuario("Maria", "aleluia"));
  //  print(usuarioSalvo);

  // int contagem = await db.getCount();
  // debugPrint("contagem = $contagem");

  //deleta o usuario
  // int apagou = await db.delUsuario(2);

  // contagem = await db.getCount();
  // debugPrint("contagem = $contagem");

  //recuperar usuario
  //  Usuario user = await db.getUsuario(2);
  //  debugPrint("Usuário : ${user.id}");
  //  debugPrint("Usuário : ${user.nome}");

  //update do usuario
  // Usuario usuario = new Usuario("Bruno", "123");
  // usuario.id = 2;
  // await db.updateUsuario(usuario);
  // Usuario userUpdated = await db.getUsuario(2);
  // debugPrint("Usuário : ${userUpdated.id}");
  // debugPrint("Usuário : ${userUpdated.nome}");

  // get todos os usuarios
  _listaUsers = await db.pegarUsuarios();

  Usuario usuario;

  // for (var usu in _listaUsers) {
  //   usuario = Usuario.map(usu);
  //   debugPrint("ID ${usuario.id}");
  //   debugPrint("NOME ${usuario.nome}");
  //   debugPrint("-------------------");
  // }

  // for (int i = 0; i < listaUsers.length; i++) {
  //   usuario = Usuario.map(listaUsers[i]);
  //   debugPrint("ID ${usuario.id}");
  //   debugPrint("NOME ${usuario.nome}");
  //   debugPrint("-------------------");
  // }

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
          child: new ListView.builder(
              itemCount: _listaUsers.length,
              itemBuilder: (context, int posicao) {
                return Card(
                  color: Colors.white,
                  elevation: 2.0,
                  child: ListTile(
                    leading: CircleAvatar(
                      child: Text(
                          "${Usuario.fromMap(_listaUsers[posicao]).nome.substring(0, 1)}"),
                    ),
                    title:
                        Text("${Usuario.fromMap(_listaUsers[posicao]).nome}"),
                    subtitle:
                        Text("${Usuario.fromMap(_listaUsers[posicao]).id}"),
                    onTap: () => debugPrint(
                        "${Usuario.fromMap(_listaUsers[posicao]).nome}"),
                  ),
                );
              }),
        ),
      ),
    );
  }
}
