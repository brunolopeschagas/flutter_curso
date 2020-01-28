import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

void main() {
  runApp(new MaterialApp(
    title: "i/o - input - output",
    home: new Home(),
  ));
}

class Home extends StatefulWidget {
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController _camposDadosControl = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        title: Text("Ler/Gravar"),
        centerTitle: true,
        backgroundColor: Colors.greenAccent,
      ),
      body: new Container(
          alignment: Alignment.topCenter,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                controller: _camposDadosControl,
                decoration: InputDecoration(labelText: "Escreva algo"),
              ),
              FlatButton(
                  color: Colors.greenAccent,
                  onPressed: () {
                    gravarDados(_camposDadosControl.text);
                  },
                  child: Text("Gravar")
              ),
              FutureBuilder(
                future: lerDados(),
                builder: (BuildContext context, AsyncSnapshot<String> dados){
                  if(dados.hasData != null){
                    return Text(dados.data);
                  }else{
                    return Text("nada foi salvo!");
                  }
                }),
            ],
          ),
      ),
    );
  }

  Future<String> get _caminhooLocal async {
    final DIRETORIO = await getApplicationDocumentsDirectory();
    return DIRETORIO.path;
  }

  Future<File> get _arquivoLocal async {
    final CAMINHO = await _caminhooLocal;
    return new File('$CAMINHO/dados.txt');
  }

  Future<File> gravarDados(String pMensagem) async {
    final ARQUIVO = await _arquivoLocal;
    return ARQUIVO.writeAsString('$pMensagem');
  }

  Future<String> lerDados() async {
    try {
      final arquivo = await _arquivoLocal;
      String dados = await arquivo.readAsString();
      return dados;
    } catch (e) {
      return "Não foi salvo nada!";
    }
  }
}
