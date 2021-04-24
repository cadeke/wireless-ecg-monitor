import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:flutter_http/voltageseries.dart';
import 'http_service.dart';

final HttpService httpService = HttpService();

class DataChart extends StatelessWidget {
  final List<VoltageSeries> data;
  String data1 = HttpService().getData().toString();

  DataChart({@required this.data});

  @override
  Widget build(BuildContext context) {
    List<charts.Series<VoltageSeries, double>> series = [
      charts.Series(
          id: "Voltage",
          data: data,
          domainFn: (VoltageSeries series, _) => series.time,
          measureFn: (VoltageSeries series, _) => series.voltage,
          colorFn: (VoltageSeries series, _) => series.lineColor)
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
