import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() async {
  List _dados = await getJson();

  printList(_dados);

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
                        "${_dados[posicao]['email']}"
                    ),
                    subtitle: Text(
                        "${_dados[posicao]['body']}"
                    ),
                    leading: CircleAvatar(
                      backgroundColor: Colors.blueAccent,
                      child: Text(
                        "${_dados[posicao]['email'][0]}"
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        )
    ),
  )
  );
}

//Lê o json de forma assincrona
Future<List> getJson() async {
  String url = 'https://jsonplaceholder.typicode.com/comments';
  http.Response response = await http.get(url);
  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception("Falhou");
  }
}

void printList(List pLista) {
  for (int i = 0; i < pLista.length; i++) {
    print(pLista[i]['name'] + ' - ' + pLista[i]['email']);
  }
}
