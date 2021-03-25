import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:flutter_app_whm/voltageseries.dart';

class DataChart extends StatelessWidget {
  final List<VoltageSeries> data;

  DataChart({@required this.data});

  @override
  Widget build(BuildContext context) {
    List<charts.Series<dynamic, double>> series = [
      charts.Series(
          id: "Voltage",
          data: data,
          domainFn: (dynamic series, _) => series.time,
          measureFn: (dynamic series, _) => series.voltage,
          colorFn: (dynamic series, _) => series.lineColor)
    ];

    return Container(
      height: 400,
      padding: EdgeInsets.all(20),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Text(
                'ECG Data',
                style: Theme.of(context).textTheme.bodyText2,
              ),
              Expanded(
                child: charts.LineChart(series, animate: true),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
