import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() async{
  List dados = await getJson();

  printList(dados);

  runApp(new MyHomePage());
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
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

void printList(List pLista){
  for(int i = 0; i < pLista.length; i++){
    print(pLista[i]['name'] + ' - ' + pLista[i]['email']);
  }
}
