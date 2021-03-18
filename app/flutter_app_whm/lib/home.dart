import 'package:flutter/material.dart';
import 'package:flutter_app_whm/data_chart.dart';
import 'package:flutter_app_whm/voltageseries.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class HomePage extends StatelessWidget {
  final List<VoltageSeries> data = [
    VoltageSeries(
        time: 0.0,
        voltage: 0.1,
        lineColor: charts.ColorUtil.fromDartColor(Colors.blue)),
    VoltageSeries(
        time: 0.1,
        voltage: 1.5,
        lineColor: charts.ColorUtil.fromDartColor(Colors.blue)),
    VoltageSeries(
        time: 0.2,
        voltage: 2,
        lineColor: charts.ColorUtil.fromDartColor(Colors.blue)),
    VoltageSeries(
        time: 0.3,
        voltage: 1.8,
        lineColor: charts.ColorUtil.fromDartColor(Colors.blue)),
    VoltageSeries(
        time: 0.4,
        voltage: 2,
        lineColor: charts.ColorUtil.fromDartColor(Colors.blue)),
    VoltageSeries(
        time: 0.5,
        voltage: 1.5,
        lineColor: charts.ColorUtil.fromDartColor(Colors.blue)),
    VoltageSeries(
        time: 0.8,
        voltage: 1,
        lineColor: charts.ColorUtil.fromDartColor(Colors.blue)),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[50],
      appBar: AppBar(
        backgroundColor: Colors.lightBlue[400],
        centerTitle: true,
        title: Text('Wireless ECG Monitor'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              child: DataChart(
                data: data,
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
    );
  }
}
