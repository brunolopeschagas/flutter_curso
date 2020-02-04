import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

void main() {
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
            children: <Widget>[

            ],
          ),
        ),
      ),
    );
  }

}
