import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/cupertino.dart';

class VoltageSeries {
  final double time;
  final double voltage;
  final charts.Color lineColor;

  VoltageSeries(
      {@required this.time, @required this.voltage, @required this.lineColor});
}
