import 'package:flutter/material.dart';
import 'package:flutter_app_whm/home.dart';
import 'dart:convert';
import 'datapoint.dart';

void main() {
  String json = '{"time": 0.1, "voltage": 1.0}';
  Datapoint datapoint = Datapoint.fromJson(jsonDecode(json));

  print(datapoint.toString());
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
