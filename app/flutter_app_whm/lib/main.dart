import 'package:flutter/material.dart';
import 'package:flutter_app_whm/home.dart';
import 'dart:convert';
import 'datapoint.dart';

void main() {
  String arrayObjsText =
      '{"tags": [{"time": 0.1, "voltage": 1.0}, {"time": 0.2, "voltage": 2.0}, {"time": 0.3, "voltage": 1.5}]}';

  var tagObjsJson = jsonDecode(arrayObjsText)['tags'] as List;
  List tagObjs =
      tagObjsJson.map((tagJson) => Datapoint.fromJson(tagJson)).toList();

  print(tagObjs);
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
