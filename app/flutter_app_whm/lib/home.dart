import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_app_whm/data_chart.dart';
import 'package:flutter_app_whm/voltageseries.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'json.dart';

class HomePage extends StatelessWidget {
  static double timeNumber = 0.0;
  final List<VoltageSeries> data = [
    VoltageSeries(
        time: timeNumber,
        voltage: 1,
        lineColor: charts.ColorUtil.fromDartColor(Colors.red)),
    VoltageSeries(
        time: 0.1,
        voltage: 1,
        lineColor: charts.ColorUtil.fromDartColor(Colors.red)),
    VoltageSeries(
        time: 0.2,
        voltage: 2,
        lineColor: charts.ColorUtil.fromDartColor(Colors.red)),
    VoltageSeries(
        time: 0.3,
        voltage: 0.1,
        lineColor: charts.ColorUtil.fromDartColor(Colors.red)),
    VoltageSeries(
        time: 0.4,
        voltage: 1,
        lineColor: charts.ColorUtil.fromDartColor(Colors.red)),
    VoltageSeries(
        time: 0.5,
        voltage: 1,
        lineColor: charts.ColorUtil.fromDartColor(Colors.red)),
    VoltageSeries(
        time: 0.6,
        voltage: 1,
        lineColor: charts.ColorUtil.fromDartColor(Colors.red)),
    VoltageSeries(
        time: 0.7,
        voltage: 1,
        lineColor: charts.ColorUtil.fromDartColor(Colors.red)),
    VoltageSeries(
        time: 0.8,
        voltage: 2,
        lineColor: charts.ColorUtil.fromDartColor(Colors.red)),
    VoltageSeries(
        time: 1,
        voltage: 0.1,
        lineColor: charts.ColorUtil.fromDartColor(Colors.red)),
    VoltageSeries(
        time: 1.1,
        voltage: 1,
        lineColor: charts.ColorUtil.fromDartColor(Colors.red)),
    VoltageSeries(
        time: 1.2,
        voltage: 1,
        lineColor: charts.ColorUtil.fromDartColor(Colors.red)),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red[50],
      appBar: AppBar(
        backgroundColor: Colors.red[900],
        centerTitle: true,
        title: Text('Wireless ECG Monitor'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              child: DataChart(
                data: loadJson(),
              ),
            ),
            Container(
              width: 300,
              height: 300,
              child: Center(
                child: Text('ECG monitor'),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            // ignore: deprecated_member_use
            title: Text('Home'),
            backgroundColor: Colors.red[900],
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            // ignore: deprecated_member_use
            title: Text('Search'),
            backgroundColor: Colors.red[900],
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu),
            // ignore: deprecated_member_use
            title: Text('Menu'),
            backgroundColor: Colors.red[900],
          )
        ],
      ),
    );
  }
}
