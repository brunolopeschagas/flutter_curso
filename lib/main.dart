import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';

//import para http
import 'package:http/http.dart' as http; // adicionar o import no pubspec http: ^0.12.0+2

//imports para datas
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';


void main() async {
  Map _dados = await jsonComplexoMaps();
  List _features = _dados['features'];

  //config para datas em portugues
  initializeDateFormatting("pt_BR", null);
  DateFormat _dateFormat = new DateFormat.yMMMd("pt_BR");

  /*JSON COMPLEXO DO EXEMPLO
  {
  "type": "FeatureCollection",
  "metadata": {
    "generated": 1579136519000,
    "url": "https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_day.geojson",
    "title": "USGS All Earthquakes, Past Day",
    "status": 200,
    "api": "1.8.1",
    "count": 321
  },
  "features": [
    {
      "type": "Feature",
      "properties": {
        "mag": 1.26,
        "place": "7km NE of Coso Junction, CA",
        "time": 1579136115650,
        "updated": 1579136332112,
        "tz": -480,
        "url": "https://earthquake.usgs.gov/earthquakes/eventpage/ci39271752",
        "detail": "https://earthquake.usgs.gov/earthquakes/feed/v1.0/detail/ci39271752.geojson",
        "felt": null,
        "cdi": null,
        "mmi": null,
        "alert": null,
        "status": "automatic",
        "tsunami": 0,
        "sig": 24,
        "net": "ci",
        "code": "39271752",
        "ids": ",ci39271752,",
        "sources": ",ci,",
        "types": ",geoserve,nearby-cities,origin,phase-data,scitech-link,",
        "nst": 16,
        "dmin": 0.04205,
        "rms": 0.15,
        "gap": 170,
        "magType": "ml",
        "type": "earthquake",
        "title": "M 1.3 - 7km NE of Coso Junction, CA"
      },
      "geometry": {
        "type": "Point",
        "coordinates": [
          -117.8848333,
          36.0831667,
          1.9
        ]
      },
      "id": "ci39271752"
    },,.....
  }
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
          title: Text("Terremotos"),
        ),
        body: Center(
          child: ListView.builder(
            itemCount: _features.length,
            padding: const EdgeInsets.all(8),
            itemBuilder: (BuildContext context, int posicao) {
              return Column(
                children: <Widget>[
                  Divider(height: 4.5),
                  ListTile(
                    title: Text(
                        formatDate(
                            _features[posicao]['properties']['time'],
                            _dateFormat
                        )
                    ),
                    subtitle: Text(
                        "${_features[posicao]['properties']['place']}\n"
                    ),
                    leading: CircleAvatar(
                      backgroundColor: Colors.greenAccent,
                      child: Text(
                          "${_features[posicao]['properties']['mag']}"
                      ),
                    ),
                    onTap: () =>
                        _mostrarMensagem(
                            context,
                            "${_features[posicao]['properties']['title']}"
                        ),
                  ),
                ],
              );
            },
          ),
        )
    ),
  ));
}

String formatDate(int pTimeUnix, DateFormat pDateFormart) {
  return pDateFormart.format(
      new DateTime.fromMicrosecondsSinceEpoch(
          pTimeUnix * 1000
      )
  );
}

void _mostrarMensagem(BuildContext context, String mensagem) {
  var alerta = new AlertDialog(
    title: Text('Terremoto'),
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
Future<Map> jsonComplexoMaps() async {
  String url = 'https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_day.geojson';
  http.Response response = await http.get(url);
  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception("Falhou");
  }
}
