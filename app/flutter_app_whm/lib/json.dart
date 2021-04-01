import 'dart:async' show Future;
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_app_whm/voltageseries.dart';
import 'datapoint.dart';

Future<String> _loadJsonData() async {
  return await rootBundle.loadString('assets/data/dummy.json');
}

//int afterLength = 8;

Future loadJson() async {
  String jsonGraph = await _loadJsonData();

  var tagObjsJson = jsonDecode(jsonGraph)['datapoints'] as List;
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
