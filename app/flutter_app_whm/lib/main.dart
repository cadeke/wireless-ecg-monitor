import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.lightBlue[50],
        appBar: AppBar(
          title: Text('Wireless ECG Monitor'),
          centerTitle: true,
          backgroundColor: Colors.lightBlue[400],
        ),
      ),
    );
  }
}
