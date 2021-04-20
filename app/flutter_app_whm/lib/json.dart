import 'dart:async' show Future;
import 'dart:convert';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_app_whm/voltageseries.dart';

Future<String> _loadJsonData() async {
  return await rootBundle.loadString('assets/data/dummy.json');
}

//int afterLength = 8;

Future loadJson() async {
  String jsonGraph = await _loadJsonData();
  print(jsonGraph);

  //String arrayObjsText =
  //    '{"datapoints": [{"time": "0.0001", "voltage": 1.067}, {"time": "0.002", "voltage": 1.767}, {"time": "0.04", "voltage": 0.067}]}';

  var tagObjsJson = await jsonDecode(jsonGraph)['datapoints'] as List;
  print(tagObjsJson);
  List<Datapoint> datapointObjs =
      tagObjsJson.map((dataJson) => Datapoint.fromJson(dataJson)).toList();

  print(datapointObjs);
  // final jsonMap = json.decode(jsonGraph);
  // List<Word> temp = (jsonMap['data'] as List)
  //     .map((itemWord) => Word.fromJson(itemWord))
  //     .toList();
  // // List<String> jsonList = jsonGraph.split('{');

  // // jsonList.removeRange(0, 2);
  // // // print(jsonList[0]);
  // // jsonList.removeLast();

  // // List<String> stringList = (jsonDecode(jsonGraph) as List<dynamic>);

  // // for (int i = 0; i < jsonList.length; i++) {
  // //   jsonList[i] = jsonList[i].substring(0, jsonList[i].length - afterLength);
  // //   print(jsonList[i]);
  // // }
  // return temp;
}

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class Datapoint {
  double time;
  double voltage;

  Datapoint(this.time, this.voltage);

  factory Datapoint.fromJson(dynamic json) =>
      Datapoint(json['time'] as double, json['voltage'] as double);

  @override
  String toString() {
    return '{ ${this.time}, ${this.voltage} }';
  }
}

class _MyAppState extends State<MyApp> {
  Future<Datapoint> futureDP;

  @override
  void initState() {
    loadJson();
    //super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}

// class Word {
//   double teste;

//   Word({this.teste});

//   Word.fromJson(Map<String, dynamic> json) {
//     teste = json['teste'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['teste'] = this.teste;
//     return data;
//   }
// }
