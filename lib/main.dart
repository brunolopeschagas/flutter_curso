import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() async {
  List _dados = await jsonComplexo();

  /*JSON COMPLEXO DO EXEMPLO
  [
  {
    "id": 1,
    "name": "Leanne Graham",
    "username": "Bret",
    "email": "Sincere@april.biz",
    "address": {
      "street": "Kulas Light",
      "suite": "Apt. 556",
      "city": "Gwenborough",
      "zipcode": "92998-3874",
      "geo": {
        "lat": "-37.3159",
        "lng": "81.1496"
      }
    },
    "phone": "1-770-736-8031 x56442",
    "website": "hildegard.org",
    "company": {
      "name": "Romaguera-Crona",
      "catchPhrase": "Multi-layered client-server neural-net",
      "bs": "harness real-time e-markets"
    }
  },.....
  ]
   */
//
//  for (int i = 0; i < _dados.length; i++) {
//    debugPrint("USER = ${_dados[i]['username']}");
//    debugPrint("ADDRESS = ${_dados[i]['address']['street']}");
//    debugPrint("GEO = ${_dados[i]['address']['geo']['lat']}, ${_dados[i]['address']['geo']['lng']}");
//  }

  runApp(new MaterialApp(
    home: Scaffold(
        appBar: AppBar(
          title: Text("JSON"),
        ),
        body: Center(
          child: ListView.builder(
            itemCount: _dados.length,
            padding: const EdgeInsets.all(8),
            itemBuilder: (BuildContext context, int posicao) {
              return Column(
                children: <Widget>[
                  Divider(height: 4.5),
                  ListTile(
                    title: Text(
                        "${_dados[posicao]['name']}"
                    ),
                    subtitle: Text(
                        "${_dados[posicao]['address']['street']}\n"
                        "${_dados[posicao]['address']['geo']['lat']},"
                        "${_dados[posicao]['address']['geo']['lng']}\n"
                    ),
                    leading: CircleAvatar(
                      backgroundColor: Colors.greenAccent,
                      child: Text(
                          "${_dados[posicao]['username'][0]}"
                      ),
                    ),
                  onTap: () => _mostrarMensagem(context, "Você clicou no ${_dados[posicao]['name']}"),
                  ),
                ],
              );
            },
          ),
        )
    ),
  ));
}

void _mostrarMensagem(BuildContext context, String mensagem) {
  var alerta = new AlertDialog(
    title: Text('JSON'),
    content: Text(mensagem),
    actions: <Widget>[
      FlatButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: Text("OK"),
      )
    ],
  );

  showDialog(context: context, builder: (context) => alerta);
}

//Lê o json de forma assincrona
Future<List> jsonComplexo() async {
  String url = 'https://jsonplaceholder.typicode.com/users';
  http.Response response = await http.get(url);
  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception("Falhou");
  }
}
