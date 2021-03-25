import 'dart:async' show Future;
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_app_whm/voltageseries.dart';

Future<String> _loadJsonData() async {
  return await rootBundle.loadString('assets/data/dummy.json');
}

int afterLength = 8;

Future loadJson() async {
  List<VoltageSeries> returndata;
  String jsonGraph = await _loadJsonData();
  List<String> jsonList = jsonGraph.split('{');

  jsonList.removeRange(0, 2);
  // print(jsonList[0]);
  jsonList.removeLast();

  List<String> stringList = (jsonDecode(jsonGraph) as List<dynamic>);

  for (int i = 0; i < jsonList.length; i++) {
    jsonList[i] = jsonList[i].substring(0, jsonList[i].length - afterLength);
    print(jsonList[i]);
  }
}
