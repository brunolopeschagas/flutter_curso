import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(new MaterialApp(
    title: "i/o - input - output",
    home: new Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final String _PREFERENCE_KEY_DADOS = 'dados';
  final TextEditingController _dadosController = new TextEditingController();
  String _dadosSalvos = "";

  @override
  // este metodo executa no momento que a activity e executada
  void initState() {
    super.initState();
    _pegarDados();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Shared Preferences"),
          centerTitle: true,
          backgroundColor: Colors.deepOrange,
        ),
        body: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              TextField(
                controller: _dadosController,
                decoration:
                    InputDecoration(labelText: 'Escreva algo para salvar...'),
              ),
              FlatButton(
                onPressed: () {
                  salvar(_dadosController.text);
                },
                child: Text('Salvar'),
                color: Colors.deepOrange,
              ),
              Text("Dados salvos: $_dadosSalvos"),
            ],
          ),
        ),
      ),
    );
  }

  void salvar(String dado) {
    _salvarDados(dado);
    _pegarDados();
  }

  void _pegarDados() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String info = preferences.getString(_PREFERENCE_KEY_DADOS);
    setState(() {
      if (null != info && info.isNotEmpty) {
        _dadosSalvos = info;
      } else {
        _dadosSalvos = 'Nenhum dado.';
      }
    });
  }

  void _salvarDados(String pMensagem) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString(_PREFERENCE_KEY_DADOS, pMensagem);
  }
}
