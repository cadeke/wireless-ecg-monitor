import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;

Future<String> _loadJsonData() async {
  return await rootBundle.loadString('assets/data/dummy.json');
}

Future loadJson() async {
  String jsonGraph = await _loadJsonData();
  print(jsonGraph);
}
